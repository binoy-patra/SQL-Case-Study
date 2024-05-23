/*
CHALLENGE 5
Pub Pricing Analysis

INTRODUCTION: 
You are a Pricing Analyst working for a pub chain called 'Pubs "R" Us'
You have been tasked with analysing the drinks prices and sales to gain a greater insight into how the pubs in your chain are performing.

TABLES
Here are the tables you will be using
*/

CREATE TABLE datacoach.pubs (
pub_id INT PRIMARY KEY,
pub_name VARCHAR(50),
city VARCHAR(50),
state VARCHAR(50),
country VARCHAR(50)
);
--------------------
-- Create the 'beverages' table
CREATE TABLE datacoach.beverages (
beverage_id INT PRIMARY KEY,
beverage_name VARCHAR(50),
category VARCHAR(50),
alcohol_content FLOAT,
price_per_unit DECIMAL(8, 2)
);
--------------------
-- Create the 'sales' table
CREATE TABLE datacoach.sales (
sale_id INT PRIMARY KEY,
pub_id INT,
beverage_id INT,
quantity INT,
transaction_date DATE,
FOREIGN KEY (pub_id) REFERENCES pubs(pub_id),
FOREIGN KEY (beverage_id) REFERENCES beverages(beverage_id)
);
--------------------
-- Create the 'ratings' table 
CREATE TABLE datacoach.ratings ( rating_id INT PRIMARY KEY, pub_id INT, customer_name VARCHAR(50), rating FLOAT, review TEXT, FOREIGN KEY (pub_id) REFERENCES pubs(pub_id) );
--------------------
-- Insert sample data into the 'pubs' table
INSERT INTO datacoach.pubs (pub_id, pub_name, city, state, country)
VALUES
(1, 'The Red Lion', 'London', 'England', 'United Kingdom'),
(2, 'The Dubliner', 'Dublin', 'Dublin', 'Ireland'),
(3, 'The Cheers Bar', 'Boston', 'Massachusetts', 'United States'),
(4, 'La Cerveceria', 'Barcelona', 'Catalonia', 'Spain');
--------------------
-- Insert sample data into the 'beverages' table
INSERT INTO datacoach.beverages (beverage_id, beverage_name, category, alcohol_content, price_per_unit)
VALUES
(1, 'Guinness', 'Beer', 4.2, 5.99),
(2, 'Jameson', 'Whiskey', 40.0, 29.99),
(3, 'Mojito', 'Cocktail', 12.0, 8.99),
(4, 'Chardonnay', 'Wine', 13.5, 12.99),
(5, 'IPA', 'Beer', 6.8, 4.99),
(6, 'Tequila', 'Spirit', 38.0, 24.99);
--------------------
INSERT INTO datacoach.sales (sale_id, pub_id, beverage_id, quantity, transaction_date)
VALUES
(1, 1, 1, 10, '2023-05-01'),
(2, 1, 2, 5, '2023-05-01'),
(3, 2, 1, 8, '2023-05-01'),
(4, 3, 3, 12, '2023-05-02'),
(5, 4, 4, 3, '2023-05-02'),
(6, 4, 6, 6, '2023-05-03'),
(7, 2, 3, 6, '2023-05-03'),
(8, 3, 1, 15, '2023-05-03'),
(9, 3, 4, 7, '2023-05-03'),
(10, 4, 1, 10, '2023-05-04'),
(11, 1, 3, 5, '2023-05-06'),
(12, 2, 2, 3, '2023-05-09'),
(13, 2, 5, 9, '2023-05-09'),
(14, 3, 6, 4, '2023-05-09'),
(15, 4, 3, 7, '2023-05-09'),
(16, 4, 4, 2, '2023-05-09'),
(17, 1, 4, 6, '2023-05-11'),
(18, 1, 6, 8, '2023-05-11'),
(19, 2, 1, 12, '2023-05-12'),
(20, 3, 5, 5, '2023-05-13');
--------------------
-- Insert sample data into the 'ratings' table
INSERT INTO datacoach.ratings (rating_id, pub_id, customer_name, rating, review)
VALUES
(1, 1, 'John Smith', 4.5, 'Great pub with a wide selection of beers.'),
(2, 1, 'Emma Johnson', 4.8, 'Excellent service and cozy atmosphere.'),
(3, 2, 'Michael Brown', 4.2, 'Authentic atmosphere and great beers.'),
(4, 3, 'Sophia Davis', 4.6, 'The cocktails were amazing! Will definitely come back.'),
(5, 4, 'Oliver Wilson', 4.9, 'The wine selection here is outstanding.'),
(6, 4, 'Isabella Moore', 4.3, 'Had a great time trying different spirits.'),
(7, 1, 'Sophia Davis', 4.7, 'Loved the pub food! Great ambiance.'),
(8, 2, 'Ethan Johnson', 4.5, 'A good place to hang out with friends.'),
(9, 2, 'Olivia Taylor', 4.1, 'The whiskey tasting experience was fantastic.'),
(10, 3, 'William Miller', 4.4, 'Friendly staff and live music on weekends.');

commit;

-----------------------------------------------------------------------------------------------------------------------

-- 1. How many pubs are located in each country??
SELECT A.country, COUNT(A.pub_id) as NumberofPubs
FROM datacoach.pubs A
GROUP BY A.COUNTRY;

