/*
Test script for demo.
*/

--1.login
SELECT login('qiu1@gmail.com','12345');
SELECT login('qiu1@gmail.com','123456');

--2.update password
SELECT update_password('qiu1@gmail.com','1234567','123456');--fail
SELECT update_password('qiu1@gmail.com','123456','123456');--success

--3.set_preferred_shipping_address
SELECT * FROM RetrieveAddressAll();
SELECT set_preferred_shipping_address(1);--set 1 as preferred
SELECT set_preferred_shipping_address(2);--set 2 as preferred

--4.set_preferred_payment_method
SELECT * FROM RetrievePayCardAll();
SELECT set_preferred_payment_method(1);--set 1 as preferred
SELECT set_preferred_payment_method(2);--set 2 as preferred

--5.view product
SELECT * FROM RetrieveProductALL();

--6.get_availability
SELECT get_availability(2);--product 2
SELECT get_availability(3);--product 3

--7.add_to_cart
SELECT add_to_cart(1,2,10);--customer(1) puts 10 product(2) into shopping cart.
SELECT * FROM RetrieveShoppingCartAll();--show shopping cart
SELECT remove_from_cart(1,2);--remove customer 1 product 2.
SELECT add_to_cart(1,2,10);--customer(1) puts 10 product(2) into shopping cart.
SELECT add_to_cart(1,3,10);--customer(1) puts 10 product(2) into shopping cart.

--8.place_order, update_inventory
SELECT place_order(1,1,2);--place customer(1)'s order with address(1), paycard(2)
SELECT * FROM RetrieveShoppingCartAll();--show shopping cart
SELECT * FROM RetrieveProductAll();
SELECT * FROM RetrieveOrdersAll();
SELECT * FROM RetrieveOrdersProductAll();

--9.ship_order, ship_item, charge_customer
SELECT ship_order(16,1);--ship orders(3) by carrier(1);
SELECT * FROM RetrieveOrdersAll();
SELECT * FROM RetrieveOrdersProductAll();
SELECT * FROM RetrieveShipPackageAll();
SELECT * FROM RetrieveCustomerAll();

--10.check customer credit
SELECT topup_store_credit(1,100);
SELECT * FROM RetrieveCustomerAll();

--11.get_products_by_category
SELECT get_products_by_category(3);

--12.test trigger
SELECT update_inventory(2,-20);
SELECT * FROM RetrieveProductAll();
SELECT * FROM RetrieveRestockingAll();
SELECT * FROM RetrieveSupplierAll();
SELECT * FROM RetrieveProductSupplierAll();

--13.roll back data
update customer
set creditbalance=2000.0
where id = 1;
update product
set amount=95
where id=2 or id=3;