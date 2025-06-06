SELECT 
    CustomerFirstName,
    CustomerLastName,
    OrderID,
    OrderDate,
    DeliveryDate,
    OrderStatus,
    ProductName,
    Weight,
    CustomizationCharge,
    TotalProductPrice,
    OrderTotal
FROM 
    CustomerOrderSummary
ORDER BY 
    OrderDate DESC;
