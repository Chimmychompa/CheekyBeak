const express = require('express')
const setupProductRoutes = require('./products')

function setupRoutes(app) {
    const productRouter = express.Router()
    setupProductRoutes(productRouter)
    app.use('/api/products', productRouter)
}

module.exports = setupRoutes