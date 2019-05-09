const knex = require('../knex')

const formatProduct = product => ({
    productId: product.product_id,
    productCategoryId: product.product_category_id,
    imageUrl: product.image_url,
    price: product.price,
    wholesalePrice: product.wholesale_price,
    productDescription: product.product_description
})

exports.getAllProducts = async (req, res) => {
    //const dirtyProducts = await knex.call('GetAllProducts')
    //const products = dirtyProducts.map(formatProduct)
    return res.send('hello')
}