-- 2. What is the total sales amount for each pub, including the beverage price and quantity sold?
SELECT P.pub_name,sum(B.price_per_unit*S.quantity) AS SalesAmount, 
SUM(s.quantity) as Quanytity
FROM datacoach.sales S 
join datacoach.pubs P on S.pub_id=P.pub_id 
JOIN datacoach.beverages B ON S.beverage_id= B.beverage_id 
group by P.pub_name;

-- 3. Which pub has the highest average rating?
SELECT P.pub_id,P.pub_name, 
ROUND((AVG(R.rating)),1) AS AverageRating 
FROM datacoach.pubs P 
JOIN datacoach.ratings R ON P.pub_id=R.pub_id
GROUP BY P.pub_id,P.pub_name
order by AverageRating DESC 
LIMIT 1;

-- 4. What are the top 5 beverages by sales quantity across all pubs?
SELECT B.beverage_id,B.beverage_name,
SUM(S.quantity) AS Quantity
FROM datacoach.sales S 
JOIN datacoach.beverages B ON S.beverage_id=B.beverage_id
group by B.beverage_id,B.beverage_name
ORDER BY quantity DESC
Limit 5;

-- 5. How many sales transactions occurred on each date?
SELECT S.transaction_date, COUNT(S.sale_id) AS Tranaction
FROM datacoach.sales S 
GROUP BY S.transaction_date;

-- 6. Find the name of someone that had cocktails and which pub they had it in.
SELECT P.pub_id,P.pub_name,R.customer_name,B.category
FROM datacoach.ratings R 
JOIN datacoach.pubs P ON R.pub_id=P.pub_id
JOIN datacoach.sales S ON P.pub_id=S.pub_id 
JOIN datacoach.beverages B ON S.beverage_id=B.beverage_id
WHERE B.category='Cocktail'
ORDER BY P.pub_id;

-- 7. What is the average price per unit for each category of beverages, excluding the category 'Spirit'?
SELECT B.category, ROUND((AVG(B.price_per_unit)),1) AS AveragePrice_PerUnit
FROM datacoach.beverages B 
WHERE B.category <>'Spirit'
GROUP BY B.category
ORDER BY B.category;

-- 8. Which pubs have a rating higher than the average rating of all pubs?
SELECT P.pub_id,P.pub_name, ROUND(AVG(R.RATING)) AS AvgRating
FROM datacoach.pubs P 
JOIN datacoach.ratings R ON P.pub_id=R.pub_id
GROUP BY P.pub_id,P.pub_name
HAVING AvgRating> (SELECT AVG(rating)
FROM datacoach.ratings);

-- 9. What is the running total of sales amount for each pub, ordered by the transaction date?
SELECT 
P.pub_id, P.pub_name, S.transaction_date,
SUM(B.price_per_unit * S.quantity) AS SalsesAmount,
SUM(SUM(B.price_per_unit * S.quantity)) Over(Partition By pub_name ORDER BY transaction_date)
AS RunningTotal
FROM datacoach.sales S
JOIN datacoach.pubs P ON S.pub_id=P.pub_id
JOIN datacoach.beverages B ON S.beverage_id=B.beverage_id
GROUP BY P.pub_id, P.pub_name, S.transaction_date
ORDER BY P.pub_id;


-- 10. For each country, what is the average price per unit of beverages in each category, and what is the overall average price per unit of beverages across all categories?
With cte1 as(SELECT P.country, B.category,  ROUND((avg(B.price_per_unit)),2) AS AvgPriceEachCatagory
FROM datacoach.beverages B 
JOIN datacoach.sales S USING(BEVERAGE_ID)
JOIN datacoach.pubs P USING(PUB_ID)
GROUP BY P.country, B.category),
cte2 as (SELECT P.country, ROUND((avg(B.price_per_unit)),2) AS AvgPriceAllCatagory
FROM datacoach.beverages B 
JOIN datacoach.sales S USING(BEVERAGE_ID)
JOIN datacoach.pubs P USING(PUB_ID)
GROUP BY P.country) 
SELECT CTE1.COUNTRY,CTE1.CATEGORY, CTE1.AvgPriceEachCatagory,CTE2.AvgPriceAllCatagory
FROM CTE1 
JOIN CTE2 ON CTE1.COUNTRY= CTE2.COUNTRY;


-- 11. For each pub, what is the percentage contribution of each category of beverages to the total sales amount, and what is the pub's overall sales amount?
With cte1 as(SELECT P.pub_name, B.category,  sum(b.price_per_unit*s.quantity) AS Category_Sales_Amount
FROM datacoach.beverages B 
JOIN datacoach.sales S USING(BEVERAGE_ID)
JOIN datacoach.pubs P USING(PUB_ID)
GROUP BY P.pub_name, B.category),
cte2 as (SELECT P.pub_name, sum(b.price_per_unit*s.quantity) AS Total_Sales_Amount
FROM datacoach.beverages B 
JOIN datacoach.sales S USING(BEVERAGE_ID)
JOIN datacoach.pubs P USING(PUB_ID)
GROUP BY P.pub_name) 
SELECT CTE1.pub_name,CTE2.Total_Sales_Amount, CTE1.CATEGORY, CTE1.Category_Sales_Amount,
Round(((CTE1.Category_Sales_Amount/CTE2.Total_Sales_Amount)*100),2) As Contribution
FROM CTE1 
JOIN CTE2 ON CTE1.pub_name= CTE2.pub_name;

