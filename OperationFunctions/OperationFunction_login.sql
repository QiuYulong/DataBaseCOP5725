--1.Login
CREATE OR REPLACE FUNCTION login(_username varchar(50), _password varchar(50))
RETURNS boolean AS $BODY$
DECLARE   
    matchresult integer;
BEGIN
    SELECT COUNT(*) INTO matchresult FROM customer WHERE username=_username AND password=_password;
    RETURN matchresult>0;
END;
$BODY$ LANGUAGE plpgsql;

--SELECT login('test2@gmail.com','1213456');