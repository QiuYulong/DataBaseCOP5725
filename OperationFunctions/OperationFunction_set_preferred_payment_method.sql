--4.set_preferred_payment_method
CREATE OR REPLACE FUNCTION set_preferred_payment_method(_paycardid integer)
RETURNS void AS $BODY$
DECLARE
    _addressid integer;
    _userid integer;
BEGIN
    SELECT INTO _addressid addressid FROM paycard WHERE id = _paycardid;
    SELECT INTO _userid customerid FROM address WHERE id = _addressid;
    UPDATE paycard SET ispaymentpreferred = 0 WHERE addressid IN (SELECT id FROM address WHERE customerid=_userid);
    UPDATE paycard SET ispaymentpreferred = 1 WHERE id = _paycardid;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

--select * from paycard;
--select set_preferred_payment_method(6);