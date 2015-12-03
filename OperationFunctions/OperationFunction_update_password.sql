--2.update_password
CREATE OR REPLACE FUNCTION update_password(_username varchar(50),_oldpassword varchar(50),_newpassword varchar(50))
RETURNS varchar(50) AS $BODY$
DECLARE
BEGIN
    IF login(_username,_oldpassword) THEN
        UPDATE customer SET password=_newpassword WHERE username=_username;
        RETURN 'update success';
    ELSE
        RETURN 'user name or password is wrong, update fail.';
    END IF;
END;
$BODY$ LANGUAGE plpgsql;

--SELECT update_password('test2@gmail.com','123456','123');