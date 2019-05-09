const express = require('express')
const bodyParser = require('body-parser')
const errorHandlers = require('./handlers/errorHandlers')
const setupRoutes = require('./routes')

const app = express()

setupRoutes(app)

const isDevelopment = true; //process.env.NODE_ENV !== 'production'

app.use(errorHandlers.notFound)
if(isDevelopment) {
    app.use(errorHandlers.developmentErrors)
}
app.use(errorHandlers.productionErrors)

module.exports = app