-- Query to view order details and their items (Sumera - Core Requirement 3)
SELECT 
    o.OrderID,
    c.FirstName AS CustomerName,
    o.OrderDate,
    o.DeliveryDate,
    o.Status,
    o.PaymentStatus,
    p.ProductName,
    oi.Weight,
    oi.CustomizationCharge,
    (oi.Weight * p.BasePricePerKg + oi.CustomizationCharge) AS TotalPrice
FROM 
    Orders o
JOIN 
    Customers c ON o.CustomerID = c.CustomerID
JOIN 
    OrderItems oi ON o.OrderID = oi.OrderID
JOIN 
    Products p ON oi.ProductID = p.ProductID;

-- Query to view all purchases (Sumera - Core Requirement 3)
SELECT 
    p.PurchaseID,
    prod.ProductName,
    p.PurchaseDate,
    p.QuantityKg AS Quantity,
    p.PricePerKg,
    (p.QuantityKg * p.PricePerKg) AS TotalCost
FROM 
    IngredientPurchases p
JOIN 
    Ingredients i ON p.IngredientID = i.IngredientID
JOIN 
    Products prod ON i.ProductID = prod.ProductID;
    
SELECT * FROM customers;

-- Customers who placed orders for products priced above $10 per kg (Aisha - Core Requirement 5)
SELECT DISTINCT c.FirstName, c.LastName, c.Email
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems od ON o.OrderID = od.OrderID
WHERE od.ProductID IN (
    SELECT ProductID
    FROM Products
    WHERE BasePricePerKg > 10
);

-- Find the most expensive product ordered by each customer (Aisha - Core Requirement 5)
SELECT c.FirstName, c.LastName, p.ProductName, p.BasePricePerKg
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
WHERE p.BasePricePerKg = (
    SELECT MAX(p2.BasePricePerKg)
    FROM Orders o2
    JOIN OrderItems oi2 ON o2.OrderID = oi2.OrderID
    JOIN Products p2 ON oi2.ProductID = p2.ProductID
    WHERE o2.CustomerID = c.CustomerID
);

-- Stored function to calculate total purchase cost (Helena - Core Requirement 4)
DELIMITER //
CREATE FUNCTION GetTotalPurchaseCost(ingredientID INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE totalCost DECIMAL(10,2);

    -- Calculate total purchase cost
    SELECT SUM(QuantityKg * PricePerKg)
    INTO totalCost
    FROM IngredientPurchases
    WHERE IngredientID = ingredientID;

    -- Return the total cost
    RETURN totalCost;
END //
DELIMITER ;

SELECT GetTotalPurchaseCost(1) AS TotalCost;

-- Stored procedure: add a new review (Helena - Advanced Option - 1)
DELIMITER //
CREATE PROCEDURE AddProductReview(
    IN p_CustomerID INT,
    IN p_ProductID INT,
    IN p_Rating INT,
    IN p_Comments VARCHAR(255)
)
BEGIN
    -- Insert the review into the Reviews table
    INSERT INTO Reviews (CustomerID, ProductID, Rating, Comments)
    VALUES (p_CustomerID, p_ProductID, p_Rating, p_Comments);
    
END //
DELIMITER ;

CALL AddProductReview(1, 1, 5, 'Best cake I have ever tasted!');

-- Example query with GROUP BY and HAVING (Aisha - Advanced Option - 5)
SELECT 
    p.ProductName,
    SUM(oi.Weight * p.BasePricePerKg + oi.CustomizationCharge) AS TotalRevenue
FROM 
    OrderItems oi
JOIN 
    Products p ON oi.ProductID = p.ProductID
GROUP BY 
    p.ProductID, p.ProductName
HAVING 
    TotalRevenue > 50
ORDER BY 
    TotalRevenue DESC;
    
   -- Example query with GROUP BY and HAVING (Aisha - Advanced Option - 5) 
    SELECT 
    c.FirstName,
    c.LastName,
    SUM(o.TotalAmount) AS TotalSpent
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID, c.FirstName, c.LastName
HAVING 
    TotalSpent > 15
ORDER BY 
    TotalSpent DESC;

