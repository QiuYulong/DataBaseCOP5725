CREATE OR REPLACE FUNCTION CreatePayCard(_account varchar(20), _addressid integer, _ispaymentpreferred integer)
RETURNS integer AS $BODY$
DECLARE
    newId integer;
BEGIN
    newId = nextval('paycard_id_seq');
    INSERT INTO paycard VALUES
    (newId,_account,_addressid,_ispaymentpreferred);
    RETURN newid;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION UpdatePayCard(_id integer, _account varchar(20), _addressid integer, _ispaymentpreferred integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    UPDATE paycard
    SET account=_account,addressid=_addressid,ispaymentpreferred=_ispaymentpreferred
    WHERE id=_id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION DeletePayCard(_id integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    DELETE FROM paycard
    WHERE id=_id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrievePayCardById(_id integer)
RETURNS SETOF paycard AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM paycard
    WHERE id=_id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrievePayCardAll()
RETURNS SETOF paycard AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM paycard;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

/*
SELECT CreatePayCard('12121223224243',7,1);
SELECT UpdatePayCard(6,'121212232242431',7,1);
SELECT DeletePayCard(6);
SELECT RetrievePayCardById(1);
SELECT RetrievePayCardAll();
*/