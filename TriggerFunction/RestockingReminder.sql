--reminder trigger: create restocking when product amount is less than specified threshold.
CREATE OR REPLACE FUNCTION trigger_reminder_procedure()
RETURNS TRIGGER AS $BODY$
DECLARE
    _supplierid int;
    _price numeric;
    _itemsupplier productsupplier%ROWTYPE;
    _supplierdiscount double precision;
BEGIN
    RAISE NOTICE 'trigger reminder: product(%) amount lower than threshold',NEW.id;
    --update restocking table
        --get minimum price     
    _price = 9999999;
    FOR _itemsupplier IN SELECT * FROM productsupplier WHERE productid = NEW.id LOOP
        SELECT INTO _supplierdiscount discount FROM supplier WHERE id = _itemsupplier.supplierid;
        IF _price > _itemsupplier.price * _supplierdiscount THEN
            _price = _itemsupplier.price * _supplierdiscount;
            _supplierid = _itemsupplier.supplierid;
        END IF;
    END LOOP;
        --create restocking
    INSERT INTO restocking VALUES
    (DEFAULT, NEW.id, _supplierid, OLD.lowthreshold+100-NEW.amount, _price, 0);
    RAISE NOTICE 'trigger reminder: product(%) restocking %',OLD.id,OLD.lowthreshold+100-NEW.amount;
    --
    RETURN NEW;
END;
$BODY$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_reminder AFTER UPDATE ON product
FOR EACH ROW
WHEN (NEW.amount < NEW.lowthreshold )
EXECUTE PROCEDURE trigger_reminder_procedure();

--DROP TRIGGER trigger_reminder ON product;

