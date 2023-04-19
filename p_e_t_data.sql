-- Inserting data into the 'users' table
INSERT IGNORE INTO users (email, password, first_name,last_name,  phone_number) 
VALUES ('mary.ma@example.com', '222222', 'Mary',' Ma', '123445'),
       ('simon.se@example.com', '4433434', 'Simon' ,' Se',  '123445'),
       ('jannatul.ja@example.com', '2323ewe', 'Jannatul' ,' Ja',  '123445'),
       ('saeed.s@example.com', '3443432', 'Saeed' ,' Sa',  '123445'),
       ('amirali.am@example.com', '3234eew', 'Amirali', ' Am',  '123445'),
       ('melina.me@example.com', '3ewr343r', 'Melina',' Me', '123445');

-- Insert data into address
INSERT into countries(name_country) 
VALUES ('Sweden');

INSERT IGNORE INTO user_addresses (user_id, street_name, zipcode, city,country_id)
VALUES  (2,'Arenavägen 21', '121 77', 'Johanneshov',1),
        (4,'Elektravägen 29', '126 30', 'Hägersten',1),
        (1,'Vasagatan 16', '111 20', 'Stockholm',1),
        (5,'Bergfotsvägen 5', '147 33', 'Tumba',1),
        (3,'Järnvägsgatan 68', '172 35', 'Sundbyberg',1),
        (6,'Stupvägen 19', '191 42', 'Sollentuna',1);
-- Inserting data into the 'roles' table
INSERT IGNORE INTO roles (role_name) VALUES
('Admin'),
('Owner'),
('Employee');


-- Inserting data into the 'user_role_counts' table
INSERT INTO user_role_counts (user_id, role_number,role_id) VALUES
(1, 1,1),
(1, 2,2),
(1, 3,3),
(2, 1,2),
(4, 1,3),
(4, 2,1),
(5, 1,2),
(5, 2,3),
(6, 1,1),
(6, 2,2),
(6, 3,3),
(3, 1,2);



-- Insert data into products table

-- Insert data into products table
INSERT IGNORE INTO products (product_uuid, product_name, price, product_description, product_image)
VALUES ('9e16db8c-c8eb-11ed-abe6-3a2aef9436e8', 'Pet food', 19.99, 'Premium quality dry food for dogs and cats', 'petfood.jpg'),
       ('9e16dde4-c8eb-11ed-abe6-3a2aef9436e8', 'Cat Toy', 9.99, 'Toy for cats', 'cat_toy.jpg'),
       ('9e16de98-c8eb-11ed-abe6-3a2aef9436e8', 'Fish Cobalt', 99.99, 'A Great Cobalt for your fish', 'cobal_fish.jpg');


-- Insert data into categories table
INSERT IGNORE INTO categories (category_id, product_type)
VALUES (1, 'Dry food'),
       (2, 'Toy'),
       (3, 'Cobaltism');

INSERT  IGNORE INTO product_categories (product_uuid, category_id)
VALUES ('2267619a-aeb6-4d97-956d-4d413cffe720',1),
       ('299bbd3a-307f-4ffd-a6a0-b52d9dbbc49c',2),
       ('4b8f2228-c462-49b8-b30a-75652d18e5bc',3);


-- Insert data into inventory table
INSERT INTO inventory (product_uuid, product_quantity)

VALUES ('9e16db8c-c8eb-11ed-abe6-3a2aef9436e8', 50),
       ('9e16dde4-c8eb-11ed-abe6-3a2aef9436e8', 10),
       ('9e16de98-c8eb-11ed-abe6-3a2aef9436e8', 100);

-- Insert data into stores table
INSERT INTO stores (store_name)
VALUES ('Petco'),
       ('Petsmart'),
       ('Pet Supplies Plus');


 -- Insert data into store_inventory table
INSERT INTO store_inventory (store_id, product_uuid, quantity)
VALUES (1,'9e16db8c-c8eb-11ed-abe6-3a2aef9436e8', 50),
       (1, '9e16dde4-c8eb-11ed-abe6-3a2aef9436e8', 25),
       (2,'9e16de98-c8eb-11ed-abe6-3a2aef9436e8', 25),
       (3,'9e16db8c-c8eb-11ed-abe6-3a2aef9436e8', 50);


-- Insert data into store_addresses table
INSERT INTO store_addresses (store_id, street_name, zipcode, city, country_id )
VALUES        
        (1,'Arenavägen 55', '121 77', 'Johanneshov', 1),
        (2,'Vasagatan 67', '111 20', 'Stockholm', 1),
        (3,'Järnvägsgatan 2', '172 35', 'Sundbyberg', 1);



-- Insert data into orders table
INSERT INTO orders (user_id, order_date, order_status, delivered_from) 
VALUES (1, '2023-03-04', 'submitted','1'),
       (2,'2023-03-02', 'shipped', '2'),
       (3,'2023-03-03', 'cancelled', '2');

-- Insert data into order_products
INSERT INTO order_products (order_id, product_uuid,quantity)
VALUES (1, '9e16db8c-c8eb-11ed-abe6-3a2aef9436e8',3),
       (2,'9e16dde4-c8eb-11ed-abe6-3a2aef9436e8',4),
       (2,'9e16de98-c8eb-11ed-abe6-3a2aef9436e8',1),
       (3,'9e16de98-c8eb-11ed-abe6-3a2aef9436e8',1);


-- Insert data into group
INSERT INTO groups_name (name)
VALUES  ('alpha'),
        ('bravo'),
        ('charlie');

INSERT INTO group_members (group_id, user_id)
VALUES  (1, 1),
        (2, 3),
        (3, 2),
        (3,1); 



-- Insert a message posted by users in the groups
INSERT INTO group_messages (group_id, user_id, message_text)
VALUES (1, 1, 'Hello, this is User#1, posting message in alpha!'),
       (2, 3, 'Hello, this is User#2, posting message in bravo!'),
       (3, 1, 'Hello, this is User#5, posting message in charlie!');

--insert into the private_messages table:
--! Note: US#5 is disabled for now due to #32, to be removed completely if needed.
-- The sender_id and receiver_id are the user_id of the users table.
INSERT INTO private_messages (sender_id, recipient_id, message_text) 
VALUES  
(1, 2, 'Hey, how are you doing?'), 
(2, 1, 'I am doing well, thank you! How about you?'), 
(1, 2, 'I am good too. Just wanted to catch up with you.'), 
(3, 1, 'Hi there! I am new to the platform. Would love to connect with you.'), 
(1, 3, 'Sure, let me know if you need any help!');



-- To be able to send messages to multiple users at once. #32


INSERT INTO user_message_recipients (message_id, recipient_id) VALUES
(1, 2),
(1, 5),
(1, 4),
(2, 1),
(3, 3);