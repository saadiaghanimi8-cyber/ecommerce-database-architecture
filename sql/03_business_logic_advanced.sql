USE ecommerce_db;


CREATE TABLE IF NOT EXISTS Price_Audit_Log (
    AuditID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    OldPrice DECIMAL(10,2),
    NewPrice DECIMAL(10,2),
    ChangedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

DELIMITER //
CREATE TRIGGER BeforeProductPriceUpdate
BEFORE UPDATE ON Products
FOR EACH ROW
BEGIN
    IF OLD.Price <> NEW.Price THEN
        INSERT INTO Price_Audit_Log (ProductID, OldPrice, NewPrice)
        VALUES (OLD.ProductID, OLD.Price, NEW.Price);
    END IF;
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER AfterOrderItemInsert
AFTER INSERT ON Order_Items
FOR EACH ROW
BEGIN
    UPDATE Products 
    SET StockQuantity = StockQuantity - NEW.Quantity
    WHERE ProductID = NEW.ProductID;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE CreateOrderSafe(
    IN p_UserID INT,
    IN p_ProductID INT,
    IN p_Quantity INT
)
BEGIN
    DECLARE v_UnitPrice DECIMAL(10, 2);
    DECLARE v_TotalAmount DECIMAL(10, 2);
    DECLARE v_OrderID INT;
    DECLARE v_Stock INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Transaction Failed: Order processing error.';
    END;

    START TRANSACTION;

    SELECT Price, StockQuantity INTO v_UnitPrice, v_Stock 
    FROM Products 
    WHERE ProductID = p_ProductID FOR UPDATE;

    IF v_Stock < p_Quantity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Not enough stock available.';
    END IF;

    SET v_TotalAmount = v_UnitPrice * p_Quantity;

    INSERT INTO Orders (UserID, TotalAmount, OrderStatus) 
    VALUES (p_UserID, v_TotalAmount, 'Completed');

    SET v_OrderID = LAST_INSERT_ID();

    INSERT INTO Order_Items (OrderID, ProductID, Quantity, UnitPrice) 
    VALUES (v_OrderID, p_ProductID, p_Quantity, v_UnitPrice);

    COMMIT;
END //
DELIMITER ;