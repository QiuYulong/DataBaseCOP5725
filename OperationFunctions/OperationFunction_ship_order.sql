--11.ship_order
CREATE OR REPLACE FUNCTION ship_order(_ordersid int,_carrierid int)
RETURNS void AS $BODY$
DECLARE
    _items integer[];
    _item integer;
BEGIN
    FOR _item IN SELECT id FROM ordersproduct WHERE ordersid=_ordersid LOOP
        _items = array_append(_items,_item);
    END LOOP;
    IF _items IS NULL THEN
        UPDATE orders
        SET status = 1
        WHERE id = _ordersid;
        RETURN;
    ELSE
        PERFORM ship_item(_ordersid,_items,_carrierid);--use select to trick postgresql bugs
    END IF;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;