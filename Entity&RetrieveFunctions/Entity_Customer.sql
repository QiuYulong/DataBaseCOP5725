--Entity Function: Create Customer
CREATE OR REPLACE FUNCTION CreateCustomer(_userName varchar(50), _password varchar(50),
_fullName varchar(50), _phone varchar(20), _creditBalance float) 
RETURNS integer AS $BODY$
DECLARE
newId integer;
BEGIN
    newId = nextval('customer_id_seq');
    insert into customer VALUES
    (newId, _userName, _password, _fullName, _phone, _creditBalance);
    return newId;
END;
$BODY$ LANGUAGE plpgsql;

--Entity Function: Update Customer
CREATE OR REPLACE FUNCTION UpdateCustomer(_id integer, _userName varchar(50), _password varchar(50),
_fullName varchar(50), _phone varchar(20), _creditBalance float) 
RETURNS void AS $BODY$
DECLARE
BEGIN
    UPDATE customer
    SET username=_username, password=_password, fullname=_fullname, phone=_phone,creditbalance=_creditbalance
    WHERE id = _id;
    return;
END;
$BODY$ LANGUAGE plpgsql;

--Entity Function: Delete Customer
CREATE OR REPLACE FUNCTION DeleteCustomer(_id integer)
RETURNS void AS $BODY$
DECLARE
BEGIN
    DELETE FROM customer
    WHERE id = _id;
    return;
END;
$BODY$ LANGUAGE plpgsql;

--Retrieve Function
CREATE OR REPLACE FUNCTION RetrieveCustomerById(_id integer)
RETURNS SETOF customer AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM customer
    WHERE id = _id;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

--Retrieve Function:
CREATE OR REPLACE FUNCTION RetrieveCustomerAll()
RETURNS SETOF customer AS $BODY$
DECLARE
BEGIN
    RETURN QUERY
    SELECT * FROM customer;
    RETURN;
END;
$BODY$ LANGUAGE plpgsql;

/*
SELECT * from Customer;
SELECT CreateCustomer('test1@gmail.com','password1','test admin','7869253159','9999');
SELECT UpdateCustomer(6,'test2@gmail.com','123456','test admin2','7869254435',999);
SELECT DeleteCustomer(6);
SELECT * FROM RetrieveCustomers(5);
SELECT * FROM RetrieveCustomersAll();

DROP FUNCTION CreateCustomer(_userName varchar(50), _password varchar(50),_fullName varchar(50), _phone varchar(20), _creditBalance float);
DROP FUNCTION UpdateCustomer(_id integer, _userName varchar(50), _password varchar(50),_fullName varchar(50), _phone varchar(20), _creditBalance float);
DROP FUNCTION DeleteCustomer(_id integer);
DROP FUNCTION RetrieveCustomerById(_id integer);
DROP FUNCTION RetrieveCustomerAll();
*/