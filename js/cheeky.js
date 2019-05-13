

//spaceship
var product = {
  //spaceship should start around the center of the screen
  productId: ,
  imageUrl: ,
  price: ,
  isSale:

}

var product_list = [];
var jsonString = "[{'productId':3,'imageUrl':'BBY101 product photo.jpg','price':4.5,'isSale':0},{'productId':4,'imageUrl':'BBY102 product photo.jpg','price':4.5,'isSale':0},{'productId':5,'imageUrl':'BBY104 product photo.jpg','price':4.5,'isSale':0},{'productId':6,'imageUrl':'BBY105 product photo.jpg','price':4.5,'isSale':0},{'productId':7,'imageUrl':'BBY106 product photo.jpg','price':4.5,'isSale':0}]"
//funciton to read JSON inptu and transalte it to js object
function JSON_to_Object(jsonprodlist){
  for prod in jsonprodlist{
    prod = Product(prod["productId"], prod["imageUrl"], prod["price"],prod["isSale"]);
    product_list.push();
  }

}

//Contructor funciton for product
function Product(id, img, price, sale){
  var prod = {
    productId: id,
    imageUrl: img,
    price: price,
    isSale: sale
  }
  return prod;
}

JSON_to_Object(jsonString);
