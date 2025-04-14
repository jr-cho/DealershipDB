-- Page 14: Subquery with arithmetic and aliasing
SELECT 
    VIN,
    MAKE,
    MODEL,
    PRICE,
    (SELECT AVG(PRICE) FROM VEHICLE) AS AveragePrice,
    PRICE - (SELECT AVG(PRICE) FROM VEHICLE) AS PriceDifference
FROM VEHICLE;

