
-- The trigger will calculate and update the TotalAmount column in the Orders table 
-- when a new record is inserted into the OrderItems table.

DELIMITER //
CREATE TRIGGER UpdateOrderTotal
AFTER INSERT ON OrderItems
FOR EACH ROW
BEGIN
    DECLARE v_ItemTotal DECIMAL(10, 2);
    
    -- Calculate the total cost for the new item
    SET v_ItemTotal = (NEW.Weight * (SELECT BasePricePerKg FROM Products WHERE ProductID = NEW.ProductID)) + NEW.CustomizationCharge;
    
    -- Update the total amount in the Orders table
    UPDATE Orders
    SET TotalAmount = COALESCE(TotalAmount, 0) + v_ItemTotal
    WHERE OrderID = NEW.OrderID;
END;
//
DELIMITER ;

