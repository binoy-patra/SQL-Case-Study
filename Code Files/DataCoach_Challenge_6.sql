/*
CHALLENGE 6
Marketing Analysis

INTRO
You are a Marketing Analyst
The 'Sustainable Clothing Co.' have been running several marketing campaigns and have asked you to provide your insight into whether they have been successful or not. Analyse the following data and answer the questions to form your answer.
TABLES
Here are the tables you will be using: 
*/
-- --------------------------------------------------------------------------------------------------------------
-- Create the table
CREATE TABLE datacoach.sustainable_clothing (
product_id INT PRIMARY KEY,
product_name VARCHAR(100),
category VARCHAR(50),
size VARCHAR(10),
price FLOAT
);
commit;
-- Insert data into the table
INSERT INTO datacoach.sustainable_clothing (product_id, product_name, category, size, price)
VALUES
(1, 'Organic Cotton T-Shirt', 'Tops', 'S', 29.99),
(2, 'Recycled Denim Jeans', 'Bottoms', 'M', 79.99),
(3, 'Hemp Crop Top', 'Tops', 'L', 24.99),
(4, 'Bamboo Lounge Pants', 'Bottoms', 'XS', 49.99),
(5, 'Eco-Friendly Hoodie', 'Outerwear', 'XL', 59.99),
(6, 'Linen Button-Down Shirt', 'Tops', 'M', 39.99),
(7, 'Organic Cotton Dress', 'Dresses', 'S', 69.99),
(8, 'Sustainable Swim Shorts', 'Swimwear', 'L', 34.99),
(9, 'Recycled Polyester Jacket', 'Outerwear', 'XL', 89.99),
(10, 'Bamboo Yoga Leggings', 'Activewear', 'XS', 54.99),
(11, 'Hemp Overalls', 'Bottoms', 'M', 74.99),
(12, 'Organic Cotton Sweater', 'Tops', 'L', 49.99),
(13, 'Cork Sandals', 'Footwear', 'S', 39.99),
(14, 'Recycled Nylon Backpack', 'Accessories', 'One Size', 59.99),
(15, 'Organic Cotton Skirt', 'Bottoms', 'XS', 34.99),
(16, 'Hemp Baseball Cap', 'Accessories', 'One Size', 24.99),
(17, 'Upcycled Denim Jacket', 'Outerwear', 'M', 79.99),
(18, 'Linen Jumpsuit', 'Dresses', 'L', 69.99),
(19, 'Organic Cotton Socks', 'Accessories', 'M', 9.99),
(20, 'Bamboo Bathrobe', 'Loungewear', 'XL', 69.99);
commit;
-- Create the table
CREATE TABLE datacoach.marketing_campaigns (
campaign_id INT PRIMARY KEY,
campaign_name VARCHAR(100),
product_id INT,
start_date DATE,
end_date DATE,
FOREIGN KEY (product_id) REFERENCES sustainable_clothing (product_id)
);
commit;
-- Insert data into the table
INSERT INTO datacoach.marketing_campaigns (campaign_id, campaign_name, product_id, start_date, end_date)
VALUES
(1, 'Summer Sale', 2, '2023-06-01', '2023-06-30'),
(2, 'New Collection Launch', 10, '2023-07-15', '2023-08-15'),
(3, 'Super Save', 7, '2023-08-20', '2023-09-15');
commit;
-- Create the table
CREATE TABLE datacoach.transactions (
transaction_id INT PRIMARY KEY,
product_id INT,
quantity INT,
purchase_date DATE,
FOREIGN KEY (product_id) REFERENCES sustainable_clothing (product_id)
);
commit;
-- Insert data into the table
INSERT INTO datacoach.transactions (transaction_id, product_id, quantity, purchase_date)
VALUES
(1, 2, 2, '2023-06-02'),
(2, 14, 1, '2023-06-02'),
(3, 5, 2, '2023-06-05'),
(4, 2, 1, '2023-06-07'),
(5, 19, 2, '2023-06-10'),
(6, 2, 1, '2023-06-13'),
(7, 16, 1, '2023-06-13'),
(8, 10, 2, '2023-06-15'),
(9, 2, 1, '2023-06-18'),
(10, 4, 1, '2023-06-22'),
(11, 18, 2, '2023-06-26'),
(12, 2, 1, '2023-06-30'),
(13, 13, 1, '2023-06-30'),
(14, 4, 1, '2023-07-04'),
(15, 6, 2, '2023-07-08'),
(16, 15, 1, '2023-07-08'),
(17, 9, 2, '2023-07-12'),
(18, 20, 1, '2023-07-12'),
(19, 11, 1, '2023-07-16'),
(20, 10, 1, '2023-07-20'),
(21, 12, 2, '2023-07-24'),
(22, 5, 1, '2023-07-29'),
(23, 10, 1, '2023-07-29'),
(24, 10, 1, '2023-08-03'),
(25, 19, 2, '2023-08-08'),
(26, 3, 1, '2023-08-14'),
(27, 10, 1, '2023-08-14'),
(28, 16, 2, '2023-08-20'),
(29, 18, 1, '2023-08-27'),
(30, 12, 2, '2023-09-01'),
(31, 13, 1, '2023-09-05'),
(32, 7, 1, '2023-09-05'),
(33, 6, 1, '2023-09-10'),
(34, 15, 2, '2023-09-14'),
(35, 9, 1, '2023-09-14'),
(36, 11, 2, '2023-09-19'),
(37, 17, 1, '2023-09-23'),
(38, 2, 1, '2023-09-28'),
(39, 14, 1, '2023-09-28'),
(40, 5, 2, '2023-09-30'),
(41, 16, 1, '2023-10-01'),
(42, 12, 2, '2023-10-01'),
(43, 1, 1, '2023-10-01'),
(44, 7, 1, '2023-10-02'),
(45, 18, 2, '2023-10-03'),
(46, 12, 1, '2023-10-03'),
(47, 13, 1, '2023-10-04'),
(48, 4, 1, '2023-10-05'),
(49, 12, 2, '2023-10-05'),
(50, 7, 1, '2023-10-06'),
(51, 4, 2, '2023-10-08'),
(52, 8, 2, '2023-10-08'),
(53, 16, 1, '2023-10-09'),
(54, 19, 1, '2023-10-09'),
(55, 1, 1, '2023-10-10'),
(56, 18, 2, '2023-10-10'),
(57, 2, 1, '2023-10-10'),
(58, 15, 2, '2023-10-11'),
(59, 17, 2, '2023-10-13'),
(60, 13, 1, '2023-10-13'),
(61, 10, 2, '2023-10-13'),
(62, 9, 1, '2023-10-13'),
(63, 19, 2, '2023-10-13'),
(64, 20, 1, '2023-10-14');
commit;

