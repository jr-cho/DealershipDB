-- Page 12: View Definition and Sample Output for SaleSummary

-- View Definition
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
    S.SALE_DATE
FROM SALE S
JOIN CUSTOMER C ON S.CUS_ID = C.CUS_ID
JOIN SALE_VEHICLE SV ON S.SALE_ID = SV.SALE_ID
JOIN VEHICLE V ON SV.VIN = V.VIN;
