CREATE OR REPLACE FUNCTION CreateReturned(_ordersproductid int,_refundid int)
RETURNS integer AS $BODY$
DECLARE
    newId integer;
BEGIN
    newId = nextvaL('returned_id_seq');
    INSERT INTO returned VALUES
    (newId,_ordersproductid,_refundid);
    RETURN newId;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION UpdateReturned(_id integer, _ordersproductid int,_refundid int)
RETURNS void AS $BODY$
DECLARE
BEGIN
    UPDATE returned
    SET ordersproductid=_ordersproductid,refundid=_refundid
    WHERE id=_id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION DeleteReturned(_id integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    DELETE FROM returned
    WHERE id = _id;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveReturnedById(_id integer)
RETURNS SETOF returned AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM returned
    WHERE id = _id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RetrieveReturnedAll()
RETURNS SETOF returned AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM returned;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

/*
SELECT CreateReturned(10,1);
SELECT UpdateReturned(6,10,2);
SELECT DeleteReturned(6);
SELECT RetrieveReturnedById(1);
SELECT RetrieveReturnedAll();
*/