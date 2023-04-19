
    -- users
CREATE TABLE IF NOT EXISTS users (
    user_id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id),
    UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS countries (
    country_id int not null auto_increment,
    name_country VARCHAR(255),
    PRIMARY KEY (country_id )

);

CREATE TABLE IF NOT EXISTS user_addresses (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    street_name VARCHAR(255),
    zipcode VARCHAR(10),
    city VARCHAR(255),
    country_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (country_id) REFERENCES countries(country_id )

);
 
    -- roles
CREATE TABLE roles (
    role_id INT NOT NULL AUTO_INCREMENT,
    role_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (role_id),
    UNIQUE (role_name)
);


CREATE TABLE user_role_counts (
    user_id INT NOT NULL,
    role_number INT NOT NULL,
    role_id INT NOT NULL,
    PRIMARY KEY (user_id, role_number),
    CONSTRAINT fk_user_role_counts_users FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_user_role_counts_roles FOREIGN KEY (role_id) REFERENCES roles(role_id),
    CONSTRAINT ck_user_role_counts_role_number CHECK (role_number >= 1 AND role_number <= 3)
);


CREATE TABLE products(
    product_uuid CHAR(36) NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    product_description TEXT NOT NULL,
    product_image VARCHAR(255) NOT NULL,
    PRIMARY KEY (product_uuid)
);

CREATE TABLE IF NOT EXISTS categories (
    category_id INT NOT NULL AUTO_INCREMENT,
    product_type VARCHAR(255) NOT NULL,
    PRIMARY KEY (category_id)
);

CREATE TABLE IF NOT EXISTS product_categories (
    product_uuid CHAR(36) NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (product_uuid, category_id),
    FOREIGN KEY (product_uuid) REFERENCES products(product_uuid),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);






CREATE TABLE inventory (
    inventory_id INT NOT NULL AUTO_INCREMENT,
    product_uuid CHAR(36) NOT NULL,
    product_quantity INT NOT NULL,
    PRIMARY KEY (inventory_id),
    FOREIGN KEY (product_uuid) REFERENCES products(product_uuid)
);


    -- stores
CREATE TABLE IF NOT EXISTS stores (
    store_id INT NOT NULL AUTO_INCREMENT,
    store_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (store_id)

);

CREATE TABLE IF NOT EXISTS store_inventory (
    store_id INT NOT NULL,
    product_uuid CHAR(36) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (store_id, product_uuid),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_uuid) REFERENCES products(product_uuid)
);

CREATE TABLE IF NOT EXISTS store_addresses (
    id INT NOT NULL AUTO_INCREMENT,
    store_id INT NOT NULL,
    street_name VARCHAR(255),
    zipcode VARCHAR(10),
    city VARCHAR(255),
    country_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);


    -- orders
CREATE TABLE orders (
    order_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_status ENUM('submitted', 'packing', 'ready to ship', 'shipped', 'cancelled') NOT NULL,
    delivered_from INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (order_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (delivered_from) REFERENCES stores(store_id)
);

CREATE TABLE order_products (
    order_id INT NOT NULL,
    product_uuid CHAR(36) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id,product_uuid),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    Foreign Key (product_uuid) REFERENCES products(product_uuid)
);


    -- groups
CREATE TABLE IF NOT EXISTS groups_name (
    group_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(16),
    PRIMARY KEY (group_id),
    UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS group_members (
    member_id INT NOT NULL AUTO_INCREMENT,
    group_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (member_id),
    FOREIGN KEY (group_id) REFERENCES groups_name(group_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- messages
CREATE TABLE IF NOT EXISTS group_messages ( 
    message_id INT NOT NULL AUTO_INCREMENT, 
    group_id INT NOT NULL, 
    user_id INT NOT NULL, 
    message_text VARCHAR(255) NOT NULL, 
    send_date DATE NOT NULL DEFAULT NOW(),
    message_time TIME NOT NULL DEFAULT NOW(), 
    PRIMARY KEY (message_id), 
    FOREIGN KEY (group_id) REFERENCES groups_name(group_id), 
    FOREIGN KEY (user_id) REFERENCES users(user_id) 
);

CREATE TABLE IF NOT EXISTS private_messages (
    message_id INT NOT NULL AUTO_INCREMENT,
    sender_id INT NOT NULL,
    recipient_id  INT NOT NULL,
    message_text VARCHAR(255) NOT NULL,
    send_date DATE NOT NULL DEFAULT NOW(),
    message_time TIME NOT NULL DEFAULT NOW(),
    PRIMARY KEY (message_id),
    FOREIGN KEY (sender_id) REFERENCES users(user_id),
    FOREIGN KEY ( recipient_id ) REFERENCES users(user_id)
);


CREATE TABLE IF NOT EXISTS user_message_recipients (
    message_id INT NOT NULL,
    recipient_id INT NOT NULL,
    PRIMARY KEY (message_id, recipient_id),
    FOREIGN KEY (message_id) REFERENCES private_messages (message_id),
    FOREIGN KEY (recipient_id) REFERENCES users(user_id)
);
