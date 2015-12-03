-- Database: miniworld created by Yulong Qiu (5314513) for Database Homework 3

/* Notice:
* You must created database ‘miniworld’ first before running this script for DDL and DML.
* because postgresql does not support creating database and then switch to it using sql command.
* so creating database and running DDL&DML can not be executed at the same time in one sql file.
*/


-- DROP DATABASE miniworld;

--CREATE DATABASE miniworld;

--1.customer
CREATE SEQUENCE customer_id_seq;
CREATE TABLE customer
(id integer primary key default nextval('customer_id_seq'),
username varchar(50) not null unique,--email address
password varchar(50) not null,
fullname varchar(50) not null,
phone varchar(50) not null,
creditbalance numeric not null check (creditbalance >= 0)
);

--2.address
CREATE SEQUENCE address_id_seq;
CREATE TABLE address
(id integer primary key default nextval('address_id_seq'),
customerid int not null references customer(id),
address varchar(100) not null,
isshippingpreferred integer not null check(isshippingpreferred = 0 or isshippingpreferred = 1)
);

--3.paycard
CREATE SEQUENCE paycard_id_seq;
CREATE TABLE paycard
(id integer primary key default nextval('paycard_id_seq'),
account varchar(20) not null unique,
addressid int not null references address(id),
ispaymentpreferred int not null check(ispaymentpreferred = 0 or ispaymentpreferred = 1)
);

--4.category
CREATE SEQUENCE category_id_seq;
CREATE TABLE category
(id int primary key default nextval('category_id_seq'),
parentid int references category(id),
name varchar(50)
);

--5.product
CREATE SEQUENCE product_id_seq;
CREATE TABLE product
(id integer primary key default nextval('product_id_seq'),
name varchar(50) not null unique,
description text,
picture varchar(100),
price numeric not null check(price >= 0),
categoryid int not null references category(id),
amount int not null check(amount >=0),
lowthreshold int not null check(lowthreshold >= 0),
hazardous int not null  check(hazardous = 0 or hazardous = 1),
needseperatedshipping int not null check(needseperatedshipping = 0 or needseperatedshipping = 1)
);

--6.ShoppingCart
CREATE SEQUENCE shoppingcart_id_seq;
CREATE TABLE shoppingcart
(id integer primary key default nextval('shoppingcart_id_seq'),
customerid integer not null references customer(id),
productid integer not null references product(id),
amount integer not null check(amount >=0)
);

--7.representative
CREATE SEQUENCE representative_id_seq;
CREATE TABLE representative
(id int primary key default nextval('representative_id_seq'),
name varchar(50) not null,
phone varchar(20) not null
);

--8.supplier
CREATE SEQUENCE supplier_id_seq;
CREATE TABLE supplier
(id int primary key default nextval('supplier_id_seq'),
name varchar(50) not null unique,
address varchar(100) not null,
representativeid int not null references representative(id),
discount float not null check(discount >=0 and discount <=1)
);

--9.productsupplier
CREATE SEQUENCE productsupplier_id_seq;
CREATE TABLE productsupplier
(id int primary key default nextval('productsupplier_id_seq'),
productid int not null references product(id),
supplierid int not null references supplier(id),
price numeric not null check(price >= 0)
);

--10.restocking
CREATE SEQUENCE restocking_id_seq;
CREATE TABLE restocking
(id int primary key default nextval('restocking_id_seq'),
productid int not null references product(id),
supplierid int not null references supplier(id),
amount int not null check(amount > 0),
price numeric,
status int not null check(status = 0 or status = 1)
);

--11.orders
CREATE SEQUENCE orders_id_seq;
CREATE TABLE orders
(id int primary key default nextval('orders_id_seq'),
customerid int not null references customer(id),
paycardaccount varchar(20) not null,--it must be a copy for the reason that card may be deleted.
shipaddress varchar(100) not null,--ship address must be a copy, all items in one order ship to one address.
orderstime date not null,
status int not null check(status = 0 or status = 1)
);

--12.carrier
CREATE SEQUENCE carrier_id_seq;
CREATE TABLE carrier
(id int primary key default nextval('carrier_id_seq'),
isinternational int not null check(shiphazardous = 0 or shiphazardous = 1),
isdomestic int not null check(shiphazardous = 0 or shiphazardous = 1),
shiphazardous int not null check(shiphazardous = 0 or shiphazardous = 1)
);

