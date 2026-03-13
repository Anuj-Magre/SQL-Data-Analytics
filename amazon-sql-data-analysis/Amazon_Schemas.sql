
-- ---------------------------
-- Amazon_data_analysis_Project
-- ---------------------------

-- Hi please make sure to follow below hirearary to import the data
-- 1st import to category table
-- 2nd Import to customers
-- 3rd Import to sellers
-- 4th Import to Products
-- 5th Import to orders
-- 6th Import to order_items
-- 7th Import to payments
-- 8th Import to shippings table
-- 9th Import to Inventory Table

DROP TABLE IF EXISTS shippings;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS sellers;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS category;

-- ------------------------------------------------------
-- create parent table ( category , customers , sellers )
-- ------------------------------------------------------


-- category table
-- --------------

create table category (
category_id	int primary key,
category_name varchar(50)
);

-- customers table
-- ---------------

create table customers (
Customer_ID	int primary key,
first_name	varchar(50),
last_name	varchar(50),
state varchar(50),
address varchar(5) default('xxxx')
);

-- sellers table
-- -------------

create table sellers (
seller_id int primary key,
seller_name	varchar(50),
origin varchar(50)
);

-- -------------------------------------------------------------------------------------
-- create child tables ( products , orders , orders item , inventor , payment ,shipping)
-- -------------------------------------------------------------------------------------

--  product table
-- --------------

create table products (
product_id int primary key,
product_name varchar(50),
price float,
cogs float,
category_id int ,   -- fk
seller_id int,   -- fk
constraint product_fk_category foreign key (category_id) references category (category_id),
constraint product_fk_seller foreign key (seller_id) references sellers (seller_id)
);


-- orders table fact table
-- -----------------------

create table orders (
order_id int primary key,
order_date date,
customer_id	int,  -- fk
seller_id int,  -- fk
order_status varchar(50),
constraint orders_fk_customers foreign key (customer_id) references customers(customer_id),
constraint orders_fk_sellers foreign key (seller_id) references sellers(seller_id)
);


-- order_item table
-- -----------------

create table order_items (
order_item_id int primary key,
order_id int,  -- fk
product_id int,  -- fk
quantity int,
price_per_unit float,
constraint order_items_fk_orders foreign key (order_id) references orders (order_id),
constraint order_items_fk_products foreign key (product_id) references products (product_id)
);


-- payment table
-- -------------

create table payments (
payment_id int primary key,
order_id int,  -- fk
payment_date date,	
payment_status varchar(50),
constraint payments_fk_orders foreign key (order_id) references orders (order_id)
);

-- shipping table
-- --------------

create table shipping (
shipping_id	int primary key,
order_id int, -- fk
shipping_date varchar(50),
return_date	varchar(50),
shipping_provider varchar(50),	
delivery_status varchar(50),
constraint shipping_fk_orders foreign key (order_id) references orders (order_id)
);

-- inventory table
-- ---------------

create table inventory (
inventory_id int primary key,
product_id	int, -- fk
stock int ,
warehouse_id int,	
last_stock_date date,
constraint inventory_fk_products foreign key (product_id) references products (product_id)
);


-- End of schemas