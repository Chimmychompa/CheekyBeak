USE cheekybeak;
DROP PROCEDURE IF EXISTS GetAllProducts;
DROP PROCEDURE IF EXISTS GetBirthday;
DROP PROCEDURE IF EXISTS GetLove;
DROP PROCEDURE IF EXISTS GetSympathy;
DROP PROCEDURE IF EXISTS GetFriendshipEveryday;
DROP PROCEDURE IF EXISTS GetThankYou;
DROP PROCEDURE IF EXISTS GetCongratulations;
DROP PROCEDURE IF EXISTS GetBaby;
DROP PROCEDURE IF EXISTS GetHoliday;
DROP PROCEDURE IF EXISTS GetMomsDads;
DROP PROCEDURE IF EXISTS GetProduct;
DROP PROCEDURE IF EXISTS GetSale;
DROP PROCEDURE IF EXISTS GetStockists;
DROP PROCEDURE IF EXISTS GetUnshippedOrderLines;
DROP PROCEDURE IF EXISTS GetShippedOrderLines;
DROP PROCEDURE IF EXISTS GetOrderTotals;
DROP PROCEDURE IF EXISTS CreateAccount;
DROP PROCEDURE IF EXISTS AuthenticateAccount;
DELIMITER //
CREATE PROCEDURE GetAllProducts()
BEGIN
	SELECT p.product_id, image_url,
		if(discount_percentage > 0 AND is_active = 1, round(p.price * (1 - ps.discount_percentage), 2), p.price) AS price, 
		if(discount_percentage > 0 AND is_active = 1, 1, 0) AS is_sale
	FROM product p
	LEFT JOIN product_sale ps ON ps.product_id = p.product_id
	WHERE is_removed != 1;
END//

CREATE PROCEDURE GetBirthday()
BEGIN
	SELECT p.product_id, image_url,
		if(discount_percentage > 0 AND is_active = 1, round(p.price * (1 - ps.discount_percentage), 2), p.price) AS price, 
		if(discount_percentage > 0 AND is_active = 1, 1, 0) AS is_sale
	FROM product p
	LEFT JOIN product_sale ps ON ps.product_id = p.product_id
	INNER JOIN product_category pc ON pc.product_category_id = p.product_category_id
	WHERE is_removed != 1 AND description = 'Birthday';
END//

CREATE PROCEDURE GetLove()
BEGIN
	SELECT p.product_id, image_url,
		if(discount_percentage > 0 AND is_active = 1, round(p.price * (1 - ps.discount_percentage), 2), p.price) AS price, 
		if(discount_percentage > 0 AND is_active = 1, 1, 0) AS is_sale
	FROM product p
	LEFT JOIN product_sale ps ON ps.product_id = p.product_id
	INNER JOIN product_category pc ON pc.product_category_id = p.product_category_id
	WHERE is_removed != 1 AND description = 'Love';
END//

CREATE PROCEDURE GetSympathy()
BEGIN
	SELECT p.product_id, image_url,
		if(discount_percentage > 0 AND is_active = 1, round(p.price * (1 - ps.discount_percentage), 2), p.price) AS price, 
		if(discount_percentage > 0 AND is_active = 1, 1, 0) AS is_sale
	FROM product p
	LEFT JOIN product_sale ps ON ps.product_id = p.product_id
	INNER JOIN product_category pc ON pc.product_category_id = p.product_category_id
	WHERE is_removed != 1 AND description = 'Sympathy';
END//

CREATE PROCEDURE GetFriendshipEveryday()
BEGIN
	SELECT p.product_id, image_url,
		if(discount_percentage > 0 AND is_active = 1, round(p.price * (1 - ps.discount_percentage), 2), p.price) AS price, 
		if(discount_percentage > 0 AND is_active = 1, 1, 0) AS is_sale
	FROM product p
	LEFT JOIN product_sale ps ON ps.product_id = p.product_id
	INNER JOIN product_category pc ON pc.product_category_id = p.product_category_id
	WHERE is_removed != 1 AND (description = 'Friendship' OR description = 'Everyday');
END//

CREATE PROCEDURE GetThankYou()
BEGIN
	SELECT p.product_id, image_url,
		if(discount_percentage > 0 AND is_active = 1, round(p.price * (1 - ps.discount_percentage), 2), p.price) AS price, 
		if(discount_percentage > 0 AND is_active = 1, 1, 0) AS is_sale
	FROM product p
	LEFT JOIN product_sale ps ON ps.product_id = p.product_id
	INNER JOIN product_category pc ON pc.product_category_id = p.product_category_id
	WHERE is_removed != 1 AND description = 'Thank You';
END//

CREATE PROCEDURE GetCongratulations()
BEGIN
	SELECT p.product_id, image_url,
		if(discount_percentage > 0 AND is_active = 1, round(p.price * (1 - ps.discount_percentage), 2), p.price) AS price, 
		if(discount_percentage > 0 AND is_active = 1, 1, 0) AS is_sale
	FROM product p
	LEFT JOIN product_sale ps ON ps.product_id = p.product_id
	INNER JOIN product_category pc ON pc.product_category_id = p.product_category_id
	WHERE is_removed != 1 AND description = 'Congratulations';
END//

