CREATE OR REPLACE FUNCTION CreateRefund(_status int,_paycardid int)
RETURNS integer AS $BODY$
DECLARE
    newId integer;
BEGIN
    newId = nextvaL('refund_id_seq');
    INSERT INTO refund VALUES
    (newId,_status,_paycardid);
    RETURN newId;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION UpdateRefund(_id integer,_status int,_paycardid int)
RETURNS void AS $BODY$
DECLARE
BEGIN
    UPDATE refund
    SET status=_status,paycardid=_paycardid
    WHERE id=_id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION DeleteRefund(_id integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    DELETE FROM refund
    WHERE id = _id;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveRefundById(_id integer)
RETURNS SETOF refund AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM refund
    WHERE id = _id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveRefundAll()
RETURNS SETOF refund AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM refund;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

/*
SELECT CreateRefund(0,1);
SELECT UpdateRefund(13,0,2);
SELECT DeleteRefund(13);
SELECT RetrieveRefundById(1);
SELECT RetrieveRefundAll();
*/