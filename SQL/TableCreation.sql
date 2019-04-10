CREATE SCHEMA IF NOT EXISTS cheekybeak;
DROP TABLE IF EXISTS cheekybeak.product_click;
DROP TABLE IF EXISTS cheekybeak.product_sale;
DROP TABLE IF EXISTS cheekybeak.order_line;
DROP TABLE IF EXISTS cheekybeak.product_tag;
DROP TABLE IF EXISTS cheekybeak.product;
DROP TABLE IF EXISTS cheekybeak.product_category;
DROP TABLE IF EXISTS cheekybeak.`order`;
DROP TABLE IF EXISTS cheekybeak.search_word;
DROP TABLE IF EXISTS cheekybeak.search;
DROP TABLE IF EXISTS cheekybeak.`account`;
DROP TABLE IF EXISTS cheekybeak.account_category;
DROP TABLE IF EXISTS cheekybeak.tag;
DROP TABLE IF EXISTS cheekybeak.stockist;

CREATE TABLE cheekybeak.product_category
(
	product_category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `description` VARCHAR(45) NOT NULL,
    
    UNIQUE KEY (`description`)
);

CREATE TABLE cheekybeak.product
(
	product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product_category_id INT NOT NULL,
    image_url VARCHAR(200) NOT NULL,
    price DECIMAL(5,2) NOT NULL,
    wholesale_price DECIMAL(5,2) NOT NULL,
    production_cost DECIMAL(5,2) NOT NULL,
    product_description VARCHAR(500) NOT NULL,
    is_removed BOOL NOT NULL DEFAULT 0,
    created_on DATETIME NOT NULL DEFAULT NOW(),    
    
    FOREIGN KEY (product_category_id) REFERENCES product_category(product_category_id),
    
    UNIQUE KEY (image_url)
);

CREATE TABLE cheekybeak.product_sale
(
	product_sale_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    discount_percentage DECIMAL NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,        
    is_active BOOL NOT NULL DEFAULT 1,	
    
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    
    UNIQUE KEY (product_sale_id, product_id),
    UNIQUE KEY (product_id, start_date)
);

CREATE TABLE cheekybeak.account_category
(
	account_category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `description` VARCHAR(45) NOT NULL,
    
    UNIQUE KEY (description)
);

CREATE TABLE cheekybeak.`account`
(
	account_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    account_category_id INT NOT NULL,
    email VARCHAR(100) NOT NULL,
    password_hash VARCHAR(100) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    street_address VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(2) NOT NULL,
    zip VARCHAR(20) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    created_on DATETIME NOT NULL DEFAULT NOW(),
    updated_on DATETIME NOT NULL DEFAULT NOW(),
    
    FOREIGN KEY (account_category_id) REFERENCES account_category(account_category_id),
    
    UNIQUE KEY (email)
);

CREATE TABLE cheekybeak.product_click
(
	product_click_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    product_sale_id INT NOT NULL,
    account_id INT,       
    click_timestamp DATETIME NOT NULL DEFAULT NOW(),	
    
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (product_sale_id, product_id) REFERENCES product_sale(product_sale_id, product_id),
    FOREIGN KEY (account_id) REFERENCES account(account_id)
);

CREATE TABLE cheekybeak.`order`
(
	order_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    email VARCHAR(100) NOT NULL,    
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    street_address VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(2) NOT NULL,
    zip VARCHAR(20) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    is_shipped BOOL NOT NULL DEFAULT 0,
    created_on DATETIME NOT NULL DEFAULT NOW(),
    updated_on DATETIME NOT NULL DEFAULT NOW(),
    
    FOREIGN KEY (account_id) REFERENCES `account`(account_id)
);

CREATE TABLE cheekybeak.order_line
(
	order_line_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    price DECIMAL(5,2) NOT NULL,
    quantity INT NOT NULL,    
    
    FOREIGN KEY (order_id) REFERENCES `order`(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE cheekybeak.tag
(
	tag_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tag VARCHAR(100) NOT NULL,
    created_on DATETIME NOT NULL DEFAULT NOW(),
    updated_on DATETIME NOT NULL DEFAULT NOW(),   
    
    UNIQUE KEY (tag)
);

CREATE TABLE cheekybeak.product_tag
(
	product_tag_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    tag_id INT NOT NULL,
    is_removed BOOL NOT NULL DEFAULT 0,
    
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (tag_id) REFERENCES tag(tag_id),
    
    UNIQUE KEY (product_id, tag_id)
);

CREATE TABLE cheekybeak.search
(
	search_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    search_string VARCHAR(100) NOT NULL,
    search_timestamp DATETIME NOT NULL DEFAULT NOW(),
    
    FOREIGN KEY (account_id) REFERENCES `account`(account_id)
);

CREATE TABLE cheekybeak.search_word
(
	search_word_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    search_id INT NOT NULL,
    tag_id INT,
    search_word VARCHAR(45) NOT NULL,
    
    FOREIGN KEY (search_id) REFERENCES search(search_id),
    FOREIGN KEY (tag_id) REFERENCES tag(tag_id)
);

CREATE TABLE cheekybeak.stockist
(
	stockist_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,    
    is_removed BOOL NOT NULL DEFAULT 0,
    created_on DATETIME NOT NULL DEFAULT NOW(),
    updated_on DATETIME NOT NULL DEFAULT NOW()
);