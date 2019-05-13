const knex = require('../knex')

const formatStockist = stockist => ({
    Name: stockist.name, 
    State: stockist.state,
    City: stockist.city      
})

exports.getStockists = async (req, res) => {
    const dirtyProducts = await knex.call('GetStockists')    
    const stockists = await dirtyProducts[0][0].map(formatStockist)    
    return res.json(stockists)
}