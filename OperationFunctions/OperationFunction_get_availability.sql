--5.get_availability
CREATE OR REPLACE FUNCTION get_availability(_productid integer)
RETURNS integer AS $BODY$
DECLARE
    itemsInInventory integer;
    itemsInPending integer;
BEGIN
    SELECT INTO itemsInInventory amount FROM product WHERE id = _productid;
    IF NOT FOUND THEN 
        itemsInInventory=0;
    END IF;
    SELECT INTO itemsInPending SUM(amount) FROM ordersproduct WHERE productid=_productid AND (status = 0 or status = 2);
    IF itemsInPending IS NULL THEN
        itemsInPending=0;
    END IF;
    RETURN itemsInInventory + itemsInPending;
END;
$BODY$ LANGUAGE plpgsql;