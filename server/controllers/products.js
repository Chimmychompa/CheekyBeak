const knex = require('../knex')
/*
const formatProduct = (product) => {    
    var formattedProduct = {
        productId: product.product_id,
        productCategoryId: product.product_category_id,
        imageUrl: product.image_url,
        price: product.price,
        wholesalePrice: product.wholesale_price,
        productDescription: product.product_description
}
return formatProduct}
*/
const formatProduct = product => ({
    productId: product.product_id,
    productCategoryId: product.product_category_id,
    imageUrl: product.image_url,
    price: product.price,
    wholesalePrice: product.wholesale_price,
    productDescription: product.product_description
})

exports.getAllProducts = async (req, res) => {
    const dirtyProducts = await knex.call('GetAllProducts')    
    const products = await dirtyProducts[0][0].map(formatProduct)
    console.dir(products)
    return res.json(products)
}