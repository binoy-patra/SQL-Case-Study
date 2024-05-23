CHALLENGE 4
Finance Analysis (Challenge-4)

INTRODUCTION
I am a Finance Analyst working for 'The Big Bank.
I have been tasked with finding out about our customers and their banking behaviour. 
I am going to examine the accounts they hold and the type of transactions they make to develop greater insight into our customers.


TABLES
Here are the tables you will be using :

--------------------------------------------------------------------------------------------------------------------------
-- Create a schema named Datacoach 
create schema datacoach;
-- Create the Customers table
CREATE TABLE datacoach.Customers (
CustomerID INT PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
City VARCHAR(50) NOT NULL,
State VARCHAR(2) NOT NULL
);
COMMIT;
--------------------------------------------------------------------------------------------------------------------------
-- Populate the Customers table
INSERT INTO datacoach.Customers (CustomerID, FirstName, LastName, City, State)
VALUES (1, 'John', 'Doe', 'New York', 'NY'),
(2, 'Jane', 'Doe', 'New York', 'NY'),
(3, 'Bob', 'Smith', 'San Francisco', 'CA'),
(4, 'Alice', 'Johnson', 'San Francisco', 'CA'),
(5, 'Michael', 'Lee', 'Los Angeles', 'CA'),
(6, 'Jennifer', 'Wang', 'Los Angeles', 'CA');
COMMIT;
--------------------------------------------------------------------------------------------------------------------------
-- Create the Branches table
CREATE TABLE datacoach.Branches (
BranchID INT PRIMARY KEY,
BranchName VARCHAR(50) NOT NULL,
City VARCHAR(50) NOT NULL,
State VARCHAR(2) NOT NULL
);
COMMIT;
--------------------------------------------------------------------------------------------------------------------------
-- Populate the Branches table
INSERT INTO datacoach.Branches (BranchID, BranchName, City, State)
VALUES (1, 'Main', 'New York', 'NY'),
(2, 'Downtown', 'San Francisco', 'CA'),
(3, 'West LA', 'Los Angeles', 'CA'),
(4, 'East LA', 'Los Angeles', 'CA'),
(5, 'Uptown', 'New York', 'NY'),
(6, 'Financial District', 'San Francisco', 'CA'),
(7, 'Midtown', 'New York', 'NY'),
(8, 'South Bay', 'San Francisco', 'CA'),
(9, 'Downtown', 'Los Angeles', 'CA'),
(10, 'Chinatown', 'New York', 'NY'),
(11, 'Marina', 'San Francisco', 'CA'),
(12, 'Beverly Hills', 'Los Angeles', 'CA'),
(13, 'Brooklyn', 'New York', 'NY'),
(14, 'North Beach', 'San Francisco', 'CA'),
(15, 'Pasadena', 'Los Angeles', 'CA');
COMMIT;
--------------------------------------------------------------------------------------------------------------------------
-- Create the Accounts table
CREATE TABLE datacoach.Accounts (
AccountID INT PRIMARY KEY,
CustomerID INT NOT NULL,
BranchID INT NOT NULL,
AccountType VARCHAR(50) NOT NULL,
Balance DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);
COMMIT;
--------------------------------------------------------------------------------------------------------------------------
-- Populate the Accounts table
INSERT INTO datacoach.Accounts (AccountID, CustomerID, BranchID, AccountType, Balance)
VALUES (1, 1, 5, 'Checking', 1000.00),
(2, 1, 5, 'Savings', 5000.00),
(3, 2, 1, 'Checking', 2500.00),
(4, 2, 1, 'Savings', 10000.00),
(5, 3, 2, 'Checking', 7500.00),
(6, 3, 2, 'Savings', 15000.00),
(7, 4, 8, 'Checking', 5000.00),
(8, 4, 8, 'Savings', 20000.00),
(9, 5, 14, 'Checking', 10000.00),
(10, 5, 14, 'Savings', 50000.00),
(11, 6, 2, 'Checking', 5000.00),
(12, 6, 2, 'Savings', 10000.00),
(13, 1, 5, 'Credit Card', -500.00),
(14, 2, 1, 'Credit Card', -1000.00),
(15, 3, 2, 'Credit Card', -2000.00);
COMMIT;
--------------------------------------------------------------------------------------------------------------------------
-- Create the Transactions table
CREATE TABLE datacoach.Transactions (
TransactionID INT PRIMARY KEY,
AccountID INT NOT NULL,
TransactionDate DATE NOT NULL,
Amount DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);
COMMIT;
--------------------------------------------------------------------------------------------------------------------------
-- Populate the Transactions table
INSERT INTO datacoach.Transactions (TransactionID, AccountID, TransactionDate, Amount)
VALUES (1, 1, '2022-01-01', -500.00),
(2, 1, '2022-01-02', -250.00),
(3, 2, '2022-01-03', 1000.00),
(4, 3, '2022-01-04', -1000.00),
(5, 3, '2022-01-05', 500.00),
(6, 4, '2022-01-06', 1000.00),
(7, 4, '2022-01-07', -500.00),
(8, 5, '2022-01-08', -2500.00),
(9, 6, '2022-01-09', 500.00),
(10, 6, '2022-01-10', -1000.00),
(11, 7, '2022-01-11', -500.00),
(12, 7, '2022-01-12', -250.00),
(13, 8, '2022-01-13', 1000.00),
(14, 8, '2022-01-14', -1000.00),
(15, 9, '2022-01-15', 500.00);
COMMIT;

