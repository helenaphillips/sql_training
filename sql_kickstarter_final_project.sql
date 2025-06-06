-- Create the database
CREATE DATABASE Irresistibles;
USE Irresistibles;

-- Table for employees working in the bakery
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Address VARCHAR(255),
    City VARCHAR(50),
    PostalCode VARCHAR(10),
    Position VARCHAR(50) NOT NULL
);

-- Table for customer information
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Address VARCHAR(255),
    City VARCHAR(50),
    PostalCode VARCHAR(10),
    Country VARCHAR(50),
    RegistrationDate DATE DEFAULT (CURRENT_DATE)
);

-- Table for products sold by the bakery
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    BasePricePerKg DECIMAL(10, 2) NOT NULL
);

-- Table for ingredients used in the bakery
CREATE TABLE Ingredients (
    IngredientID INT PRIMARY KEY AUTO_INCREMENT,
    IngredientName VARCHAR(100) NOT NULL,
    ProductID INT NOT NULL, -- Links to Products table
    QuantityUsedKg DECIMAL(5, 2) NOT NULL, -- Quantity used for the product (in kilograms)
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE ProductIngredients (
    ProductIngredientID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    IngredientID INT NOT NULL,
    QuantityRequired DECIMAL(10, 2) NOT NULL CHECK (QuantityRequired > 0), -- Per kg of product
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
    FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID) ON DELETE CASCADE
);

-- Table for purchases made to stock ingredients
CREATE TABLE IngredientPurchases (
    PurchaseID INT PRIMARY KEY AUTO_INCREMENT,
    IngredientID INT NOT NULL,
    PurchaseDate DATE NOT NULL,
    QuantityKg DECIMAL(10, 2) NOT NULL CHECK (QuantityKg > 0),
    PricePerKg DECIMAL(10, 2) NOT NULL CHECK (PricePerKg > 0),
    FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID) ON DELETE CASCADE
);

-- Table for orders made by customers
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    DeliveryDate DATE,
    Status ENUM('Delivered', 'Cancelled') DEFAULT 'Delivered',
    PaymentStatus ENUM('Paid', 'Pending', 'Refunded') DEFAULT 'Pending',
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Table for products in each order, including weight and customization charge
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Weight DECIMAL(5, 2) NOT NULL,
    CustomizationCharge DECIMAL(10, 2) DEFAULT 0.00,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Table for customer reviews
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comments TEXT,
    ReviewDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- Insert data into Employees table
INSERT INTO Employees (FirstName, LastName, Email, Phone, Address, City, PostalCode, Position)
VALUES
    ('Sumera', 'Baker', 'sumera.baker@irresistibles.com', '0123456789', '12 Baker St', 'London', 'E1 7QX', 'Manager'),
    ('Helena', 'Bakerson', 'helena.bakerson@irresistibles.com', '0234567890', '34 Cake Ave', 'London', 'SW1A 1AA', 'Baker'),
    ('Aisha', 'Sweet', 'aisha.sweet@irresistibles.com', '0345678901', '56 Dessert Ln', 'London', 'NW3 4RY', 'Decorator'),
    ('James', 'Clark', 'james.clark@irresistibles.com', '0456789012', '78 Sugar Blvd', 'London', 'SE15 5DS',  'Delivery Driver'),
    ('Sophie', 'Hall', 'sophie.hall@irresistibles.com', '0567890123', '90 Frosting Rd', 'London','W1D 3DL', 'Cashier');

-- Insert data into Customers table
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address, City, PostalCode, Country)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Baker St', 'London', 'NW1 6XE', 'UK'),
    ('Sarah', 'Smith', 'sarah.smith@example.com', '9876543210', '456 Pastry Ave', 'Manchester', 'M1 4BT', 'UK'),
    ('Emily', 'Johnson', 'emily.johnson@example.com', '5555555555', '789 Dessert Ln', 'Birmingham', 'B2 4QA', 'UK'),
    ('Ben', 'Stevens', 'ben.stevens@example.com', '01234432210', '9 Dappers Lane', 'Bristol', 'B1 3TY', 'UK'),
    ('George', 'Green', 'george.green@example.co.uk', '07789012345', '48 Cambridge Way', 'Newcastle', 'NE1 7RU', 'UK');
    
-- Insert data into Products table
INSERT INTO Products (ProductName, Description, BasePricePerKg)
VALUES
    ('Chocolate Cake', 'Rich chocolate cake with a moist texture', 20.00),
    ('Vanilla Cake', 'Classic vanilla sponge cake, light and fluffy', 20.00),
    ('Red Velvet Cake', 'Red velvet cake with cream cheese frosting', 22.00),
    ('Lemon Drizzle Cake', 'Zesty lemon cake with a sweet drizzle', 18.00),
    ('Carrot Cake', 'Spiced carrot cake with cream cheese frosting', 20.00),
    ('Cheesecake', 'Creamy cheesecake with a graham cracker crust', 25.00),
    ('Fruit Cake', 'Classic fruit cake with assorted nuts and dried fruit', 23.00);

