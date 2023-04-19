 
              Database Setup for P.E.T. Platform Launch

Description:

  --This is a school project where we create a MariaDB database
  for our client, P.E.T., a startup planning to launch their new platform in 2024. The platform will be a combination of a webshop targeting pet owners and a social network where customers can engage with each other. Our team has been tasked with preparing and presenting a database setup for the platform. As the platform is not yet fully designed, we will need to be flexible and adaptable to changes in the customer's requirements as the project progresses.
  
Database Design:

The database design consists of the following tables:

-- users
-- countries
-- user_addresses
-- roles
-- user_role_counts
-- products
-- categories
-- product_categories
-- inventory
-- stores
-- store_inventory
-- store_addresses
-- orders
-- order_products
-- groups_name
-- group_members
-- group_messages
-- private_messages
-- user_message_recipients

Prerequisites:

--Before using this database, please ensure that you have installed and configured MariaDB on your local machine or server. You can download the latest version of MariaDB from their official website (https://mariadb.org/) and follow the installation instructions based on your operating system.

--We recommend that you secure the MariaDB installation by running the following command in the terminal:
   mysql_secure_installation

 -- You should also create a new database user with limited privileges for security purposes. You can use the following commands to create a new database user:

    CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';

    GRANT ALL PRIVILEGES ON database_name.* TO 'username'@'localhost';

    FLUSH PRIVILEGES;

--Please ensure that you have appropriate privileges to create a new database and tables.


Installation:

To set up the P.E.T. Platform Launch database, follow these steps:

Open a terminal and navigate to the directory where you want to store the database files.

Run the following command to log in to MariaDB using your new database user credentials:

     mysql -h <ip> -u username -p

     CREATE DATABASE pet_platform_launch;

     USE pet_platform_launch;

     source path/to/p_e_t_schema.sql;

    source path/to/p_e_t_data.sql;
    

Sample Data:

The p_e_t_data.sql file includes sample data that can be used to test the database. The data includes sample users, products, stores, and messages, among other things. Please note that this data is for testing purposes only and should be replaced with real data before launching the platform.

Testing the database:

To ensure that the database is set up correctly and meets the requirements, we have provided a set of queries that can be used for testing.

To run the test queries, follow the steps below:

    source path/to/query_test.sql;