-- --------------------------------------------------------------------------------------------------------------
-- 1. How many transactions were completed during each marketing campaign?
SELECT C.campaign_name, COUNT(T.transaction_id) AS Transaction 
FROM datacoach.marketing_campaigns C 
JOIN datacoach.transactions T ON C.product_id=T.product_id
WHERE T.purchase_date BETWEEN C.start_date AND C.end_date
group by C.campaign_name;

-- 2. Which product had the highest sales quantity?
SELECT S.product_name, SUM(T.quantity) AS QuantitySale
FROM datacoach.sustainable_clothing S 
JOIN datacoach.transactions T USING(PRODUCT_ID)
GROUP BY  S.product_name
ORDER BY QuantitySale DESC LIMIT 1;

-- 3. What is the total revenue generated from each marketing campaign?
SELECT C.campaign_name, ROUND(SUM(T.quantity * S.price)) AS Revenue
FROM datacoach.marketing_campaigns C 
JOIN datacoach.transactions T USING(product_id)
JOIN datacoach.sustainable_clothing S USING(product_id)
WHERE T.purchase_date BETWEEN C.start_date AND C.end_date
GROUP BY C.campaign_name;

-- 4. What is the top-selling product category based on the total revenue generated?
SELECT S.category, ROUND(SUM(T.quantity * S.price)) AS Revenue
FROM datacoach.transactions T 
JOIN datacoach.sustainable_clothing S USING(product_id)
GROUP BY  S.category
ORDER BY Revenue DESC 
LIMIT 1;

-- 5. Which products had a higher quantity sold compared to the average quantity sold?
SELECT S.product_id,S.product_name, SUM(T.quantity) AS Quantity
FROM datacoach.sustainable_clothing S 
JOIN datacoach.transactions T USING(product_id) 
GROUP BY S.product_id,S.product_name
HAVING Quantity> (SELECT AVG(A.quantity) FROM datacoach.transactions A);

-- 6. What is the average revenue generated per day during the marketing campaigns?
SELECT  C.campaign_name,T.purchase_date, ROUND(AVG(S.price*T.quantity)) AS Revenue
FROM datacoach.marketing_campaigns C 
JOIN datacoach.transactions T USING(product_id)
JOIN datacoach.sustainable_clothing S USING(product_id)
WHERE T.purchase_date BETWEEN C.start_date AND C.end_date
GROUP BY C.campaign_name,T.purchase_date;

-- 7. What is the percentage contribution of each product to the total revenue?
WITH CTE1  AS (SELECT S.product_id , S.product_name,
ROUND(SUM(S.price*T.quantity),2) AS Revenue_per_Product,
SUM(ROUND(SUM(S.price*T.quantity),1)) OVER() AS TotalRevenue
FROM datacoach.transactions T 
JOIN datacoach.sustainable_clothing S USING(product_id)
GROUP BY S.product_id , S.product_name) 
SELECT CTE1.TotalRevenue,CTE1.product_name, CTE1.Revenue_per_Product,
ROUND(Revenue_per_Product/TotalRevenue*100,2)AS Percentage_Countribution 
FROM CTE1;


-- 8. Compare the average quantity sold during marketing campaigns to outside the marketing campaigns.
SELECT 
CASE WHEN C.campaign_name IS NULL THEN 'Outside Campaign'
ELSE 'During Campaign' END AS MarketingType,
ROUND(AVG(T.quantity),1) AS AvgQuantity
FROM datacoach.transactions T
left JOIN datacoach.marketing_campaigns C USING(PRODUCT_ID)
GROUP BY MarketingType;

-- 9. Compare the revenue generated by products inside the marketing campaigns to outside the campaigns.
SELECT 
CASE WHEN C.campaign_name IS NULL THEN 'Outside Campaign'
ELSE 'During Campaign' END AS MarketingType,
ROUND(SUM(T.quantity * S.PRICE),1) AS Revenue
FROM datacoach.transactions T
left JOIN datacoach.marketing_campaigns C USING(PRODUCT_ID)
JOIN datacoach.sustainable_clothing S USING(PRODUCT_ID)
GROUP BY MarketingType;

-- 10. Rank the products by their average daily quantity sold.
SELECT S.product_name,
ROUND(AVG(T.quantity),2) AS AvgQuantity , 
dense_rank() OVER(ORDER BY AVG(T.quantity) DESC) RN
FROM datacoach.transactions T 
JOIN datacoach.sustainable_clothing S USING(PRODUCT_ID) 
GROUP BY S.product_name ;
