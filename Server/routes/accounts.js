const accountController = require('../controllers/accounts')
const {catchErrors} = require('../handlers/errorHandlers')

function setupAccountRoutes(router) {
    router.post('/', catchErrors(accountController.createAccount))
}

module.exports = setupAccountRoutes