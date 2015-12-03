--Entity Function: Create Address
CREATE OR REPLACE FUNCTION CreateAddress(_customerid integer, _address varchar(100), _isshippingpreferred integer)
RETURNS integer AS $BODY$
DECLARE
    newId integer;
BEGIN
    newId = nextval('address_id_seq');
    INSERT INTO address VALUES
    (newId, _customerid, _address, _isshippingpreferred);
    RETURN newId;
END;
$BODY$ LANGUAGE plpgsql;


--Entity Function: Update Address
CREATE OR REPLACE FUNCTION UpdateAddress(_id integer, _customerid integer, _address varchar(100), _isshippingpreferred integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    UPDATE address
    SET customerid=_customerid, address=_address, isshippingpreferred=_isshippingpreferred
    WHERE id=_id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

--Entity Function: Delete Address
CREATE OR REPLACE FUNCTION DeleteAddress(_id integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    DELETE FROM address
    WHERE id = _id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;


--Entity Function: Retrieve Address By Id
CREATE OR REPLACE FUNCTION RetrieveAddressById(_id integer)
RETURNS SETOF address AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM address
    WHERE id = _id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;


--Entity Function: Retrieve Address All
CREATE OR REPLACE FUNCTION RetrieveAddressAll()
RETURNS SETOF address AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM address;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

/*
SELECT CreateAddress(1,'heavon',0);
SELECT UpdateAddress(6,1,'hell',0);
SELECT DeleteAddress(6);
SELECT RetrieveAddressById(1);
SELECT RetrieveAddressAll();
*/