--------------------------------------------------------------------------------------------------------------------------
SELECT * FROM datacoach.customers;
select * from datacoach.branches;
select * from datacoach.accounts;
select * from datacoach.transactions;
--------------------------------------------------------------------------------------------------------------------------
-- 1. What are the names of all the customers who live in New York?
SELECT CustomerID,concat(FirstName,' ',LastName) as CustomerName, City
FROM datacoach.customers 
where city='New York';

-- 2. What is the total number of accounts in the Accounts table?
select count(*) as TotalAccount
from datacoach.accounts;

-- 3. What is the total balance of all checking accounts?
select AccountType, sum(Balance) as TotalBalance
from datacoach.accounts
where AccountType='Checking';

-- 4. What is the total balance of all accounts associated with customers who live in Los Angeles?
select c.City,sum(a.Balance) as TotalBalance
from datacoach.accounts a
join datacoach.customers c on a.CustomerID= c.CustomerID
where c.City= 'Los Angeles';

-- 5. Which branch has the highest average account balance?
select a.BranchID, b.BranchName, round(avg(a.Balance)) as AverageBalance
from datacoach.accounts a 
join datacoach.branches b on a.BranchID=b.BranchID 
group by a.BranchID, b.BranchName 
order by AverageBalance DESC 
limit 1;

-- 6. Which customer has the highest current balance in their accounts?
SELECT  c.CustomerID,concat(FirstName,' ',LastName) as CustomerName, 
max(a.Balance) as HighestCurrentBalance
FROM datacoach.customers c 
join datacoach.accounts a on c.CustomerID= a.CustomerID
group by c.CustomerID,CustomerName
order by HighestCurrentBalance desc
limit 1;


-- 7. Which customer has made the most transactions in the Transactions table?
SELECT C.CustomerID, concat(C.FirstName,' ',C.LastName) as CustomerName,
count(T.TransactionID) as NumberofTranactions
FROM datacoach.transactions T
join datacoach.accounts A on T.AccountID = A.AccountID 
join datacoach.customers C on A.CustomerID= C.CustomerID 
group by C.CustomerID,CustomerName
order by NumberofTranactions desc
limit 1;


-- 8.Which branch has the highest total balance across all of its accounts?
select a.BranchID, b.BranchName, sum(a.Balance) as TotalBalance
from datacoach.accounts a 
join datacoach.branches b on a.BranchID=b.BranchID 
group by a.BranchID, b.BranchName 
order by TotalBalance DESC 
limit 1;

-- 9. Which customer has the highest total balance across all of their accounts, including savings and checking accounts?
select c.CustomerID, concat(c.FirstName,' ',c.LastName) as CustomerName,
sum(a.Balance) as TotalBalance
from datacoach.customers c 
join datacoach.accounts a on c.CustomerID=a.CustomerID 
where a.AccountType in ('Savings','Checking')
group by CustomerID,CustomerName
order by TotalBalance DESC 
limit 1;


-- 10. Which branch has the highest number of transactions in the Transactions table?
select b.BranchID,b.BranchName, b.City,count(t.TransactionID) as NumberofTransactions
from datacoach.branches b
join datacoach.accounts a on b.BranchID=a.BranchID 
join datacoach.transactions t on a.AccountID = t.AccountID
group by b.BranchID,b.BranchName,b.city
order by NumberofTransactions desc
limit 1;