CREATE DATABASE JOINS_PRACTICE;

USE JOINS_PRACTICE;

-- Create table 1
CREATE TABLE Table1_fruit_basket
(ID INT, Fruit VARCHAR(50));
INSERT INTO Table1_fruit_basket 
(ID, Fruit)
VALUES
(1, 'pear'),
(2, 'apple'),
(3, 'kiwi'),
(4, 'orange'),
(5, 'banana');


-- Create table 2
CREATE TABLE Table2_fruit_basket
(ID INT, Fruit VARCHAR(50));
INSERT INTO Table2_fruit_basket 
(ID, Fruit)
VALUES
(1, 'pear'),
(2, 'apple'),
(3, 'kiwi'),
(6, 'melon'),
(7, 'peach'),
(8, 'plum');


SELECT *
FROM Table1_fruit_basket;
SELECT *
FROM Table2_fruit_basket;

USE joins_practice

SELECT 
t1.ID, t1.fruit, t2.ID, t2.fruit
FROM
table1_fruit_basket t1
INNER JOIN
table2_fruit_basket t2
ON
t1.ID = t2.ID;

SELECT 
t1.ID, t1.fruit, t2.ID, t2.fruit
FROM
table1_fruit_basket t1
LEFT JOIN
table2_fruit_basket t2
ON
t1.ID = t2.ID;

SELECT 
t1.ID, t1.fruit, t2.ID, t2.fruit
FROM
table1_fruit_basket t1
RIGHT JOIN
table2_fruit_basket t2
ON
t1.ID = t2.ID;

SELECT 
t1.ID, t1.fruit, t2.ID, t2.fruit
FROM
table1_fruit_basket t1
CROSS JOIN
table2_fruit_basket t2;





USE JOINS_PRACTICE;

-- Create a Table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(55),
    ManagerID INT
);

-- Insert Sample Data
INSERT INTO Employee
(EmployeeID, Name, ManagerID)
VALUES
(1, 'Mike', 3),
(2, 'David', 3),
(3, 'Roger', NULL),
(4, 'Marry',2),
(5, 'Joseph',2),
(7, 'Ben',2);

-- Check the data
SELECT 
    *
FROM
    Employee;

-- Inner Join
SELECT 
    e1.Name AS EmployeeName, e2.Name AS ManagerName
FROM
    Employee e1
        INNER JOIN
    Employee e2 
		ON 
        e1.ManagerID = e2.EmployeeID;


-- Outer Join
SELECT 
    e1.Name EmployeeName,
    IFNULL(e2.name, 'Top Manager') AS ManagerName
FROM
    Employee e1
        LEFT JOIN
    Employee e2 
		ON 
        e1.ManagerID = e2.EmployeeID;




use joins_practice;

-- USE THE SAME FRUIT TABLES THAT WE PRACTICED WITH FOR JOINS

/* UNION ALL */
SELECT t1.ID AS T1ID, t1.Fruit AS T1Fruit
FROM Table1_fruit_basket t1
UNION ALL
SELECT  t2.ID AS T2ID, t2.Fruit AS T2Fruit
FROM Table2_fruit_basket t2;


/* UNION */
SELECT t1.ID T1ID, t1.Fruit AS T1Fruit
FROM Table1_fruit_basket t1
UNION
SELECT  t2.ID AS T2ID, t2.Fruit AS T2Fruit
FROM Table2_fruit_basket t2;





-- SUBQUERIES

USE customers;

SELECT 
    first_name, last_name
FROM
    customers.customer c
WHERE
    c.customer_id IN (SELECT 
            ph.phone_number_customer_id
        FROM
            customers.phone_number ph
        WHERE
            ph.phone_number = '555-3344');


-- HOMEWORK --
SELECT 
    SNAME, STATUS
FROM
    SUPPLIER
WHERE
    S_ID IN (SELECT 
            S_ID
        FROM
            SUPPLY
        WHERE
            J_ID = 'J2');
            
SELECT 
    JNAME, CITY
FROM
    PROJECT
WHERE
    J_ID IN (SELECT 
            J_ID
        FROM
            SUPPLY
        WHERE
            S_ID IN (SELECT 
                    S_ID
                FROM
                    SUPPLIER
                WHERE
                    CITY = 'LONDON'));
                    
SELECT
    JNAME, CITY
FROM
    PROJECT
WHERE
    J_ID NOT IN (SELECT
            J_ID
        FROM
            SUPPLY
        WHERE
            S_ID IN (SELECT
                    S_ID
                FROM
                    SUPPLIER
                WHERE
                    CITY = 'LONDON'));


SELECT 
    SY.SNAME, P.PNAME, PJ.JNAME
FROM
    SUPPLY SY
        JOIN
    SUPPLIER SUP ON SY.S_ID = SUP.S_ID
        JOIN
    PART P ON P.P_ID = SY.P_ID
        JOIN
    PROJECT PJ ON SY.J_ID = PJ.J_ID
WHERE
    SUP.CITY = P.CITY AND P.CITY = PJ.CITY;