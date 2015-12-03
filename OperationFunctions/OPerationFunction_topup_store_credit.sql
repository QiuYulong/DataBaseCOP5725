--13.top­up_store_credit
CREATE OR REPLACE FUNCTION topup_store_credit(_customerid int,_money numeric)
RETURNS numeric AS $BODY$
DECLARE
    _credit numeric;
BEGIN
    SELECT INTO _credit creditbalance FROM customer WHERE id = _customerid;
    RAISE NOTICE 'customer(%) has credit %, topup $%, current $%',_customerid,_credit,_money,_credit+_money;
    UPDATE customer
    SET creditbalance = creditbalance + _money
    WHERE id = _customerid;
    RETURN _credit+_money;
END;
$BODY$ LANGUAGE plpgsql;