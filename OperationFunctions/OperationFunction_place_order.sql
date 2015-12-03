--8.place_order
CREATE OR REPLACE FUNCTION place_order(_customerid integer,_addressid integer, _paycardid integer)
RETURNS TABLE(productid int, amount int) AS $BODY$
DECLARE
    _shopitem shoppingcart%ROWTYPE;--shopping cart row
    _itemamountininventory int;--product amount in inventory
    _paycardaccount varchar(20);--customer paycard account
    _shipaddress varchar(100);--orders ship address
    _neworderid int;--order id
    _newitemid int;--item id
    _itemsaleprice numeric;--item price
BEGIN
    --1.check available.
    FOR _shopitem IN SELECT * FROM shoppingcart WHERE customerid = _customerid
    LOOP
         SELECT INTO _itemamountininventory p.amount FROM product AS p WHERE id = _shopitem.productid;
         IF _shopitem.amount > _itemamountininventory THEN 
             RAISE 'product % is not enough',_shopitem.productid;
         END IF;
    END LOOP;
    --2.get paycard and address.
    SELECT INTO _paycardaccount account FROM paycard WHERE id = _paycardid;
    SELECT INTO _shipaddress address FROM address WHERE id = _addressid;
    --3.create new order.
    _neworderid = nextval('orders_id_seq');
    INSERT INTO orders VALUES
    (_neworderid,_customerid,_paycardaccount,_shipaddress,CURRENT_DATE,0);
    --4.create order detail.
    FOR _shopitem IN SELECT * FROM shoppingcart WHERE customerid = _customerid       
    LOOP
        --1)add to ordersproduct
        _newitemid = nextval('ordersproduct_id_seq');
        raise notice 'process item id %',_newitemid;
        SELECT INTO _itemsaleprice price FROM product WHERE id = _shopitem.productid;
        INSERT INTO ordersproduct VALUES
        (_newitemid, _neworderid, _shopitem.productid, _shopitem.amount, _itemsaleprice,NULL,0);
        --2)adjust product amount in inventory
        PERFORM update_inventory(_shopitem.productid,-_shopitem.amount);
    END LOOP;
    --5.clear shoppingcart
    DELETE FROM shoppingcart
    WHERE customerid = _customerid;
    
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;