--12.update_inventory
CREATE OR REPLACE FUNCTION update_inventory(_productid int, _amount int)
RETURNS void AS $BODY$
DECLARE    
BEGIN
    UPDATE product AS p
    SET amount = amount + _amount
    WHERE id = _productid;
    IF _amount > 0 THEN
        RAISE NOTICE 'increase product(%), amount:%',_productid, _amount;
    ELSE
        RAISE NOTICE 'decrease product(%), amount:%',_productid, -_amount;
    END IF;
END;
$BODY$ LANGUAGE plpgsql;