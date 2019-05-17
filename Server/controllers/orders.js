const knex = require('../knex')

const formatOrderLine = orderLine => ({
    orderId: orderLine.order_id,
    productId: orderLine.product_id,
    price: orderLine.price,
    quantity: orderLine.quantity
})

exports.createOrder = async (req, res) => {
    const {email, first, last, add, city, state, zip, phone} = req.body
    const dirtyOrderId = await knex.call(`CreateOrder('${email}', '${first}', '${last}', '${add}', '${city}', '${state}', '${zip}', '${phone}')`)
    if (!dirtyOrderId[0][0][0]) {            
        return res.status(500).send()
    }
    return res.json(dirtyOrderId[0][0][0].order_id)
}

exports.createOrderLines = async (req, res) => {
    const jsonLines = req.body    
    for (i = 0; i < jsonLines.length ; i++){
        line = jsonLines[i]        
        const dirtyOrderLineId = await knex.call(`CreateOrderLine(${line.orderID}, ${line.id}, ${line.price}, ${line.quantity})`)
        if (!dirtyOrderLineId[0][0][0]) {            
            return res.status(500).send()
        }
    }
    return res.status(200).send("Order lines added successfully.")    
}