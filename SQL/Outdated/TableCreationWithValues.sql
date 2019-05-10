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
    discount_percentage DECIMAL(5,2) NOT NULL,
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

INSERT INTO cheekybeak.product_category(`description`) VALUES
	('Birthday'),
	('Love'),
	('Sympathy'),
	('Friendship'),
    ('Everyday'),
	('Thank You'),
	('Congratulations'),
	('Baby'),
	('Holiday'),
	('Moms'),
    ('Dads'),
    ('Anniversary'),
    ('Miscellaneous');
    
INSERT INTO cheekybeak.account_category(`description`) VALUES
	('User'),
	('Wholesale'),
	('Admin');

INSERT INTO product(product_category_id, price, wholesale_price, production_cost, image_url, product_description) VALUES
	(12,4.50,2.25,0.50,'ANN101 product photo.jpg','What’s cookin’, good lookin’? This breakfasty duo is great for celebrating anniversaries and newlyweds!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(12,4.50,2.25,0.50,'ANN102 product photo.jpg','Say it with citrus- this juicy grapefruit greeting is packed with zesty color.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(8,4.50,2.25,0.50,'BBY101 product photo.jpg','Oh baby! The sweetest pink onesie to celebrate that new bundle of joy. Also available in purple.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(8,4.50,2.25,0.50,'BBY102 product photo.jpg','Oh baby! The sweetest purple onesie to celebrate that new bundle of joy. Also available in pink.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(8,4.50,2.25,0.50,'BBY104 product photo.jpg','This adorably pattern-packed card is perfect for celebrating baby! Also available in blue/green.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(8,4.50,2.25,0.50,'BBY105 product photo.jpg','This adorably pattern-packed card is perfect for celebrating baby! Also available in pink/red.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(8,4.50,2.25,0.50,'BBY106 product photo.jpg','This gender-neutral gem features the sweetest watercolor motif. Welcome, wee one!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(1,4.50,2.25,0.50,'BDY101 product photo.jpg','This card is worth the buzz! Ideal for the queen bee in your life or anyone you want to wish a bee-autiful birthday.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(1,4.50,2.25,0.50,'BDY102 product photo.jpg','Sharrrrk! Jam-packed with teeth, this card is a killer way to send your birthday greetings.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 5.5” x 4.25”\nSingle card, blank inside'),
	(1,4.50,2.25,0.50,'BDY103 product photo.jpg','The sweetest little crustacean to celebrate the introvert in your life...but maybe don’t sing them “Happy Birthday,” I heard they don’t like that.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(1,4.50,2.25,0.50,'BDY104 product photo.jpg','This design features hand-painted speckles and the happiest orange block letters.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(1,4.50,2.25,0.50,'BDY105 product photo.jpg','Chock full of sprinkles and color, this design is a great accompaniment to any party- because even the toughest dude on the planet loves funfetti.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(1,4.50,2.25,0.50,'BDY106 product photo.jpg','This multi-occasion card is great to have on hand- use it for birthdays, graduations, weddings, or any celebration that calls for confetti!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(1,4.50,2.25,0.50,'BDY107 product photo.jpg','What do you get when you combine confetti with a killer whale? The perfect party animal for any deep sea lover.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(1,4.50,2.25,0.50,'BDY108 product photo.jpg','This New Yorker is never too coo to wish someone a very happy birthday.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 5.5” x 4.25”\nSingle card, blank inside'),
	(1,4.50,2.25,0.50,'BDY109 product photo.jpg','Eye-catching arches to celebrate your bff! Because some friendships really are rainbow-bright.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 5.5” x 4.25”\nSingle card, blank inside'),
	(1,4.50,2.25,0.50,'BDY110 product photo.jpg','This hand-painted slice will help you express your most honest sentiments.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(1,4.50,2.25,0.50,'BDY111 product photo.jpg','Party time! Alright! Who brought the human leg--er, cake?\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(1,4.50,2.25,0.50,'BDY112 product photo.jpg','Birthday greetings on a playful watercolor landscape are sure to delight young and old!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(1,4.50,2.25,0.50,'BDY113 product photo.jpg','This card’s no minimalist- these vibrant greens and graphic patterns pack a lively punch.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(5,4.50,2.25,0.50,'EDY102 product photo.jpg','The ultimate card for all those succulent and cacti lovers out there! (Which is basically everyone, right?)\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 5.5” x 4.25”\nSingle card, blank inside'),
	(5,4.50,2.25,0.50,'EDY105 product photo.jpg','Extra pepperoni, please! A great card for that cheese-loving grad or anyone who needs an extra slice of encouragement.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(4,4.50,2.25,0.50,'FRN101 product photo.jpg','Looking for a quirky, fun friendship card? Look no further and say it with these ruby-red veggies!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(4,4.50,2.25,0.50,'FRN102 product photo.jpg','When life gives you lemons...well, you know the drill! Here’s a card for those sweet/tart moments in life that deserve commemoration.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(4,4.50,2.25,0.50,'FRN103 product photo.jpg','It’s ruff when a loved one lives far away...so send them a cute frenchie to make their day!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(4,4.50,2.25,0.50,'FRN104 product photo.jpg','Mail this adorable winged mammal to that pal who’s, well, a little odd.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 5.5” x 4.25”\nSingle card, blank inside'),
	(4,4.50,2.25,0.50,'FRN105 product photo.jpg','Featuring everybody’s favorite little houseplant and hand-lettered font, nab this card for someone special and let them know they’re not terrible.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(4,4.50,2.25,0.50,'FRN106 product photo.jpg','Give this perky design to a new momma who’s figuring out breastfeeding or to a breast cancer warrior- they’ll really appreciate the support!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(11,4.50,2.25,0.50,'FTH101 product photo.jpg','Info- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(11,4.50,2.25,0.50,'FTH102 product photo.jpg','Info- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(11,4.50,2.25,0.50,'FTH103 product photo.jpg','Info- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 5.5”x4.25”\nSingle card, blank inside'),
	(9,4.50,2.25,0.50,'HDY101 product photo.jpg','Info- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 5.5”x4.25”\nSingle card, blank inside'),
	(9,4.50,2.25,0.50,'HDY102 product photo.jpg','Info- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(9,4.50,2.25,0.50,'HDY103 product photo.jpg','Info- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(9,4.50,2.25,0.50,'HDY104 product photo.jpg','Info- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 5.5”x4.25”\nSingle card, blank inside'),
	(9,4.50,2.25,0.50,'HDY105 product photo.jpg','Info- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(9,4.50,2.25,0.50,'HDY106 product photo.jpg','Info- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(2,4.50,2.25,0.50,'LVE102 product photo.jpg','The perfect just-because card for a humor-loving feminist, your sister, or a friend who could use a date with her razor.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 5.5” x 4.25”\nSingle card, blank inside'),
	(2,4.50,2.25,0.50,'LVE104 product photo.jpg','Look no further- here’s the best card for someone you like as much as artificial porch lights. Ahh, blinded by love.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(2,4.50,2.25,0.50,'LVE106 product photo.jpg','Don’t be a bird brain- get this foul greeting for your loved one! They’ll clucking love it.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 5.5” x 4.25”\nSingle card, blank inside'),
	(2,4.50,2.25,0.50,'LVE107 product photo.jpg','Contrary to popular belief, lobsters don’t actually mate for life. It’s more like the male lobster has a harem of female lobsters but he’ll only mate with the ones who shed their old skin first. He sounds like a jerk. Anyway, here’s a heart-filled crustacean card for your love!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(2,4.50,2.25,0.50,'LVE108 product photo.jpg','Donuts have been hogging the spotlight for years- it’s time for the bagel to shine! Nab this card for your everything person.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 5.5” x 4.25”\nSingle card, blank inside'),
	(2,4.50,2.25,0.50,'LVE109 product photo.jpg','Mmm...this love greeting is sure to warm your sweetie’s soul.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(2,4.50,2.25,0.50,'LVE110 product photo.jpg','A dreamy moon motif for the soul you love unconditionally. Especially good for those who have a dark side.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(2,4.50,2.25,0.50,'LVE111 product photo.jpg','If you like your love life like you like your cards- lots of color (petty arguments) and complexity (“Wait, did you just fart?!”)- then this one’s for you!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(2,4.50,2.25,0.50,'LVE114 product photo.jpg','At the end of the day, this is truly the only to-do list that matters.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(2,4.50,2.25,0.50,'LVE116 product photo.jpg','Oh hi, lovebug! This buggy greeting was created with hand-painted paper cutouts and makes a perfect just-because card.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(2,4.50,2.25,0.50,'LVE117 product photo.jpg','Long live Pamplemousse La Croix! For that someone who makes you feel all fizzy inside.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(2,4.50,2.25,0.50,'LVE118 product photo.jpg','The cutest little montage of coffee cups for your better half (and half).\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(2,4.50,2.25,0.50,'LVE119 product photo.jpg','Write your sweet nothings inside this design that features fluffy frosting-esque brushstrokes.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(10,4.50,2.25,0.50,'MTH101 product photo.jpg','Info- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(10,4.50,2.25,0.50,'MTH102 product photo.jpg','Info- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(10,4.50,2.25,0.50,'MTH103 product photo.jpg','Info- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(10,4.50,2.25,0.50,'MTH104 product photo.jpg','Ooooh, Mama-sita! This spicy design of bold, hand-painted letters are bound to make her feel like one hot mama.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(10,4.50,2.25,0.50,'MTH105 product photo.jpg','Info- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(13,4.50,2.25,0.50,'NHM101 product photo.jpg','Home sweet home! These ombre houses are great for welcoming a new neighbor or celebrating first-time homebuyers.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(3,4.50,2.25,0.50,'SYM101 product photo.jpg','An cozy armchair and an inviting houseplant to extend your words of comfort.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(3,4.50,2.25,0.50,'SYM102 product photo.jpg','For those times when you need to send flowers on a greeting card budget.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(3,4.50,2.25,0.50,'SYM103 product photo.jpg','Send your thoughts of care in this coral reef-inspired design- it’s bound to bring feelings of calm.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(3,4.50,2.25,0.50,'SYM104 product photo.jpg','Remind a loved one that things will get better with this kind raincloud sentiment.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(3,4.50,2.25,0.50,'SYM105 product photo.jpg','A soft palette paired with a sheltering leaf to both comfort and affirm a loved one.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(3,4.50,2.25,0.50,'SYM106 product photo.jpg','Simple and serene, this card will carry your words of comfort near and far.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(6,4.50,2.25,0.50,'TYU101 product photo.jpg','SWAT! A cheeky way to show your thanks.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(6,4.50,2.25,0.50,'TYU102 product photo.jpg','These turquoise gems are perfect for acknowledging sparkly acts of kindness.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(6,4.50,2.25,0.50,'TYU103 product photo.jpg','You’d better be-leaf this charming monstera design will be well-received!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(6,4.50,2.25,0.50,'TYU104 product photo.jpg','Delightfully color-packed and tropical, these bold letters will help you express your thanks!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(6,4.50,2.25,0.50,'TYU105 product photo.jpg','Just a bunch of cute and quirky tropicals to help you say “thanks!”\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(6,4.50,2.25,0.50,'TYU106 product photo.jpg','Popping with electric yellows and fresh jungle greens, this card is a striking way to express your gratitude.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(6,4.50,2.25,0.50,'TYU107 product photo.jpg','Show your gratitude with this lush display of spunky grevillea leaves.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(7,4.50,2.25,0.50,'YAY101 product photo.jpg','Simple and serene, this card will carry your words of comfort near and far.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),	
	(7,4.50,2.25,0.50,'YAY102 product photo.jpg','You can practically hear this card cheering- this jubilant design is a party on a page!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(7,4.50,2.25,0.50,'YAY103 product photo.jpg','OMG YAY for black backgrounds and patterns that pop!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(7,4.50,2.25,0.50,'YAY104 product photo.jpg','Your favorite graduate will crow with delight when they receive this spunky card.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(7,4.50,2.25,0.50,'YAY105 product photo.jpg','Crustaceans get a bad rap for being crabby, but some are actually quite celebratory. Hooray!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(7,4.50,2.25,0.50,'YAY106 product photo.jpg','Go, girl, go! Tell a galpal how much she rules with this super sweet rollerskate.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(7,4.50,2.25,0.50,'YAY107 product photo.jpg','What’s more celebratory than oranges, confetti, and bold type? Great for grads, newlyweds, and anyone else who deserves this zesty paper pat on the back!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 5.5” x 4.25”\nSingle card, blank inside'),
	(7,4.50,2.25,0.50,'YAY109 product photo.jpg','A design made purely from hole punch remnants, this card packs the perfect celebratory punch!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside');