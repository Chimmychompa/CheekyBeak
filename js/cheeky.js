//gift card product
var product = {
  productId: 0,
  imageUrl: ' ',
  price: 0.00,
  isSale: false

}

//selected product
var selectedprod = {
    imageUrl: ' ',
    price: 0.00,
    description: ' '
}

//stockist
var stockist = {
  name:  ' ',
  state: ' ',
  city:  ' '
}

//one cart item
var cart_item = {
  id: 0,
  quantity: 0,
  price: 0,
  imgUrl: ' '
}

//list of cart items
var cart = {
  items: [],
  quantity: 0
};

var customerInfo = {
  firstname: ' ',
  lastname: ' ',
  email: ' ',
  phone: 0,
  address: ' ',
  city: ' ',
  state: ' ',
  zip: 0
}
//list of stockist
var stockist_list = [];
//list of products for shop / sale page
var product_list = [];

//test string
var jsonString = [{'productId':3,'imageUrl':'BBY101 product photo.jpg','price':4.5,'isSale':0},{'productId':4,'imageUrl':'BBY102 product photo.jpg','price':4.5,'isSale':0},{'productId':5,'imageUrl':'BBY104 product photo.jpg','price':4.5,'isSale':0},{'productId':6,'imageUrl':'BBY105 product photo.jpg','price':4.5,'isSale':0},{'productId':7,'imageUrl':'BBY106 product photo.jpg','price':4.5,'isSale':0}]
var shop = document.getElementById('shop-container');
var stockists = document.getElementById('stockist-container');
var cartnum = document.getElementById('cartnumber');
var shoppingcartDisplay = document.getElementById('shoppingcartbody');
var IMG = document.getElementById('selectedprodIMG');
var selectedprodINFO = document.getElementById('selectedprodINFO');
var urlParams = new URLSearchParams(window.location.search);


//functon to read JSON input and transalte it to js product object
function JSON_to_product_Object(jsonprodlist){
  for (prod in jsonprodlist){
    item = jsonprodlist[prod];
    product = Product(item.productId, item.imageUrl, item.price, item.isSale);
    product_list.push(product);
  }

}



function JSON_to_selected_product_Object(jsonprodlist){

  item = jsonprodlist;
  selectedprod = SelectedProduct(item.imageUrl, item.price, item.description);

}

//functon to read JSON input and transalte it to js stockist object
function JSON_to_stockist_Object(jsonstockistlist){
  for (prod in jsonstockistlist){
    item = jsonstockistlist[prod];
    stockist = Stockist(item.Name, item.State, item.City);
    stockist_list.push(stockist);
  }

}

//fills in the stockists page with stockists
function render_Stockist(){
  //clears the shop
  stockists.innerHTML = ' ';

  //builds shop
  for(item in stockist_list){
    prod = stockist_list[item];
    stockists.innerHTML +=  "<div margin='auto'><p>" + prod.name + " - " + prod.state + ", " + prod.city + "</p></div>";
  }

  stockist_list = [];
}

//The one selcted product
function render_SelectedProduct(){
  //clears
  selectedprodIMG.innerHTML = ' ';
  selectedprodINFO.innerHTML = ' ';

  selectedprodIMG.innerHTML += "<img class='selectpic' src='img/prod/" + selectedprod.imageUrl + "'>";
  var newElement = document.createElement('div');
  newElement.innerHTML = "<p class='selectinfo'>CARD --- " + "$ " + selectedprod.price + "" + "</p><br><br><p class='selectinfo'>" + selectedprod.description + "</p><br><br>" + "<div id='spinnershop'><input type='number' class='inputnum' id='inputquantity' value='1'  min='1' step='1'/>&nbsp&nbsp&nbsp<button type='button' class='btn btn-primary selectinfo' id='addtocartbutton' onclick='addToCart()'>ADD TO CART</button></div>";
  selectedprodINFO.appendChild(newElement);

}
//fills the shop section with imgs and data THEN IT CLEARS THE LIST OF PRODUCTS
function render_Products(){
  //clears the shop
  shop.innerHTML = ' ';

  //builds shop
  for(item in product_list){
    prod = product_list[item];
    if(prod.isSale){
      shop.innerHTML += "<div class='col-md-3'><a href='selectedprod.html?prodID=" + prod.productId +"'><img class='instapic' src='img/prod/" + prod.imageUrl + "'></a>" + "<p> ON SALE! -- $ " + prod.price + "</p></div>"
    }else{
      shop.innerHTML += "<div class='col-md-3'><a href='selectedprod.html?prodID=" + prod.productId +"'><img class='instapic' src='img/prod/" + prod.imageUrl + "'></a>" + "<p> $ " + prod.price + "</p></div>"
    }

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
    price: price.toFixed(2),
    isSale: sale
  }
  return prod;
}

//Constructor function for selectedprod
function SelectedProduct(url, price, description){
  var selprod = {
    imageUrl: url,
    price: price.toFixed(2),
    description: description
  }

  return selprod;
}

//Contructor funciton for stockist
function Stockist(name, state, city){
  var stockist = {
    name: name,
    state: state,
    city: city
  }
  return stockist;
}

//contructor function for cart items
function CartItem(id, quantity, price, img){
  var cartitem = {
    id: id,
    quantity: quantity,
    price: price,
    imgUrl: img
  }
  return cartitem;
}

