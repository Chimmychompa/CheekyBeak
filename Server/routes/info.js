const infoController = require('../controllers/info')
const {catchErrors} = require('../handlers/errorHandlers')

function setupInfoRoutes(router) {
    router.get('/stockists', catchErrors(infoController.getStockists))    
}

module.exports = setupInfoRoutes