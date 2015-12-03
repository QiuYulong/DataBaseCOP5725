CREATE OR REPLACE FUNCTION CreateProduct(_name varchar(50),_description text,_picture varchar(100),_price numeric,
    _categoryid integer,_amount integer,_lowthreshold integer,_hazardous integer,_needseperatedshipping integer)
RETURNS integer AS $BODY$
DECLARE
    newId integer;
BEGIN
    newId = nextvaL('product_id_seq');
    INSERT INTO product VALUES
    (newId,_name,_description,_picture,_price,_categoryid,_amount,_lowthreshold,_hazardous,_needseperatedshipping);
    RETURN newId;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION UpdateProduct(_id integer, _name varchar(50),_description text,_picture varchar(100),_price numeric,
    _categoryid integer,_amount integer,_lowthreshold integer,_hazardous integer,_needseperatedshipping integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    UPDATE product
    SET name=_name,description=_description,picture=_picture,price=_price,categoryid=_categoryid,amount=_amount,
        lowthreshold=_lowthreshold,hazardous=_hazardous,needseperatedshipping=_needseperatedshipping
    WHERE id=_id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION DeleteProduct(_id integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    DELETE FROM product
    WHERE id = _id;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveProductById(_id integer)
RETURNS SETOF product AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM product
    WHERE id = _id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveProductAll()
RETURNS SETOF product AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM product;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

/*
SELECT CreateProduct('beats in ears','wireless earphone','6.png',234.9,5,100,60,0,0);
SELECT UpdateProduct(6,'beats in ears','wireless earphone','6.png',254.9,5,100,60,0,0);
SELECT DeleteProduct(6);
SELECT RetrieveProductById(1);
SELECT RetrieveProductAll();
*/