--  This view shows the total quantity of a product across all stores
CREATE OR REPLACE VIEW product_quantities AS
SELECT p.product_uuid, p.product_name, SUM(s.quantity) AS total_quantity
FROM products p
JOIN store_inventory s ON p.product_uuid = s.product_uuid
GROUP BY p.product_uuid, p.product_name;


--- This view that merges user_addresses, and countries tables together
CREATE OR REPLACE VIEW user_full_addresses AS
SELECT CONCAT_WS(', ',
   user_addresses.street_name,
   user_addresses.zipcode,
   user_addresses.city,
   countries.name_country
) AS the_address,
user_addresses.user_id
FROM user_addresses
JOIN countries ON user_addresses.country_id = countries.country_id;

--- This view that merges store_addresses, and countries tables together
CREATE OR REPLACE VIEW store_full_addresses AS
SELECT CONCAT_WS(', ',
   store_addresses.street_name,
   store_addresses.zipcode,
   store_addresses.city,
   countries.name_country
) AS the_address,
store_addresses.store_id
FROM store_addresses
JOIN countries ON store_addresses.country_id = countries.country_id;


-- Test of US#1
--2. Let users sign up to the platform (i.e.: email, password, address, ...)

SELECT 
  users.user_id, 
  users.email, 
  users.first_name, 
  users.last_name, 
  user_full_addresses.the_address,
  users.phone_number 
FROM users 
JOIN user_full_addresses
ON users.user_id = user_full_addresses.user_id 
GROUP BY users.user_id;


-- To check  what roles a user has
--3. Users can have up to three different roles
SELECT 
  CONCAT(users.first_name, ' ', users.last_name) AS user_name, 
  GROUP_CONCAT(roles.role_name SEPARATOR ', ') AS user_roles
FROM 
  user_role_counts
  JOIN users ON users.user_id = user_role_counts.user_id
  JOIN roles ON roles.role_id = user_role_counts.role_id
GROUP BY users.user_id;




--4. Users can create groups with one or more other users
SELECT 
  g.name AS group_name, 
  GROUP_CONCAT(u.first_name, ' ', u.last_name SEPARATOR ', ') AS the_members
FROM 
  groups_name g
  INNER JOIN group_members gm ON gm.group_id = g.group_id
  INNER JOIN users u ON u.user_id = gm.user_id
GROUP BY g.group_id;


-- Test of US#4
--5. Users can post to the groups they belong to
SELECT 
  gm.message_id, 
  g.name AS group_name, 
  CONCAT(u.first_name, ' ', u.last_name) AS sender_name, 
  gm.message_text, 
  gm.send_date, 
  gm.message_time
FROM 
  group_messages gm
  INNER JOIN groups_name g ON g.group_id = gm.group_id
  INNER JOIN users u ON u.user_id = gm.user_id
WHERE 
  g.group_id = 1;

--6. Users can send private messages to each other
-- send private message
SELECT 
  CONCAT(users_sender.first_name, ' ', users_sender.last_name) AS sender,
  CONCAT( user_recipient.first_name, ' ',  user_recipient.last_name) AS recipient,
  private_messages.message_text AS the_message
FROM 
  private_messages
  JOIN user_message_recipients ON private_messages.message_id = user_message_recipients.message_id
  JOIN users  user_recipient ON user_message_recipients.recipient_id = user_recipient.user_id 
  JOIN users  users_sender ON private_messages.sender_id = users_sender.user_id
WHERE
  private_messages.message_id = 2;  

  

--(#14) As a user I want to be able to send messages to multiple users at once.
SELECT 
  CONCAT(u_sender.first_name, ' ', u_sender.last_name) AS sender,
  pm.message_text AS the_message,
  GROUP_CONCAT(CONCAT(u_recipient.first_name, ' ', u_recipient.last_name) SEPARATOR ', ') AS recipients
FROM 
  private_messages pm
  INNER JOIN user_message_recipients umr ON pm.message_id = umr.message_id
  INNER JOIN users u_recipient ON umr.recipient_id = u_recipient.user_id
  INNER JOIN users u_sender ON pm.sender_id = u_sender.user_id
WHERE 
  pm.message_id = 1;

---7. Users can send an order

--8. An order contains one or more order lines (products)
SELECT orders.order_id, products.product_name, order_products.quantity
FROM orders
JOIN order_products ON orders.order_id = order_products.order_id
JOIN products ON order_products.product_uuid = products.product_uuid
WHERE orders.order_id = 2;

--9. Each product has an inventory status (how many of that product we have in
--inventory

SELECT  s.store_name, p.product_uuid, p.product_name, i.product_quantity
FROM products p
JOIN inventory i ON p.product_uuid = i.product_uuid
JOIN store_inventory si ON si.product_uuid = p.product_uuid
JOIN stores s ON s.store_id = si.store_id
WHERE s.store_id = 1
GROUP BY s.store_name, p.product_uuid, p.product_name, i.product_quantity
 ;

--- total quantity of all inventory
SELECT * FROM product_quantities WHERE product_name = 'pet food';

-- 10. Each order has a status of either:
-- •submitted
-- •packing
-- •ready to ship
-- •shipped
-- •cancelled
SELECT order_id, order_status FROM orders
WHERE order_id = 2;


--(US#12) As a user I want to be able to see the inventory of products in different stores.

SELECT
products.product_name,
stores.store_name,
store_inventory.quantity,
full_address.the_address AS the_address
FROM
products
JOIN store_inventory ON products.product_uuid= store_inventory.product_uuid
JOIN stores ON store_inventory.store_id = stores.store_id
JOIN store_full_addresses AS full_address ON stores.store_id = full_address.store_id
WHERE
products.product_name = 'pet food'
GROUP BY stores.store_name, full_address.the_address, store_inventory.quantity;



--(US#13) As a user I want to see which store my order will be delivered from. 
SELECT 
  orders.order_id, 
  p.product_name, 
  stores.store_name AS delivered_from_store, 
  store_full_addresses.the_address AS store_address
FROM orders
JOIN order_products ON orders.order_id = order_products.order_id
JOIN products p ON order_products.product_uuid = p.product_uuid
JOIN stores ON orders.delivered_from = stores.store_id
JOIN store_full_addresses ON stores.store_id = store_full_addresses.store_id
WHERE orders.order_id = 3;



  