--10.ship_item
CREATE OR REPLACE FUNCTION ship_item(_ordersid int,_ordersproductidlist int[],_carrierid int)
RETURNS void AS $BODY$
DECLARE
    _customerid int;--customerid
    _account varchar(20);--customer paycard account
    _itemcountinorder int;--how many items in this order, determine whether it is partial or not.
    _unshipped_itemcountinorder int;--how many items not shipped, update orders status when ship last package.
    _newshippackageid int;--new shippackage id

    _itemamount int;--item amount of current ordersproduct;
    _itemprice numeric; --item price of current ordersproduct when sale;
    _chargeamount numeric;
    _itemid int;--item id;
    _ispartial int;--is partial shipment
BEGIN
    --ship item    
    _chargeamount = 0;
    --update ship package  
    _newshippackageid = nextval('shippackage_id_seq');
    SELECT INTO _itemcountinorder COUNT(*) FROM ordersproduct WHERE ordersid=_ordersid;
    IF _itemcountinorder > array_length(_ordersproductidlist,1) THEN --ship partial
        _ispartial = 1;
    ELSE --ship all.
        _ispartial = 0;
    END IF;
    INSERT INTO shippackage VALUES
    (_newshippackageid,_ordersid,CURRENT_DATE,_ispartial,_carrierid);--not partial  

    --update ordersproduct.
    FOREACH _itemid in ARRAY _ordersproductidlist LOOP    
        --udpate item status to 'shipped'
        UPDATE ordersproduct
        SET shippackageid=_newshippackageid, status = 1
        WHERE id = _itemid;

        SELECT INTO _itemamount,_itemprice amount,saleprice FROM ordersproduct WHERE id = _itemid;
        _chargeamount = _chargeamount + _itemamount * _itemprice;
    END LOOP;
     
    --charge customer 
    SELECT INTO _customerid,_account customerid,paycardaccount FROM orders WHERE id = _ordersid;       
    PERFORM charge_customer(_customerid, _account, _chargeamount);
  
    --when all shipped, update orders status to done.
    SELECT INTO _unshipped_itemcountinorder COUNT(*) FROM ordersproduct WHERE ordersid=_ordersid AND status = 0;
    IF _unshipped_itemcountinorder = 0 THEN
        UPDATE orders
        SET status = 1
        WHERE id = _ordersid;
    END IF;

    RETURN;
END;
$BODY$ LANGUAGE plpgsql;