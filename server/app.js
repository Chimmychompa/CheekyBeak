const express = require('express')
const bodyParser = require('body-parser')
const errorHandlers = require('./handlers/errorHandlers')
const setupRoutes = require('./routes')
const cors = require('cors')

const app = express()
app.use(cors())

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))

setupRoutes(app)

const isDevelopment = true; //process.env.NODE_ENV !== 'production'

app.use(errorHandlers.notFound)
if(isDevelopment) {
    app.use(errorHandlers.developmentErrors)
}
app.use(errorHandlers.productionErrors)

module.exports = app