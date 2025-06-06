CREATE VIEW CustomerOrderSummary AS
SELECT 
    c.CustomerID,
    c.FirstName AS CustomerFirstName,
    c.LastName AS CustomerLastName,
    o.OrderID,
    o.OrderDate,
    o.DeliveryDate,
    o.Status AS OrderStatus,
    p.ProductName,
    oi.Weight,
    oi.CustomizationCharge,
    (oi.Weight * p.BasePricePerKg + oi.CustomizationCharge) AS TotalProductPrice,
    SUM(oi.Weight * p.BasePricePerKg + oi.CustomizationCharge) OVER (PARTITION BY o.OrderID) AS OrderTotal
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    OrderItems oi ON o.OrderID = oi.OrderID
JOIN 
    Products p ON oi.ProductID = p.ProductID;
