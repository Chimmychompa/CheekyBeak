const orderController = require('../controllers/orders')
const {catchErrors} = require('../handlers/errorHandlers')

function setupOrderRoutes(router) {
    router.post('/', catchErrors(orderController.createOrder)),
    router.post('/lines', catchErrors(orderController.createOrderLines))
}

module.exports = setupOrderRoutes