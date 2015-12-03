--3.set_preferred_shipping_address
CREATE OR REPLACE FUNCTION set_preferred_shipping_address(_addressid integer)
RETURNS void AS $BODY$
DECLARE
    cid integer;
BEGIN
    SELECT customerid INTO cid FROM address WHERE id=_addressid;
    UPDATE address SET isshippingpreferred = 0 WHERE customerid = cid;
    UPDATE address SET isshippingpreferred = 1 WHERE id = _addressid;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

--select * from address;
--SELECT set_preferred_shipping_address(7);