CREATE OR REPLACE FUNCTION CreateSupplier(_name varchar(50),_address varchar(100),_representativeid integer,_discount double precision)
RETURNS integer AS $BODY$
DECLARE
    newId integer;
BEGIN
    newId = nextvaL('supplier_id_seq');
    INSERT INTO supplier VALUES
    (newId,_name,_address,_representativeid,_discount);
    RETURN newId;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION UpdateSupplier(_id integer,_name varchar(50),_address varchar(100),_representativeid integer,_discount double precision)
RETURNS void AS $BODY$
DECLARE
BEGIN
    UPDATE supplier
    SET name=_name,address=_address,representativeid=_representativeid,discount=_discount
    WHERE id=_id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION DeleteSupplier(_id integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    DELETE FROM supplier
    WHERE id = _id;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveSupplierById(_id integer)
RETURNS SETOF supplier AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM supplier
    WHERE id = _id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveSupplierAll()
RETURNS SETOF supplier AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM supplier;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

/*
SELECT CreateSupplier('qiu','qiu home',1,0.90);
SELECT UpdateSupplier(8,'qiu','qiu yulong home',1,0.90);
SELECT DeleteSupplier(8);
SELECT RetrieveSupplierById(1);
SELECT RetrieveSupplierAll();
*/