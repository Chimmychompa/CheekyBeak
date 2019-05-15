const accountController = require('../controllers/accounts')
const {catchErrors} = require('../handlers/errorHandlers')

function setupAccountRoutes(router) {
    router.get('/', catchErrors(accountController.authenticateAccount)),
    router.post('/', catchErrors(accountController.createAccount))
}

module.exports = setupAccountRoutes