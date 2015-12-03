CREATE OR REPLACE FUNCTION CreateRepresentative(_name varchar(50),_phone varchar(20))
RETURNS integer AS $BODY$
DECLARE
    newId integer;
BEGIN
    newId = nextvaL('representative_id_seq');
    INSERT INTO representative VALUES
    (newId,_name,_phone);
    RETURN newId;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION UpdateRepresentative(_id integer,_name varchar(50),_phone varchar(20))
RETURNS void AS $BODY$
DECLARE
BEGIN
    UPDATE representative
    SET name=_name,phone=_phone
    WHERE id=_id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION DeleteRepresentative(_id integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    DELETE FROM representative
    WHERE id = _id;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveRepresentativeById(_id integer)
RETURNS SETOF representative AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM representative
    WHERE id = _id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveRepresentativeAll()
RETURNS SETOF representative AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM representative;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

/*
SELECT CreateRepresentative('Qiu','782372832');
SELECT UpdateRepresentative(6,'QQiu','782372832');
SELECT DeleteRepresentative(6);
SELECT RetrieveRepresentativeById(1);
SELECT RetrieveRepresentativeAll();
*/