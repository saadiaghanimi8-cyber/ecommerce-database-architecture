USE ecommerce_db;


CREATE OR REPLACE VIEW View_Product_Sales AS
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    COALESCE(SUM(oi.Quantity), 0) AS TotalUnitsSold,
    COALESCE(SUM(oi.Quantity * oi.UnitPrice), 0) AS TotalRevenue
FROM Products p
LEFT JOIN Categories c ON p.CategoryID = c.CategoryID
LEFT JOIN Order_Items oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID, p.ProductName, c.CategoryName;


CREATE OR REPLACE VIEW View_Customer_Activity AS
SELECT 
    u.UserID,
    u.Username,
    u.Email,
    COUNT(o.OrderID) AS TotalOrders,
    COALESCE(SUM(o.TotalAmount), 0) AS TotalSpent
FROM Users u
LEFT JOIN Orders o ON u.UserID = o.UserID
GROUP BY u.UserID, u.Username, u.Email;