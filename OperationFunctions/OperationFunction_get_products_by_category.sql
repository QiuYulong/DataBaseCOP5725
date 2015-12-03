--14.get_products_by_category
CREATE OR REPLACE FUNCTION get_products_by_category(_categoryid int)
RETURNS TABLE(cid int) AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    WITH RECURSIVE t(id, pid) as(
    SELECT c.id, c.parentid FROM category AS c WHERE id=_categoryid
    UNION ALL
    SELECT c.id, c.parentid FROM category AS c JOIN t ON c.parentid = t.id
)
    SELECT id FROM t;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