CREATE PROCEDURE GetBaby()
BEGIN
	SELECT p.product_id, image_url,
		if(discount_percentage > 0 AND is_active = 1, round(p.price * (1 - ps.discount_percentage), 2), p.price) AS price, 
		if(discount_percentage > 0 AND is_active = 1, 1, 0) AS is_sale
	FROM product p
	LEFT JOIN product_sale ps ON ps.product_id = p.product_id
	INNER JOIN product_category pc ON pc.product_category_id = p.product_category_id
	WHERE is_removed != 1 AND description = 'Baby';
END//

CREATE PROCEDURE GetHoliday()
BEGIN
	SELECT p.product_id, image_url,
		if(discount_percentage > 0 AND is_active = 1, round(p.price * (1 - ps.discount_percentage), 2), p.price) AS price, 
		if(discount_percentage > 0 AND is_active = 1, 1, 0) AS is_sale
	FROM product p
	LEFT JOIN product_sale ps ON ps.product_id = p.product_id
	INNER JOIN product_category pc ON pc.product_category_id = p.product_category_id
	WHERE is_removed != 1 AND description = 'Holiday';
END//

CREATE PROCEDURE GetMomsDads()
BEGIN
	SELECT p.product_id, image_url,
		if(discount_percentage > 0 AND is_active = 1, round(p.price * (1 - ps.discount_percentage), 2), p.price) AS price, 
		if(discount_percentage > 0 AND is_active = 1, 1, 0) AS is_sale
	FROM product p
	LEFT JOIN product_sale ps ON ps.product_id = p.product_id
	INNER JOIN product_category pc ON pc.product_category_id = p.product_category_id
	WHERE is_removed != 1 AND (description = 'Moms' OR description = 'Dads');
END//

CREATE PROCEDURE GetSale()
BEGIN
	SELECT p.product_id, image_url,
		if(discount_percentage > 0 AND is_active = 1, round(p.price * (1 - ps.discount_percentage), 2), p.price) AS price, 
		if(discount_percentage > 0 AND is_active = 1, 1, 0) AS is_sale
	FROM product p
	LEFT JOIN product_sale ps ON ps.product_id = p.product_id
	INNER JOIN product_category pc ON pc.product_category_id = p.product_category_id
	WHERE is_removed != 1 AND discount_percentage > 0 AND is_active = 1;
END//

CREATE PROCEDURE GetProduct
	(IN pid INT)
BEGIN
	SELECT image_url, product_description,
		if(discount_percentage > 0 AND is_active = 1, round(p.price * (1 - ps.discount_percentage), 2), p.price) AS price		
	FROM product p
	LEFT JOIN product_sale ps ON ps.product_id = p.product_id
	WHERE is_removed != 1 AND p.product_id = pid;
END//

CREATE PROCEDURE GetStockists()
BEGIN
	SELECT name, state, city
	FROM stockist
	WHERE is_removed != 1
    ORDER BY state ASC;
END//

CREATE PROCEDURE GetUnshippedOrderLines()
BEGIN
	SELECT o.order_id, first_name, last_name, street_address, city, state, zip, email, phone, p.product_id, image_url, quantity,
		if(discount_percentage > 0 AND is_active = 1, round(p.price * (1 - ps.discount_percentage), 2), p.price) AS price
	FROM `order` o
		INNER JOIN order_line ol ON ol.order_id = o.order_id
		INNER JOIN product p ON p.product_id = ol.product_id
		LEFT JOIN product_sale ps ON ps.product_id = p.product_id
	WHERE is_shipped = 0
	ORDER BY o.created_on ASC;
END//

CREATE PROCEDURE GetShippedOrderLines()
BEGIN
	SELECT o.order_id, first_name, last_name, street_address, city, state, zip, email, phone, p.product_id, image_url, quantity,
		if(discount_percentage > 0 AND is_active = 1, round(p.price * (1 - ps.discount_percentage), 2), p.price) AS price
	FROM `order` o
		INNER JOIN order_line ol ON ol.order_id = o.order_id
		INNER JOIN product p ON p.product_id = ol.product_id
		LEFT JOIN product_sale ps ON ps.product_id = p.product_id
	WHERE is_shipped = 1
	ORDER BY o.created_on ASC;
END//

CREATE PROCEDURE GetOrderTotals()
BEGIN
	SELECT o.order_id,
		sum(if(discount_percentage > 0 AND is_active = 1, round(p.price * (1 - ps.discount_percentage), 2), p.price)*quantity) AS order_total    
	FROM `order` o
		INNER JOIN order_line ol ON ol.order_id = o.order_id
		INNER JOIN product p ON p.product_id = ol.product_id
		LEFT JOIN product_sale ps ON ps.product_id = p.product_id
	GROUP BY o.order_id
	ORDER BY o.created_on ASC;
END//

CREATE PROCEDURE CreateAccount
(    
    IN mail VARCHAR(100), 
    IN pass_hash VARCHAR(128), 
    IN pass_salt VARCHAR(16), 
    IN fname VARCHAR(50),
    IN lname VARCHAR(50)
)
BEGIN
	INSERT INTO cheekybeak.account(account_category_id, email, password_hash, password_salt, first_name, last_name) VALUES
		(1, mail, pass_hash, pass_salt, fname, lname);
        
	SELECT account_id, email, first_name, last_name
    FROM account
    WHERE email = mail;
END//

CREATE PROCEDURE AuthenticateAccount
(    
    IN mail VARCHAR(100)
)
BEGIN
	SELECT account_id, email, first_name, last_name, password_hash, password_salt
    FROM account
    WHERE email = mail;
END//
DELIMITER ;