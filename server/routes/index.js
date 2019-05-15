const express = require('express')
const setupProductRoutes = require('./products')
const setupInfoRoutes = require('./info')
const setupAccountRoutes = require('./accounts')
const setupOrderRoutes = require('./orders')

function setupRoutes(app) {
    app.use(function(req, res, next) {
        res.header("Access-Control-Allow-Origin", "*");        
        next();
    });

    const productRouter = express.Router()
    setupProductRoutes(productRouter)
    app.use('/api/products', productRouter)

    const infoRouter = express.Router()
    setupInfoRoutes(infoRouter)
    app.use('/api/info', infoRouter)

    const accountRouter = express.Router()
    setupAccountRoutes(accountRouter)
    app.use('/api/accounts', accountRouter)

    const orderRouter = express.Router()
    setupOrderRoutes(orderRouter)
    app.use('/api/orders', orderRouter)
}

module.exports = setupRoutes
