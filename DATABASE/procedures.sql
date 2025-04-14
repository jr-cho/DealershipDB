-- Enforce Salesperson Role
DELIMITER //
CREATE TRIGGER validate_salesperson_role
BEFORE INSERT ON SALESPERSON
FOR EACH ROW
BEGIN
  DECLARE role VARCHAR(25);
  SELECT EMP_ROLE INTO role FROM EMPLOYEE WHERE EMP_ID = NEW.EMP_ID;
  IF role <> 'Salesperson' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Only employees with role Salesperson can be added to SALESPERSON';
  END IF;
END;
//
DELIMITER ;

-- Validate Sale Price
DELIMITER //
CREATE TRIGGER check_total_price
BEFORE INSERT ON SALE
FOR EACH ROW
BEGIN
  DECLARE vehiclePrice DECIMAL(10,2);
  SELECT PRICE INTO vehiclePrice FROM VEHICLE WHERE VIN = NEW.VEHICLE_ID;
  IF NEW.TOTAL_PRICE < vehiclePrice THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Total price must be equal to or greater than the vehicle price.';
  END IF;
END;
//
DELIMITER ;

-- Stored Procedure: Get Invoice by Customer Name and Date
DELIMITER //
CREATE PROCEDURE GetInvoiceByCustomer(
  IN cust_fname VARCHAR(30),
  IN cust_lname VARCHAR(30),
  IN target_date DATE
)
BEGIN
  SELECT 
    S.SALE_ID,
    C.F_NAME,
    C.L_NAME,
    V.MAKE,
    V.MODEL,
    V.PRICE,
    S.SALE_DATE
  FROM SALE S
  JOIN CUSTOMER C ON S.CUS_ID = C.CUS_ID
  JOIN VEHICLE V ON S.VEHICLE_ID = V.VIN
  WHERE C.F_NAME = cust_fname AND C.L_NAME = cust_lname AND S.SALE_DATE = target_date;
END;
//
DELIMITER ;

