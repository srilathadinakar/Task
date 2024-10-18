use ecommerce;

-- Table customers:
create table customers (
id int primary key auto_increment, 
name varchar(100) not null, 
email varchar(100) UNIQUE, 
address varchar(200) not null
);

describe customers;

-- Table orders:
create table orders(
id int auto_increment primary key,
customer_id int,
order_date DATE,
total_amount DECIMAL(10,2),
foreign key(customer_id) references customers(id)
);

describe orders;

-- Table products:
create table products(
product_id int auto_increment primary key,
name varchar(100),
price decimal(10,2),
description text
);

describe products;


-- Table customers Data
insert into customers(name, email, address) 
values 
('srilatha','sri@gmail.com','123, First Street'),
('vardhini','varu@gmail.com','8, middle Street'),
('rishi','rishi@gmail.com','20, park Street'),
('swetha','swe@gmail.com','15, main Street'),
('gobi','nath@gmail.com','2, Anna Street');

select * from customers;

-- Table orders Data
insert into orders(customer_id, order_date, total_amount) 
values 
(1, '2024-09-05', 100.00),
(2, '2024-10-15', 150.00),
(1, '2024-09-10', 200.00),
(3, '2024-09-25', 50.00),
(4, '2024-10-12', 200.00),
(3, '2024-10-05', 50.00);

select * from orders;

-- Table products Data
insert into products( name, price, description ) 
values 
('Product A', 100.00, 'Description For Product A'),
('Product B', 200.00, 'Description For Product B'),
('Product C', 500.00, 'Description For Product C'),
('Product D', 50.00, 'Description For Product D'),
('Product E', 80.00, 'Description For Product E');

select * from products;


-- Queries:
-- Que 1: Retrieve all customers who have placed an order in the last 30 days.
select distinct customers.name from customers 
join orders on customers.id = orders.customer_id
where orders.order_date >= curdate() - interval 30 day;


-- Que 2: Get the total amount of all orders placed by each customer.
select customers.name, sum(orders.total_amount) as total_spent 
from customers 
join orders on customers.id = orders.customer_id
group by customers.name;


-- Que 3: Update the price of Product C to 45.00.
update products set price = 45.00 where product_id = 3;
select * from products;


-- Que 4: Add a new column discount to the products table.
alter table products add column discount decimal(10,2) default 0.00;
select * from products;


-- Que 5: Retrieve the top 3 products with the highest price.
select name , price from products order by price desc limit 3;


-- Que 6: Get the names of customers who have ordered Product A.
select distinct customers.name from customers
join orders on customers.id = orders.customer_id 
join order_items on orders.id = order_items.order_id
join products on order_items.product_id = products.product_id
where products.name = 'Product A';


-- Que 7: Join the orders and customers tables to retrieve the customer's name and order date for each order. 
select customers.name, orders.order_date from customers 
join orders on customers.id = orders.customer_id;


-- Que 8 : Retrieve the orders with a total amount greater than 150.00.
select * from orders where total_amount > 150;


-- Que 9 : Normalize the database by creating a separate table for order items and updating the orders table to reference the order_items table.
-- Table order_items:
create table order_items(
id int auto_increment primary key,
order_id int,
product_id int,
quantity int,
foreign key (order_id) references orders(id),
foreign key(product_id) references products(product_id)
);

describe order_items;

-- Table order_items Data
insert into order_items(order_id, product_id, quantity)
values 
(1, 2, 2),
(2, 1, 4),
(3, 4, 1),
(4, 2, 2);

select * from order_items;


-- Que 10 : Retrieve the average total of all orders.
select avg(total_amount) from orders;