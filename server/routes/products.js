const productController = require('../controllers/products')
const {catchErrors} = require('../handlers/errorHandlers')

function setupProductRoutes(router) {
    router.get('/', catchErrors(productController.getAllProducts))
    router.get('/baby', catchErrors(productController.getBaby))
    router.get('/birthday', catchErrors(productController.getBirthday))
    router.get('/congratulations', catchErrors(productController.getCongrats))
    router.get('/friend-everyday', catchErrors(productController.getFriendEveryday))
    router.get('/holiday', catchErrors(productController.getHoliday))
    router.get('/love', catchErrors(productController.getLove))
    router.get('/moms-dads', catchErrors(productController.getMomDad))
    router.get('/sympathy', catchErrors(productController.getSympathy))
    router.get('/thank-you', catchErrors(productController.getThanks))
    router.get('/:id', catchErrors(productController.getProduct))
}

module.exports = setupProductRoutes