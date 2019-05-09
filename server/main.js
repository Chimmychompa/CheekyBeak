const app = require('./app')
const PORT = process.env.PORT || 3000

// Starting express
if (!module.parent) {
  app.listen(PORT, err => {
    if (err) console.error(err)
    console.log(`Express server started on port ${PORT}`)
  })
}