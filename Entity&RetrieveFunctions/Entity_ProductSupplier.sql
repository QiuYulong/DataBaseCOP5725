CREATE OR REPLACE FUNCTION CreateProductSupplier(_productid integer,_supplierid integer,_price numeric)
RETURNS integer AS $BODY$
DECLARE
    newId integer;
BEGIN
    newId = nextvaL('productsupplier_id_seq');
    INSERT INTO productsupplier VALUES
    (newId,_productid,_supplierid,_price);
    RETURN newId;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION UpdateProductSupplier(_id integer,_productid integer,_supplierid integer,_price numeric)
RETURNS void AS $BODY$
DECLARE
BEGIN
    UPDATE productsupplier
    SET productid=_productid,supplierid=_supplierid,price=_price
    WHERE id=_id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION DeleteProductSupplier(_id integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    DELETE FROM productsupplier
    WHERE id = _id;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveProductSupplierById(_id integer)
RETURNS SETOF productsupplier AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM productsupplier
    WHERE id = _id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveProductSupplierAll()
RETURNS SETOF productsupplier AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM productsupplier;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

/*
SELECT CreateProductSupplier(3,1,12.00);
SELECT UpdateProductSupplier(8,3,1,12.05);
SELECT DeleteProductSupplier(8);
SELECT RetrieveProductSupplierById(1);
SELECT RetrieveProductSupplierAll();
*/