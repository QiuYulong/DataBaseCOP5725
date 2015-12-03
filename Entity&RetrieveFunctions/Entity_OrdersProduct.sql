CREATE OR REPLACE FUNCTION CreateOrdersProduct(_orderid int,_productid int,_amount int,_saleprice numeric,_shippackageid int,_status int)
RETURNS integer AS $BODY$
DECLARE
    newId integer;
BEGIN
    newId = nextvaL('ordersproduct_id_seq');
    INSERT INTO ordersproduct VALUES
    (newId,_orderid,_productid,_amount,_saleprice,_shippackageid,_status);
    RETURN newId;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION UpdateOrdersProduct(_id integer,_ordersid int,_productid int,_amount int,_saleprice numeric,_shippackageid int,_status int)
RETURNS void AS $BODY$
DECLARE
BEGIN
    UPDATE ordersproduct
    SET ordersid=_ordersid,productid=_productid,amount=_amount,saleprice=_saleprice,shippackageid=_shippackageid,status=_status
    WHERE id=_id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION DeleteOrdersProduct(_id integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    DELETE FROM ordersproduct
    WHERE id = _id;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveOrdersProductById(_id integer)
RETURNS SETOF ordersproduct AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM ordersproduct
    WHERE id = _id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveOrdersProductAll()
RETURNS SETOF ordersproduct AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM ordersproduct;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

/*
SELECT CreateOrdersProduct(6,1,1,8.99,1);
SELECT UpdateOrdersProduct(12,6,1,1,8.99,2);
SELECT DeleteOrdersProduct(12);
SELECT RetrieveOrdersProductById(1);
SELECT RetrieveOrdersProductAll();
*/