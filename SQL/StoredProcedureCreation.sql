DROP PROCEDURE IF EXISTS GetAllProducts;
DELIMITER //
CREATE PROCEDURE GetAllProducts()
BEGIN
	SELECT product_id, product_category_id, image_url, price, wholesale_price, product_description
    FROM product
    WHERE is_removed != 1;
END//
DELIMITER ;