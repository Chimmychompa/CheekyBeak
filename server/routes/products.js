const productController = require('../controllers/products')
const {catchErrors} = require('../handlers/errorHandlers')

function setupProductRoutes(router) {
    router.get('/', catchErrors(productController.getAllProducts))
}

module.exports = setupProductRoutes