CREATE OR REPLACE FUNCTION CreateShoppingCart(_customerid integer, _productid integer, _amount integer)
RETURNS integer AS $BODY$
DECLARE
    newId integer;   
BEGIN
    newId = nextvaL('shoppingcart_id_seq');
    INSERT INTO ShoppingCart VALUES
    (newId,_customerid,_productid,_amount);
    RETURN newId;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION UpdateShoppingCart(_id integer, _customerid integer, _productid integer, _amount integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    UPDATE shoppingcart
    SET customerid=_customerid, productid=_productid, amount=_amount
    WHERE id=_id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION DeleteShoppingCart(_id integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    DELETE FROM shoppingcart
    WHERE id = _id;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveShoppingCartById(_id integer)
RETURNS SETOF shoppingcart AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM shoppingcart
    WHERE id = _id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveShoppingCartAll()
RETURNS SETOF shoppingcart AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM shoppingcart;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

/*
SELECT CreateShoppingCart(5, 1, 5);
SELECT UpdateShoppingCart(6,5,1,6);
SELECT DeleteShoppingCart(6);
SELECT RetrieveShoppingCartById(1);
SELECT RetrieveShoppingCartAll();
*/