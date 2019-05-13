const express = require('express')
const setupProductRoutes = require('./products')

function setupRoutes(app) {
    app.use(function(req, res, next) {
        res.header("Access-Control-Allow-Origin", "*");        
        next();
    });

    const productRouter = express.Router()
    setupProductRoutes(productRouter)
    app.use('/api/products', productRouter)
}

module.exports = setupRoutes
