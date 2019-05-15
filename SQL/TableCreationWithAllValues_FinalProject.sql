CREATE SCHEMA IF NOT EXISTS cheekybeak;
USE cheekybeak;
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
    password_hash VARCHAR(128) NOT NULL,
    password_salt VARCHAR(16) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,    
    created_on DATETIME NOT NULL DEFAULT NOW(),
    updated_on DATETIME NOT NULL DEFAULT NOW(),
    
    FOREIGN KEY (account_category_id) REFERENCES account_category(account_category_id),
    
    UNIQUE KEY (email)
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
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    UNIQUE KEY (order_id, product_id)
);

CREATE TABLE cheekybeak.stockist
(
	stockist_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
	city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,    
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
	(1,4.50,2.25,0.50,'BDY102 product photo 2.jpg','Sharrrrk! Jam-packed with teeth, this card is a killer way to send your birthday greetings.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 5.5” x 4.25”\nSingle card, blank inside'),
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
	(7,4.50,2.25,0.50,'YAY103 product photo.jpg','OMG YAY for black backgrounds and patterns that pop!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(7,4.50,2.25,0.50,'YAY104 product photo.jpg','Your favorite graduate will crow with delight when they receive this spunky card.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(7,4.50,2.25,0.50,'YAY105 product photo.jpg','Crustaceans get a bad rap for being crabby, but some are actually quite celebratory. Hooray!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(7,4.50,2.25,0.50,'YAY106 product photo.jpg','Go, girl, go! Tell a galpal how much she rules with this super sweet rollerskate.\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside'),
	(7,4.50,2.25,0.50,'YAY107 product photo.jpg','What’s more celebratory than oranges, confetti, and bold type? Great for grads, newlyweds, and anyone else who deserves this zesty paper pat on the back!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 5.5” x 4.25”\nSingle card, blank inside'),
	(7,4.50,2.25,0.50,'YAY109 product photo.jpg','A design made purely from hole punch remnants, this card packs the perfect celebratory punch!\n\nInfo- digitally printed card\nMaterials - 100 lb. white paper with kraft envelope\nSize- A2 4.25” x 5.5”\nSingle card, blank inside');
    
INSERT INTO cheekybeak.account(account_category_id, email, password_hash, password_salt, first_name, last_name) VALUES
	(1, 'marka@gmail.com', '538bf564ad0fc2ec3775698dfd6e5b6cab1069a5b210cb8e4c93cee3727c94d2f86f84567bacb70a3a74b068db4c9b5ca1d7b0964d3d2841fa30a05a247bb4ff', 'd0224946ca77d94b', 'Mark', 'Anderson'), #password = marka
    (1, 'shrek@yahoo.com', '75e027fe166032f876025578ad4f2b02322352961187e1076231f76f9823e2f01033e72314fcd4524c3632abb7246702e2f46ee4621cde0b7d24e697d0019b3e', '7fe85e7ceb0d8bc7', 'Shrek', 'Ogre'), #password = myswamp
    (1, 'fabio@hotmail.com', '531de625444fba06250f68c3a92d70c3000a1ea482d95755b9654b0d16ea0372139634caecf5b68216ae236e28965ca775eaf0c086e38cd1e9b29d0313e8650a', 'e4a9510beb3001d9', 'Fabio', 'Stardust'), #password = dreamboat
    (2, 'localshop@gmail.com', 'e90989221d42e43f7ecd3cb0ab7a6067ec302bf9947dfab57b17ac97aa926f5aebce6215c88d72132c48d0da79c8bcaef1f1d17f6aef9d41b2059c08e97db68e', '18dbe1a49d31e74e', 'Laura', 'Dickenson'), #password = shopkeeper1
    (3, 'lane8@ksu.edu', '49189cfcb83525e52c45b352ac92cf33261b8a4cd5339c25247a573f4d65ed5e840d15e47b00e96def6db34979e2f84917ad1901143fc9128f23a08dc0daa87c', 'a1deb46e0de2b0a9', 'Lane', 'Sorell'); #password = herewegoagain

INSERT INTO cheekybeak.order(account_id, email, first_name, last_name, street_address, city, state, zip, phone, is_shipped) VALUES
	(1, 'marka@gmail.com', 'Mark', 'Anderson', '1234 College Ave.', 'Manhattan', 'KS', '66502', '7857765577', 0), 
    (2, 'shrek@yahoo.com', 'Shrek', 'Ogre', '420 Swamp Lane', 'Orlando', 'FL', '95862', '18001234567', 1), 
    (3, 'fabio@hotmail.com', 'Fabio', 'Fabulious', '6969 Sexy Dr.', 'Los Angeles', 'CA', '91235', '14561234567', 0), 
    (4, 'localshop@gmail.com', 'Laura', 'Dickenson', '1414 Main St.', 'Kansas City', 'KS', '69854', '9137654321', 1),    
    (NULL, 'anonman@gmail.com', 'Anon', 'Man', '1234 Development Dr.', 'Timbucktoo', 'ND', '14658', '1888888888', 0),
    (NULL, 'anonwoman@gmail.com', 'Anon', 'Woman', '5678 Creation St.', 'Somewhere', 'SD', '12345', '19034454445', 1);
    
INSERT INTO cheekybeak.order_line(order_id, product_id, price, quantity) VALUES
	(1, 1, 4.50, 1),
    (1, 2, 4.50, 1),
    (2, 3, 4.50, 2),
    (2, 4, 4.50, 1),
    (2, 5, 4.50, 2),
    (3, 1, 4.50, 1),
    (4, 6, 4.50, 6),
    (5, 7, 4.50, 1),
    (5, 8, 4.50, 1),
    (5, 9, 4.50, 2),
    (5, 10, 2.25, 1),
    (5, 11, 4.50, 1),
    (6, 12, 4.50, 3);
    
INSERT INTO cheekybeak.product_sale(product_id, discount_percentage, start_date, end_date, is_active) VALUES	
    (10, 0.5, NOW(), DATE_ADD(NOW(), INTERVAL 10 YEAR), 1),
    (17, 0.1, NOW(), DATE_ADD(NOW(), INTERVAL 10 YEAR), 1),
    (16, 0.25, DATE_SUB(NOW(), INTERVAL 10 DAY), NOW(), 0);

INSERT INTO cheekybeak.stockist (name, city, state) VALUES
	('ACME Gift', 'Manhattan', 'Kansas'),
    ('Local Cards', 'Manhattan', 'Kansas'),
    ('Friendly Greetings', 'Lawrence', 'Kansas'),
    ('Hometown Supply', 'Orlando', 'Florida'),
    ('The Gift Shop', 'Lincoln', 'Nebraska'),
    ('Flowers a Dozen', 'Jamestown', 'Virginia'),
    ('Progressive Gift', 'Los Angeles', 'California'),
    ('Cards and Coffee', 'Santa Monica', 'California');