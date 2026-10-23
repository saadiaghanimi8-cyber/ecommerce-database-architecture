USE ecommerce_db;


INSERT INTO Users (Username, Email) VALUES 
('amine_dev', 'amine@example.com'),
('sara_tech', 'sara@example.com'),
('karim_data', 'karim@example.com');


INSERT INTO Categories (CategoryName) VALUES 
('Electronics'),
('Clothing'),
('Books');


INSERT INTO Products (ProductName, Price, StockQuantity, CategoryID) VALUES 
('Laptop Dell i5', 6500.00, 15, 1),
('Wireless Mouse', 150.00, 50, 1),
('Cotton T-Shirt', 120.00, 100, 2),
('SQL Database Guide', 250.00, 30, 3);