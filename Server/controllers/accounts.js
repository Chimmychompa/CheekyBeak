const knex = require('../knex')
const crypto = require('crypto')

const formatAccount = account => ({
    accountId: account.account_id,
    email: account.email,   
    firstName: account.first_name,
    lastName: account.last_name,     
})

const formatPassword = account => ({    
    password: account.password_hash,
    salt: account.password_salt
})

exports.createAccount = async (req, res) => {    
    const { firstname, lastname, email, password } = req.body
    const hashObj = saltHashPassword(password).passwordHash    
    const passHash = hashObj.passwordHash
    const salt = hashObj.salt
    try {
        const dirtyAccount = await knex.call(`CreateAccount('${email}', '${passHash}', '${salt}', '${firstname}', '${lastname}')`)         
        if (!dirtyAccount[0][0][0]) {            
            return res.status(500).send()
        }
        const createdAccount = formatAccount(dirtyAccount[0][0][0])
        return res.json(createdAccount)        
    } catch (err) {        
        if (err.errno == 1062 || err.code == 'ER_DUP_ENTRY') {
            return res.status(400).send('An account with that email already exists.')
        }
    }
}

exports.authenticateAccount = async(req, res) => {
    const { email, password } = req.query    
    const dirtyAccount = await knex.call(`AuthenticateAccount('${email}')`)
    if (!dirtyAccount[0][0][0]) {
        return res.status(401).send('Invalid email supplied.')
    }
    const passwordInfo = formatPassword(dirtyAccount[0][0][0])        
    const passwordCheck = hashPassword(password, passwordInfo.salt).passwordHash
    if(passwordCheck != passwordInfo.password){
        return res.status(401).send('Invalid password supplied.')
    }
    const account = formatAccount(dirtyAccount[0][0][0])  
    if (account) {
        return res.json(account)
    }
}

/**
 * Generates random string of characters (salt)
 * @function
 * @param {number} length - Length of the random string
 */
var randomString = function(length){
    return crypto.randomBytes(Math.ceil(length/2)).toString('hex').slice(0, length)
}

/**
 * Hash password with sha512.
 * @function
 * @param {string} password - The password to be hashed.
 * @param {string} salt - The salt
 */
var hashPassword = function(password, salt){
    var hash = crypto.createHmac('sha512', salt)
    hash.update(password)
    var value = hash.digest('hex')
    return {
        salt: salt,
        passwordHash: value
    }
}

/**
 * Hashes the given password and returns salt and hashed password.
 * @function
 * @param {string} password - The password to be salted and hashed.
 */
function saltHashPassword(password) {
    var salt = randomString(16); /** Gives us salt of length 16 */
    var passwordData = hashPassword(password, salt);
    return {
        salt: salt,
        passwordHash: passwordData
    }
}