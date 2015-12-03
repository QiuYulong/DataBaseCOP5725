CREATE OR REPLACE FUNCTION CreateRestocking(_productid integer,_supplierid integer,_amount integer,_status integer)
RETURNS integer AS $BODY$
DECLARE
    newId integer;
BEGIN
    newId = nextvaL('restocking_id_seq');
    INSERT INTO restocking VALUES
    (newId,_productid,_supplierid,_amount,_status);
    RETURN newId;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION UpdateRestocking(_id integer, _productid integer,_supplierid integer,_amount integer,_status integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    UPDATE restocking
    SET productid=_productid,supplierid=_supplierid,amount=_amount,status=_status
    WHERE id=_id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION DeleteRestocking(_id integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    DELETE FROM restocking
    WHERE id = _id;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveRestockingById(_id integer)
RETURNS SETOF restocking AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM restocking
    WHERE id = _id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveRestockingAll()
RETURNS SETOF restocking AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM restocking;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

/*
SELECT CreateRestocking(1,1,10,0);
SELECT UpdateRestocking(6,1,1,10,1);
SELECT DeleteRestocking(6);
SELECT RetrieveRestockingById(1);
SELECT RetrieveRestockingAll();
*/