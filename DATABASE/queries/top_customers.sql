-- Page 13: Frequency distribution of customers who purchased items over $20000
SELECT 
    C.F_NAME,
    C.L_NAME,
    COUNT(S.SALE_ID) AS TotalSales,
    MAX(S.TOTAL_PRICE) AS MaxPurchase,
    AVG(S.TOTAL_PRICE) AS AvgPurchase
FROM CUSTOMER C
JOIN SALE S ON C.CUS_ID = S.CUS_ID
WHERE S.TOTAL_PRICE > 20000
GROUP BY C.CUS_ID
ORDER BY MaxPurchase DESC
LIMIT 3;
