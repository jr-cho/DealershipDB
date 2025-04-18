-- Page 9: Stored Procedure to generate an invoice by inserting a sale
-- Procedure: Generate a complete invoice including financing
DELIMITER //
CREATE PROCEDURE GenerateInvoice(
  IN p_cus_id INT,
  IN p_salesperson_id INT,
  IN p_vehicle_vin VARCHAR(17),
  IN p_sale_date DATE,
  IN p_price DECIMAL(10,2),
  IN p_finance_provider VARCHAR(50),
  IN p_term_months INT,
  IN p_interest_rate DECIMAL(4,2)
)
BEGIN
  DECLARE new_sale_id INT;

  -- Insert into SALE
  INSERT INTO SALE (CUS_ID, SALESPERSON_ID, SALE_DATE, TOTAL_PRICE)
  VALUES (p_cus_id, p_salesperson_id, p_sale_date, p_price);

  SET new_sale_id = LAST_INSERT_ID();

  -- Link to SALE_VEHICLE
  INSERT INTO SALE_VEHICLE (SALE_ID, VIN)
  VALUES (new_sale_id, p_vehicle_vin);

  -- Insert into FINANCE
  INSERT INTO FINANCE (SALE_ID, PROVIDER, TERM_MONTHS, INTEREST_RATE)
  VALUES (new_sale_id, p_finance_provider, p_term_months, p_interest_rate);
END;
//
DELIMITER ;

-- Sample call to test the procedure
CALL GenerateInvoice(
  1,                        -- Customer ID
  1,                        -- Salesperson ID
  '3FAHP0HA6AR123456',      -- Vehicle VIN
  '2025-01-10',             -- Sale date
  27000.00,                 -- Total price
  'Wells Fargo',            -- Finance provider
  60,                       -- Term (months)
  4.5                       -- Interest rate
);