--13.shippackage
CREATE SEQUENCE shippackage_id_seq;
CREATE TABLE shippackage
(id int primary key default nextval('shippackage_id_seq'),
ordersid int not null references orders(id),
shiptime date not null,
ispartial int not null check(ispartial = 0 or ispartial = 1),
carrierid int not null references carrier(id)
);

--14.ordersproduct
CREATE SEQUENCE ordersproduct_id_seq;
CREATE TABLE ordersproduct
(id int primary key default nextval('ordersproduct_id_seq'),
ordersid int not null references orders(id),
productid int not null references product(id),
amount int not null check(amount > 0),
saleprice numeric not null check(saleprice >= 0),--product price when place order. price may change.
shippackageid int references shippackage(id),--specified when shipped.
status int not null check(status between 0 and 4) --0:pending, 1:shipped, 2:pending exchange shipment, 3:exchanged, 4:returned.
);

--15.refund
CREATE SEQUENCE refund_id_seq;
CREATE TABLE refund
(id int primary key default nextval('refund_id_seq'),
status int not null check(status = 0 or status = 1),
paycardid int references paycard(id)
);

--16.exchange
CREATE SEQUENCE exchange_id_seq;
CREATE TABLE exchange
(id int primary key default nextval('exchange_id_seq'),
oldordersproductid int not null references ordersproduct(id),
newordersproductid int not null references ordersproduct(id),
refundid int not null references refund(id) 
);

--17.returned
CREATE SEQUENCE returned_id_seq;
CREATE TABLE returned
(id int primary key default nextval('returned_id_seq'),
ordersproductid int references ordersproduct(id),
refundid int references refund(id)
);

--18.view
CREATE VIEW orderview as
SELECT *
FROM ordersproduct
GROUP BY ordersproduct.id;

/*

DROP VIEW if exists orderview;
DROP TABLE if exists returned;
DROP TABLE if exists exchange;
DROP TABLE if exists refund;
DROP TABLE if exists ordersproduct;
DROP TABLE if exists shippackage;
DROP TABLE if exists carrier;
DROP TABLE if exists orders;
DROP TABLE if exists restocking;
DROP TABLE if exists productsupplier;
DROP TABLE if exists supplier;
DROP TABLE if exists representative;
DROP TABLE if exists shoppingcart;
DROP TABLE if exists product;
DROP TABLE if exists category;
DROP TABLE if exists paycard;
DROP TABLE if exists address;
DROP TABLE if exists customer;

DROP SEQUENCE if exists customer_id_seq;
DROP SEQUENCE if exists address_id_seq;
DROP SEQUENCE if exists paycard_id_seq;
DROP SEQUENCE if exists category_id_seq;
DROP SEQUENCE if exists product_id_seq;
DROP SEQUENCE if exists shoppingcart_id_seq;
DROP SEQUENCE if exists representative_id_seq;
DROP SEQUENCE if exists supplier_id_seq;
DROP SEQUENCE if exists productsupplier_id_seq;
DROP SEQUENCE if exists restocking_id_seq;
DROP SEQUENCE if exists orders_id_seq;
DROP SEQUENCE if exists ordersproduct_id_seq;
DROP SEQUENCE if exists carrier_id_seq;
DROP SEQUENCE if exists shippackage_id_seq;
DROP SEQUENCE if exists refund_id_seq;
DROP SEQUENCE if exists exchange_id_seq;
DROP SEQUENCE if exists returned_id_seq;

*/


/*DML of database miniworld.
created by Yulong Qiu 5314513 for database homework project 3
*/

/*
--1.Customer
INSERT INTO Customer VALUES

--2.Address
INSERT INTO Address VALUES

--3.paycard
INSERT INTO paycard VALUES

--4.category
INSERT INTO category VALUES

--5.product
INSERT INTO product VALUES

--6.shoppingcart
INSERT INTO shoppingcart VALUES

--7.representative
INSERT INTO representative VALUES

--8.supplier
INSERT INTO supplier VALUES

--9.productsupplier
INSERT INTO productsupplier VALUES


--10.restocking
INSERT INTO restocking VALUES

--11.orders
INSERT INTO orders VALUES


--12.carrier
INSERT INTO carrier VALUES


--13.shippackage
INSERT INTO shippackage VALUES


--14.ordersproduct
INSERT INTO ordersproduct VALUES


--15.refund
INSERT INTO refund VALUES

--16.exchange
INSERT INTO exchange VALUES

--17.returned
INSERT INTO returned VALUES


*/
