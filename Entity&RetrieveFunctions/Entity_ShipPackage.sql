CREATE OR REPLACE FUNCTION CreateShipPackage(_ordersid int,_shiptime date,_ispartial int,_carrierid int)
RETURNS integer AS $BODY$
DECLARE
    newId integer;
BEGIN
    newId = nextvaL('shippackage_id_seq');
    INSERT INTO shippackage VALUES
    (newId,_ordersid,_shiptime,_ispartial,_carrierid);
    RETURN newId;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION UpdateShipPackage(_id integer,_ordersid int,_shiptime date,_ispartial int,_carrierid int)
RETURNS void AS $BODY$
DECLARE
BEGIN
    UPDATE shippackage
    SET ordersid=_ordersid,shiptime=_shiptime,ispartial=_ispartial,carrierid=_carrierid
    WHERE id=_id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION DeleteShipPackage(_id integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    DELETE FROM shippackage
    WHERE id = _id;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveShipPackageById(_id integer)
RETURNS SETOF shippackage AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM shippackage
    WHERE id = _id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveShipPackageAll()
RETURNS SETOF shippackage AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM shippackage;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

/*
SELECT CreateShipPackage(1,current_date,'qiu home',1,1);
SELECT UpdateShipPackage(8,1,current_date,'qiu home',1,1);
SELECT DeleteShipPackage(8);
SELECT RetrieveShipPackageById(1);
SELECT RetrieveShipPackageAll();
*/