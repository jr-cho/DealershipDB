-- Page 8: Show inventory of all products by a specific product type (e.g., make)
SELECT 
    V.VIN, V.MAKE, V.MODEL, V.YEAR, V.COLOR, V.PRICE, I.QUANTITY
FROM VEHICLE V
JOIN INVENTORY I ON V.VIN = I.VEHICLE_ID
WHERE V.MAKE = 'Toyota';