-- Insert data into Ingredients
INSERT INTO Ingredients (IngredientName, ProductID, QuantityUsedKg)
VALUES
    ('Chocolate Cake Mix', 1, 1.0),   -- Chocolate Cake (ID 1)
    ('Chocolate Icing', 1, 0.2),
    ('Vanilla Cake Mix', 2, 1.0),     -- Vanilla Cake (ID 2)
    ('Buttercream Icing', 2, 0.2),
    ('Red Velvet Cake Mix', 3, 1.5),  -- Red Velvet Cake (ID 3)
    ('Cream Cheese Icing', 3, 0.3),
    ('Lemon Cake Mix', 4, 1.5),       -- Lemon Cake (ID 4)
    ('Buttercream Icing', 4, 0.2),
    ('Carrot Cake Mix', 5, 1.0),      -- Carrot Cake (ID 5)
    ('Cream Cheese Icing', 5, 0.3),
    ('Cheesecake Mix', 6, 1.0),       -- Cheesecake (ID 6)
    ('Cream Cheese Icing', 6, 0.3),
    ('Dried Fruit', 7, 0.5),          -- Fruit Cake (ID 7)
    ('Fruit Cake Mix', 7, 1.5);
   
-- Insert data into Orders table
INSERT INTO Orders (CustomerID, OrderDate, DeliveryDate, Status, PaymentStatus, TotalAmount)
VALUES
    (1, '2024-11-01', '2024-11-02', 'Delivered', 'Paid', 85.00),
    (2, '2024-11-05', '2024-11-06', 'Delivered', 'Paid', 50.00),
    (3, '2024-11-07', NULL, 'Cancelled', 'Refunded', 0.00),
    (4, '2024-11-10', '2024-11-11', 'Delivered', 'Paid', 100.00),
    (5, '2024-11-15', NULL, 'Delivered', 'Pending', 100.00);

-- Insert data into OrderItems table
INSERT INTO OrderItems (OrderID, ProductID, Weight, CustomizationCharge)
VALUES
    (1, 1, 2.0, 5.00), -- 2kg Chocolate Cake with a $5 customization charge
    (1, 4, 1.5, 0.00), -- 1.5kg Lemon Drizzle Cake
    (2, 2, 1.0, 0.00), -- 1kg Vanilla Cake
    (2, 5, 1.5, 0.00), -- 1.5kg Carrot Cake
    (3, 6, 2.0, 10.00), -- Cancelled order: Cheesecake with customization
    (4, 3, 1.0, 15.00), -- 1kg Red Velvet Cake with decoration
    (4, 7, 2.5, 0.00); -- 2.5kg Fruit Cake

-- Insert data into IngredientPurchases table
INSERT INTO IngredientPurchases (IngredientID, PurchaseDate, QuantityKg, PricePerKg)
VALUES
    (1, '2024-10-25', 10.00, 15.00), -- Chocolate Cake Mix
    (4, '2024-10-26', 8.00, 10.00),  -- Buttercream Icing
    (7, '2024-10-27', 5.00, 12.00),  -- Fruit Cake Mix (replacing 13 with a valid ID)
    (5, '2024-10-28', 6.00, 18.00);  -- Red Velvet Cake Mix
    
-- Insert data into reviews table  
INSERT INTO Reviews (CustomerID, ProductID, Rating, Comments)
VALUES
    (1, 1, 5, 'Absolutely loved this product!'),
    (2, 2, 4, 'Great taste, but a bit pricey.'),
    (4, 4, 5, 'Best cake I have ever had. Highly recommend!');
    
    
-- View table
    SELECT * FROM customers;
    
    
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

-- code to call stored function:
SELECT GetTotalPurchaseCost(1) AS TotalCost;

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

-- Code to call stored procedure
CALL AddProductReview(1, 1, 5, 'Best cake I have ever tasted!');
    
    
-- Create a trigger and demonstrate how it runs (Sumera - Advanced Option 2)

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

-- Trigger check:
-- Add a new item to an order
INSERT INTO OrderItems (OrderID, ProductID, Weight, CustomizationCharge)
VALUES (1, 2, 1.5, 2.50); -- Adding 1.5kg Vanilla Cake with $2.50 customization

-- SELECT OrderID, TotalAmount FROM Orders WHERE OrderID = 1;

SELECT OrderID, TotalAmount FROM Orders WHERE OrderID = 1;


-- Create an event and demonstrate how it runs (Sumera - Advanced Option 3)
-- The event runs once daily (EVERY 1 DAY).
-- It deletes orders where:
-- Status is Cancelled.
-- OrderDate is older than 30 days.

DELIMITER //
CREATE EVENT CleanupOldCanceledOrders
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    DELETE FROM Orders
    WHERE Status = 'Cancelled' AND OrderDate < (CURRENT_DATE - INTERVAL 30 DAY);
END;
//
DELIMITER ;

-- Event check:
-- Insert sample data with a canceled order older than 30 days:

INSERT INTO Orders (CustomerID, OrderDate, DeliveryDate, Status, PaymentStatus, TotalAmount)
VALUES (3, '2024-09-15', NULL, 'Cancelled', 'Refunded', 0.00);

-- Manually trigger the event
CALL CleanupOldCanceledOrders();

-- Create a VIEW that uses at least 3-4 base tables & prepare a query that uses the VIEW (Sumera - Advanced Option 4)
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
    
-- Query that uses the VIEW:
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
    

