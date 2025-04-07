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