//constructor functionf or customer information
function CustomerInfo(first, last, email, phone, add, city, state, zip){
  var customerInfo = {
    firstname: first,
    lastname: last,
    email: email,
    phone: phone,
    address: add,
    city: city,
    state: state,
    zip: zip
  };
return customerInfo;
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
      JSON_to_product_Object(data);
      render_Products();
    }
  });
}

//loads SelectedProduct
function loadSelectedProd(){
  var id = urlParams.get('prodID');
  var url ='http://localhost:3000/api/products/' + id;
  getJSON(url,
  function(err, data) {
    if (err !== null) {
      alert('Something went wrong: ' + err);
    } else {
      JSON_to_selected_product_Object(data);
      render_SelectedProduct();
    }
  });
}


//laods the stockist information
function loadStockist(){
  var url ='http://localhost:3000/api/info/stockists';
  getJSON(url,
  function(err, data) {
    if (err !== null) {
      alert('Something went wrong: ' + err);
    } else {
      JSON_to_stockist_Object(data);
      render_Stockist();
    }
  });
}

//funciton to check for duplicate ID when adding items to shoppingcart
function isDuplicate(id){
   var duplicate = -1;
   for (item in cart.items){
     if (cart.items[item].id == id){
       return item;
     }
   }

   return duplicate;
}
//funciton for when user clicks the add to cart dropdownMenuButton
function addToCart(){
  if(sessionStorage.getItem('shoppingcart') == null){
    var jsonStr = JSON.stringify(cart);
    sessionStorage.setItem('shoppingcart', jsonStr);
  }

  var id = urlParams.get('prodID');
  var quantityInput = document.getElementById('inputquantity');
  var quantity = parseInt(quantityInput.value);
  var price = selectedprod.price;
  var img = selectedprod.imageUrl;
  var item = CartItem(id, quantity, price, img);

  cart = JSON.parse(sessionStorage.getItem('shoppingcart'))

  //check for duplicate id
  var duplicate = isDuplicate(id);
  if(duplicate == -1){
    cart.items.push(item);
  }else{
    cart.items[duplicate].quantity += quantity;
  }


  cart.quantity = parseInt(cart.quantity) + quantity;
  cartnum.innerHTML = 'CART(' + cart.quantity + ")";
  var jsonStr = JSON.stringify(cart);
  sessionStorage.setItem('shoppingcart', jsonStr);
  if(quantity > 1){
      alert(quantity + " items have been added to your shopping cart!")
  }
  else{
      alert(quantity + " item has been added to your shopping cart!")
  }

}

function setCartValue(){
  if(sessionStorage.getItem('shoppingcart') == null){
    var cartString = "CART(0)";
    cartnum.innerHTML = cartString;
  }else{
    cart = JSON.parse(sessionStorage.getItem('shoppingcart'))
    var cartString = "CART(" + cart.quantity +")";
    cartnum.innerHTML = cartString;
  }
}

//function to display the items in the cart in a table
function loadShoppingCart(){
  var total = 0;
  if(sessionStorage.getItem('shoppingcart') == null){
      shoppingcartDisplay.innerHTML += "You have nothing in your cart yet!";
  }else{

    cart = JSON.parse(sessionStorage.getItem('shoppingcart'))
    for (item in cart.items){
      var subtotal = (cart.items[item].price * cart.items[item].quantity).toFixed(2);
      shoppingcartDisplay.innerHTML += "<td><img src='img/prod/" + cart.items[item].imgUrl + "' class='cartImage'></td>" + "<td>" + cart.items[item].quantity + "</td>" + "<td>$ "+ cart.items[item].price + "</td>" + "<td>$ "+ subtotal + "</td>";
      total += parseInt(subtotal);
  }
    total = total.toFixed(2)
    var text = document.getElementById('subtotaltext');
    text.innerHTML += "Subtotal:&nbsp&nbsp $ " + total
  }
}

//function to send LANE the customer data
function sendCustomerData(){
  var first = document.getElementById('firstname').value;
  var last = document.getElementById('lastname').value;
  var email = document.getElementById('email').value;
  var phone = document.getElementById('phone').value;
  var add = document.getElementById('address').value;
  var city = document.getElementById('city').value;
  var state = document.getElementById('state').value;
  var zip = document.getElementById('zip').value;

  if(sessionStorage.getItem('shoppingcart') == null){
    alert("You have nothing in your shopping cart!");
  }else{

    var xhr = new XMLHttpRequest();
    xhr.open("POST", 'http://localhost:3000/api/info/test', true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send("first=" + first + "&last=" + last + "&email="+ email + "&phone="+ phone + "&add="+ add + "&city="+ city + "&state=" + state + "&zip=" + zip);

    var zhr = new XMLHttpRequest();
    zhr.open("POST", 'http://localhost:3000/api/info/test', true);
    zhr.setRequestHeader("Content-Type", "application/json");
    zhr.send(sessionStorage.getItem('shoppingcart'));
  }

}

window.onload = function() {
  if(urlParams.get('prodtype')!=null){
     checkType();
  }
  if(urlParams.get('prodID')!=null){
    loadSelectedProd();
  }
  if(urlParams.get('stockist')!=null){
    loadStockist();
  }
  if(urlParams.get('showcart')!=null){
    loadShoppingCart();
  }
  setCartValue();
}
