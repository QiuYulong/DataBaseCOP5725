CREATE OR REPLACE FUNCTION CreateExchange(_oldordersproductid int,_newordersproductid int,_refundid int)
RETURNS integer AS $BODY$
DECLARE
    newId integer;
BEGIN
    newId = nextvaL('exchange_id_seq');
    INSERT INTO exchange VALUES
    (newId,_oldordersproductid,_newordersproductid,_refundid);
    RETURN newId;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION UpdateExchange(_id integer,_oldordersproductid int,_newordersproductid int,_refundid int)
RETURNS void AS $BODY$
DECLARE
BEGIN
    UPDATE exchange
    SET oldordersproductid=_oldordersproductid,newordersproductid=_newordersproductid,refundid=_refundid
    WHERE id=_id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION DeleteExchange(_id integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    DELETE FROM exchange
    WHERE id = _id;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveExchangeById(_id integer)
RETURNS SETOF exchange AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM exchange
    WHERE id = _id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveExchangeAll()
RETURNS SETOF exchange AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM exchange;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

/*
SELECT CreateExchange(3,7,1);
SELECT UpdateExchange(6,3,8,1);
SELECT DeleteExchange(6);
SELECT RetrieveExchangeById(1);
SELECT RetrieveExchangeAll();
*/