//gift card product
var product = {
  productId: 0,
  imageUrl: ' ',
  price: 0.00,
  isSale: false

}

var product_list = [];
var jsonString = [{'productId':3,'imageUrl':'BBY101 product photo.jpg','price':4.5,'isSale':0},{'productId':4,'imageUrl':'BBY102 product photo.jpg','price':4.5,'isSale':0},{'productId':5,'imageUrl':'BBY104 product photo.jpg','price':4.5,'isSale':0},{'productId':6,'imageUrl':'BBY105 product photo.jpg','price':4.5,'isSale':0},{'productId':7,'imageUrl':'BBY106 product photo.jpg','price':4.5,'isSale':0}]
var shop = document.getElementById('shop-container');
var urlParams = new URLSearchParams(window.location.search);


//funciton to read JSON inptu and transalte it to js object
function JSON_to_Object(jsonprodlist){
  for (prod in jsonprodlist){
    item = jsonprodlist[prod];
    product = Product(item.productId, item.imageUrl, item.price, item.isSale);
    product_list.push(product);
  }

}

//fills the shop section with imgs and data THEN IT CLEARS THE LIST OF PRODUCTS
function render_Images(){
  //clears the shop
  shop.innerHTML = ' ';

  //builds shop
  for(item in product_list){
    prod = product_list[item];
    shop.innerHTML += "<div class='col-md-3'><img class='instapic' src='img/prod/" + prod.imageUrl + "'></div>"
  }

  product_list = [];
}

//funciton to get the JSON string from URL
var getJSON = function(url, callback) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);
    xhr.responseType = 'json';
    xhr.onload = function() {
      var status = xhr.status;
      if (status === 200) {
        callback(null, xhr.response);
      } else {
        callback(status, xhr.response);
      }
    };
    xhr.send();
};

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

//chekcs type of producto display and displays them
function checkType(){
  //get the query string here
  var type = urlParams.get('prodtype');
  var url = 'http://localhost:3000/api/products/'+ type;
  getJSON(url,
  function(err, data) {
    if (err !== null) {
      alert('Something went wrong: ' + err);
    } else {
      JSON_to_Object(data);
      render_Images();
    }
  });
}
