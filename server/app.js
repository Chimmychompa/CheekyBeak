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

app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});

module.exports = app