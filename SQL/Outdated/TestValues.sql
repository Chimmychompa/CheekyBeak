INSERT INTO cheekybeak.account(account_category_id, email, password_hash, first_name, last_name, street_address, city, state, zip, phone) VALUES
	(1, 'marka@gmail.com', 'marka', 'Mark', 'Anderson', '1234 College Ave.', 'Manhattan', 'KS', '66502', '7857765577'),
    (1, 'shrek@yahoo.com', 'myswamp', 'Shrek', 'Ogre', '420 Swamp Lane', 'Orlando', 'FL', '95862', '18001234567'),
    (1, 'fabio@hotmail.com', 'dreamboat', 'Fabio', 'Fabulious', '6969 Sexy Dr.', 'Los Angeles', 'CA', '91235', '14561234567'),
    (2, 'localshop@gmail.com', 'shopkeeper1', 'Laura', 'Dickenson', '1414 Main St.', 'Kansas City', 'KS', '69854', '9137654321'),
    (3, 'lane8@ksu.edu', 'herewegoagain', 'Lane', 'Sorell', '789 Colbert Cir.', 'Manhattan', 'KS', '66503', '17857777777');

INSERT INTO cheekybeak.order(account_id, email, first_name, last_name, street_address, city, state, zip, phone, is_shipped) VALUES
	(1, 'marka@gmail.com', 'Mark', 'Anderson', '1234 College Ave.', 'Manhattan', 'KS', '66502', '7857765577', 0),
    (2, 'shrek@yahoo.com', 'Shrek', 'Ogre', '420 Swamp Lane', 'Orlando', 'FL', '95862', '18001234567', 0),
    (3, 'fabio@hotmail.com', 'Fabio', 'Fabulious', '6969 Sexy Dr.', 'Los Angeles', 'CA', '91235', '14561234567', 1),
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
    (16, 0.25, date_sub(NOW(), INTERVAL 10 DAY), NOW(), 0);

INSERT INTO cheekybeak.stockist (name, location) VALUES
	('ACME Gift', 'Kansas'),
    ('Local Cards', 'Kansas'),
    ('Friendly Greetings', 'Kansas'),
    ('Hometown Supply', 'Florida'),
    ('The Gift Shop', 'Nebraska'),
    ('Flowers a Dozen', 'Virginia'),
    ('Progressive Gift', 'California'),
    ('Cards and Coffee', 'California');