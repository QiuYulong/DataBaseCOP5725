CREATE OR REPLACE FUNCTION CreateCarrier(_isinternational int,_isdomestic int,_shiphazardous int)
RETURNS integer AS $BODY$
DECLARE
    newId integer;
BEGIN
    newId = nextvaL('carrier_id_seq');
    INSERT INTO carrier VALUES
    (newId,_isinternational,_isdomestic,_shiphazardous);
    RETURN newId;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION UpdateCarrier(_id integer,_isinternational int,_isdomestic int,_shiphazardous int)
RETURNS void AS $BODY$
DECLARE
BEGIN
    UPDATE carrier
    SET isinternational=_isinternational,isdomestic=_isdomestic,shiphazardous=_shiphazardous
    WHERE id=_id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION DeleteCarrier(_id integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    DELETE FROM carrier
    WHERE id = _id;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveCarrierById(_id integer)
RETURNS SETOF carrier AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM carrier
    WHERE id = _id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveCarrierAll()
RETURNS SETOF carrier AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM carrier;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

/*
SELECT CreateCarrier(0,1,1);
SELECT UpdateCarrier(6,0,1,0);
SELECT DeleteCarrier(6);
SELECT RetrieveCarrierById(1);
SELECT RetrieveCarrierAll();
*/