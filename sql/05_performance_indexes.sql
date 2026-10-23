USE ecommerce_db;

CREATE INDEX idx_product_name ON Products(ProductName);
CREATE INDEX idx_product_category ON Products(CategoryID);
CREATE INDEX idx_orders_user ON Orders(UserID);
CREATE INDEX idx_orders_date ON Orders(OrderDate);
CREATE INDEX idx_order_items_order ON Order_Items(OrderID);
CREATE INDEX idx_order_items_product ON Order_Items(ProductID);