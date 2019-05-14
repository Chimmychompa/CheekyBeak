const knex = require('../knex')

const formatProduct = product => ({
    productId: product.product_id, 
    imageUrl: product.image_url,
    price: product.price,
    isSale: product.is_sale,
    description: product.product_description    
})

exports.getAllProducts = async (req, res) => {
    const dirtyProducts = await knex.call('GetAllProducts')    
    const products = await dirtyProducts[0][0].map(formatProduct)    
    return res.json(products)
}

exports.getBaby = async (req, res) => {
    const dirtyProducts = await knex.call('GetBaby')    
    const products = await dirtyProducts[0][0].map(formatProduct)
    return res.json(products)
}

exports.getBirthday = async (req, res) => {
    const dirtyProducts = await knex.call('GetBirthday')    
    const products = await dirtyProducts[0][0].map(formatProduct)
    return res.json(products)
}

exports.getCongrats = async (req, res) => {
    const dirtyProducts = await knex.call('GetCongratulations')    
    const products = await dirtyProducts[0][0].map(formatProduct)
    return res.json(products)
}

exports.getFriendEveryday = async (req, res) => {
    const dirtyProducts = await knex.call('GetFriendshipEveryday')    
    const products = await dirtyProducts[0][0].map(formatProduct)
    return res.json(products)
}

exports.getHoliday = async (req, res) => {
    const dirtyProducts = await knex.call('GetHoliday')    
    const products = await dirtyProducts[0][0].map(formatProduct)
    return res.json(products)
}

exports.getLove = async (req, res) => {
    const dirtyProducts = await knex.call('GetLove')    
    const products = await dirtyProducts[0][0].map(formatProduct)
    return res.json(products)
}

exports.getMomDad = async (req, res) => {
    const dirtyProducts = await knex.call('GetMomsDads')    
    const products = await dirtyProducts[0][0].map(formatProduct)
    return res.json(products)
}

exports.getSympathy = async (req, res) => {
    const dirtyProducts = await knex.call('GetSympathy')    
    const products = await dirtyProducts[0][0].map(formatProduct)
    return res.json(products)
}

exports.getThanks = async (req, res) => {
    const dirtyProducts = await knex.call('GetThankYou')    
    const products = await dirtyProducts[0][0].map(formatProduct)
    return res.json(products)
}

exports.getSale = async (req, res) => {
    const dirtyProducts = await knex.call('GetSale')    
    const products = await dirtyProducts[0][0].map(formatProduct)
    return res.json(products)
}

exports.getProduct = async (req, res) => {
    const id = req.params['id']
    const dirtyProduct = await knex.call(`GetProduct(${id})`)
    if (!dirtyProduct[0][0][0]) {
      return res.status(404).send('Product not found.')
    }
    const product = formatProduct(dirtyProduct[0][0][0])
    return res.json(product)
}