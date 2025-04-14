-- Page 8: Show inventory of all products by a specific product type (e.g., make)
SELECT VIN, MAKE, MODEL, YEAR, COLOR, PRICE
FROM VEHICLE
WHERE MAKE = 'Toyota';

