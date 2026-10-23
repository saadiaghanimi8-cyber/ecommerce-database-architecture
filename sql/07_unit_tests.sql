USE ecommerce_db;


CALL CreateOrderSafe(1, 1, 2);


UPDATE Products SET Price = 6200.00 WHERE ProductID = 1;
SELECT * FROM Price_Audit_Log;


SELECT * FROM View_Product_Sales;
SELECT * FROM View_Customer_Activity;