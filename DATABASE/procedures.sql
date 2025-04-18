-- Trigger: Ensure employee added to SALESPERSON is actually a salesperson
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

-- Trigger: Prevent duplicate vehicle sales
DELIMITER //
CREATE TRIGGER prevent_duplicate_vehicle_sales
BEFORE INSERT ON SALE_VEHICLE
FOR EACH ROW
BEGIN
  IF EXISTS (
    SELECT 1 FROM SALE_VEHICLE WHERE VIN = NEW.VIN
  ) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'This vehicle has already been sold.';
  END IF;
END;
//
DELIMITER ;

-- Trigger: Update inventory after sale
DELIMITER //
CREATE TRIGGER update_inventory_after_sale
AFTER INSERT ON SALE_VEHICLE
FOR EACH ROW
BEGIN
  UPDATE INVENTORY
  SET QUANTITY = QUANTITY - 1
  WHERE VEHICLE_ID = NEW.VIN;

  IF (SELECT QUANTITY FROM INVENTORY WHERE VEHICLE_ID = NEW.VIN) < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Inventory quantity cannot be negative.';
  END IF;
END;
//
DELIMITER ;

-- Trigger: Check total price against vehicle prices
DELIMITER //
CREATE TRIGGER check_total_price
BEFORE INSERT ON SALE
FOR EACH ROW
BEGIN
  DECLARE total DECIMAL(10,2);
  SELECT SUM(V.PRICE)
  INTO total
  FROM SALE_VEHICLE SV
  JOIN VEHICLE V ON SV.VIN = V.VIN
  WHERE SV.SALE_ID = NEW.SALE_ID;

  IF NEW.TOTAL_PRICE < total THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Total sale price is less than the sum of vehicle prices.';
  END IF;
END;
//
DELIMITER ;

-- Trigger: Validate inventory before adding to sale
DELIMITER //
CREATE TRIGGER validate_inventory_before_sale
BEFORE INSERT ON SALE_VEHICLE
FOR EACH ROW
BEGIN
  DECLARE available INT;
  SELECT QUANTITY INTO available FROM INVENTORY WHERE VEHICLE_ID = NEW.VIN;

  IF available IS NULL OR available <= 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Vehicle is out of stock or not in inventory.';
  END IF;
END;
//
DELIMITER ;

-- Procedure: Get Invoice by Customer and Date
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
    S.SALE_DATE,
    V.VIN,
    V.MAKE,
    V.MODEL,
    V.PRICE,
    S.TOTAL_PRICE
  FROM SALE S
  JOIN CUSTOMER C ON S.CUS_ID = C.CUS_ID
  JOIN SALE_VEHICLE SV ON S.SALE_ID = SV.SALE_ID
  JOIN VEHICLE V ON SV.VIN = V.VIN
  WHERE C.F_NAME = cust_fname AND C.L_NAME = cust_lname AND S.SALE_DATE = target_date;
END;
//
DELIMITER ;

-- Procedure: Insert Sale with Vehicles (extendable)
DELIMITER //
CREATE PROCEDURE InsertSaleWithVehicles(
  IN p_cus_id INT,
  IN p_salesperson_id INT,
  IN p_sale_date DATE,
  IN p_vehicle1 VARCHAR(17),
  IN p_vehicle2 VARCHAR(17)
)
BEGIN
  DECLARE new_sale_id INT;
  DECLARE total_price DECIMAL(10,2);

  INSERT INTO SALE (CUS_ID, SALESPERSON_ID, SALE_DATE, TOTAL_PRICE)
  VALUES (p_cus_id, p_salesperson_id, p_sale_date, 0);

  SET new_sale_id = LAST_INSERT_ID();

  INSERT INTO SALE_VEHICLE (SALE_ID, VIN) VALUES (new_sale_id, p_vehicle1);
  INSERT INTO SALE_VEHICLE (SALE_ID, VIN) VALUES (new_sale_id, p_vehicle2);

  SELECT SUM(V.PRICE) INTO total_price
  FROM VEHICLE V
  JOIN SALE_VEHICLE SV ON V.VIN = SV.VIN
  WHERE SV.SALE_ID = new_sale_id;

  UPDATE SALE SET TOTAL_PRICE = total_price WHERE SALE_ID = new_sale_id;
END;
//
DELIMITER ;

-- Procedure: View Purchase History for a Customer
DELIMITER //
CREATE PROCEDURE GetCustomerPurchaseHistory(IN p_cus_id INT)
BEGIN
  SELECT 
    S.SALE_ID,
    S.SALE_DATE,
    V.VIN,
    V.MAKE,
    V.MODEL,
    V.PRICE
  FROM SALE S
  JOIN SALE_VEHICLE SV ON S.SALE_ID = SV.SALE_ID
  JOIN VEHICLE V ON SV.VIN = V.VIN
  WHERE S.CUS_ID = p_cus_id
  ORDER BY S.SALE_DATE DESC;
END;
//
DELIMITER ;
