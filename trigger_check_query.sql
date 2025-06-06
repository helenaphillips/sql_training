-- Add a new item to an order
INSERT INTO OrderItems (OrderID, ProductID, Weight, CustomizationCharge)
VALUES (1, 2, 1.5, 2.50); -- Adding 1.5kg Vanilla Cake with $2.50 customization

-- SELECT OrderID, TotalAmount FROM Orders WHERE OrderID = 1;

SELECT OrderID, TotalAmount FROM Orders WHERE OrderID = 1;
