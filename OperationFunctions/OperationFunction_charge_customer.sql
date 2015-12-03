--9.charge_customer
CREATE OR REPLACE FUNCTION charge_customer(_customerid int, _paycard varchar(20),_money numeric)
RETURNS void AS $BODY$
DECLARE
    _creditbalance numeric;
BEGIN
    --1.get current credit balance
    SELECT INTO _creditbalance creditbalance FROM customer WHERE id = _customerid;
    IF _creditbalance < _money THEN
        RAISE NOTICE 'charge customer(id=%) $% in creditbalance and $% in paycard(%)', _customerid, _creditbalance ,_money - _creditbalance, _paycard;
        UPDATE customer
        SET creditbalance = 0
        WHERE id = _customerid;
    ELSE
        RAISE NOTICE 'charge customer(id=%) $% in creditbalance', _customerid, _money;
        UPDATE customer
        SET creditbalance = creditbalance - _money
        WHERE id = _customerid;
    END IF;
END;
$BODY$ LANGUAGE plpgsql;