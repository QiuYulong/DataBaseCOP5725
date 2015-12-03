CREATE OR REPLACE FUNCTION CreateCategory(_parentid integer, _name varchar(50))
RETURNS integer AS $BODY$
DECLARE
    newId integer;
BEGIN
    newId = nextvaL('category_id_seq');
    INSERT INTO category VALUES
    (newId,_parentid,_name);
    RETURN newId;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION UpdateCategory(_id integer,_parentid integer,_name varchar(50))
RETURNS void AS $BODY$
DECLARE
BEGIN
    UPDATE category
    SET parentid=_parentid,name=_name
    WHERE id=_id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION DeleteCategory(_id integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    DELETE FROM category
    WHERE id = _id;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveCategoryById(_id integer)
RETURNS SETOF category AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM category
    WHERE id = _id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveCategoryAll()
RETURNS SETOF category AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM category;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

/*
SELECT CreateCategory(3,'Audio in ear');
SELECT UpdateCategory(7,3,'Audio Inear');
SELECT DeleteCategory(7);
SELECT RetrieveCategoryById(1);
SELECT RetrieveCategoryAll();
*/