--7.remove_from_cart
CREATE OR REPLACE FUNCTION remove_from_cart(_customerid integer, _productid integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    DELETE FROM shoppingcart
    WHERE customerid=_customerid and productid=_productid;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;
