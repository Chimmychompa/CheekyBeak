const knex = require('knex')({
    client: 'mysql',
    connection: {
      host: 'localhost',
      user: 'root',
      password: 'root',
      database: 'cheekybeak',
      options: {
        encrypt: true,
      },
    },
})
  
knex.table = table => knex.withSchema('cheekybeak').table(table)
knex.call = procedureName => knex.raw(`call ${procedureName}`)
module.exports = knex