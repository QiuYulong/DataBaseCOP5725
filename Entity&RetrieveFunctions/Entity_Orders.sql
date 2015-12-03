CREATE OR REPLACE FUNCTION CreateOrders(_customerid int,_paycardid integer,_shipaddress varchar(100),_orderstime date,_status integer)
RETURNS integer AS $BODY$
DECLARE
    newId integer;
BEGIN
    newId = nextvaL('orders_id_seq');
    INSERT INTO orders VALUES
    (newId,_customerid,_paycardid,_shipaddress,_orderstime,_status);
    RETURN newId;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION UpdateOrders(_id integer,_customerid int,_paycardid integer,_shipaddress varchar(100),_orderstime date,_status integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    UPDATE orders
    SET customerid=_customerid,paycardid=_paycardid,shipaddress=_shipaddress,orderstime=_orderstime,status=_status
    WHERE id=_id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION DeleteOrders(_id integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    DELETE FROM orders
    WHERE id = _id;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveOrdersById(_id integer)
RETURNS SETOF orders AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM orders
    WHERE id = _id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveOrdersAll()
RETURNS SETOF orders AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM orders;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

/*
SELECT CreateOrders(1,1,current_date,1);
SELECT UpdateOrders(6,1,1,current_date,0);
SELECT DeleteOrders(6);
SELECT RetrieveOrdersById(1);
SELECT RetrieveOrdersAll();
*/