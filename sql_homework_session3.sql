CREATE DATABASE bakery;

USE bakery;

CREATE TABLE sweet (
id INT NOT NULL,
item_name VARCHAR(50) NOT NULL,
price FLOAT(2)
);

CREATE TABLE savoury (
id INT NOT NULL,
item_name VARCHAR(50) NOT NULL,
price FLOAT(2),
main_ingredient VARCHAR(50)
);
-- Populate the Sweet table

INSERT INTO sweet
(id, item_name, price)
VALUES
(1, 'doughnut', 0.50),
(2, 'croissant', 0.75),
(3, 'pain au chocolat', 0.55),
(4, 'cinnamon twirl', 0.45),
(5, 'cannoli', 0.88),
(6, 'apple tart', 1.12);
-- Populate the Savoury table

INSERT INTO savoury
(id, item_name, price, main_ingredient)
VALUES
(1, 'meat pie', 1.25, 'pork'),
(2, 'sausage roll', 1.00, null),
(3, 'pasty', 2.45, 'beef');

-- Use select * statements to check tables
SELECT * FROM sweet;
SELECT * FROM savoury;

SELECT * FROM savoury;
SELECT item_name
FROM savoury
WHERE main_ingredient = 'pork' OR main_ingredient = 'beef';

SELECT * FROM sweet;
SELECT item_name
FROM sweet
WHERE price <= 0.50;

#session3 homework

USE shop;
SELECT * FROM sales1;
/* Find ALL sales records (and all columns) that took place in the London store, 
   not in December, but sales concluded by Bill or Frank for the amount higher than £50 */
SELECT store, week, day, salesperson, salesamount, month
FROM sales1
WHERE store = 'London' AND month <> 'dec' 
      AND (salesperson = 'Bill' OR salesperson = 'Frank') 
      AND salesamount > 50;

-- Find out how many sales took place each week (in no particular order)
SELECT week, COUNT(*) as count
FROM sales1
GROUP BY week;

-- Find out how many sales took place each week AND present data by week in descending 
SELECT week, COUNT(*) as count
FROM sales1
GROUP BY week
ORDER BY week DESC;

-- and then in ascending order
SELECT week, COUNT(*) as count
FROM sales1
GROUP BY week
ORDER BY week ASC;

-- Find out how many sales were recorded each week on different days of the week
SELECT week, COUNT(DISTINCT day)
FROM sales1
GROUP BY week;

-- We need to change salesperson's name Inga to Annette
UPDATE sales1
SET salesperson = 'Annette'
WHERE salesperson='Inga';

SET SQL_SAFE_UPDATES= 0; -- solves the 1175 error code

-- Find out how many sales did Annette do
SELECT COUNT(salesperson)
FROM sales1
WHERE salesperson = 'Annette';

-- Find the total sales amount by each person by day
SELECT salesperson, day, COUNT(salesamount)
FROM sales1
GROUP BY salesperson, day;

-- How much (sum) each person sold for the given period
SELECT salesperson, day, SUM(salesamount)
FROM sales1
GROUP BY salesperson, day;

/* How much (sum) each person sold for the given period,including the number of sales per person, 
their average, lowest and highest sale amounts */

-- Find the total monetary sales amount achieved by each store

-- Find the number of sales by each person if they did LESS than 3 sales for the past period

-- Find the total amount of sales by month where combined total is less than £100


