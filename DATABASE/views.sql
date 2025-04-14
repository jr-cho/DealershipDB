-- View: SaleSummary
-- Shows basic info for each sale including vehicle, customer, and price
CREATE OR REPLACE VIEW SaleSummary AS
SELECT 
    S.SALE_ID,
    C.F_NAME AS CustomerFirstName,
    C.L_NAME AS CustomerLastName,
    V.MAKE,
    V.MODEL,
    V.YEAR,
    V.PRICE,
    S.TOTAL_PRICE,
    S.SALE_DATE,
    S.PAYMENT_METHOD
FROM SALE S
JOIN CUSTOMER C ON S.CUS_ID = C.CUS_ID
JOIN VEHICLE V ON S.VEHICLE_ID = V.VIN;

-- View: VehicleInventoryStatus
-- Lists all vehicles and whether they have been sold
CREATE OR REPLACE VIEW VehicleInventoryStatus AS
SELECT 
    V.VIN,
    V.MAKE,
    V.MODEL,
    V.YEAR,
    V.COLOR,
    V.PRICE,
    CASE 
        WHEN S.VEHICLE_ID IS NOT NULL THEN 'Sold'
        ELSE 'Available'
    END AS Status
FROM VEHICLE V
LEFT JOIN SALE S ON V.VIN = S.VEHICLE_ID;

-- View: InsuranceSummary
-- Combines insurance data with customer and vehicle
CREATE OR REPLACE VIEW InsuranceSummary AS
SELECT 
    I.INS_ID,
    C.F_NAME AS CustomerFirstName,
    C.L_NAME AS CustomerLastName,
    V.MAKE,
    V.MODEL,
    I.PROVIDER,
    I.COVERAGE_DETAILS
FROM INSURANCE I
JOIN SALE S ON I.SALE_ID = S.SALE_ID
JOIN CUSTOMER C ON S.CUS_ID = C.CUS_ID
JOIN VEHICLE V ON S.VEHICLE_ID = V.VIN;


