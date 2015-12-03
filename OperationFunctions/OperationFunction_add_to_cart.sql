--6.add_to_cart
CREATE OR REPLACE FUNCTION add_to_cart(_customerid integer, _productid integer,_amount integer)
RETURNS void AS $BODY$
DECLARE
BEGIN   
    INSERT INTO shoppingcart VALUES
    (default,_customerid,_productid,_amount);
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;
