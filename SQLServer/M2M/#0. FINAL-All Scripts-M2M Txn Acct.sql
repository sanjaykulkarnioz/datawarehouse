/****** Script for SelectTopNRows command from TRansformed/Dimensional  ******/
SELECT * FROM [DIM_Banking_AcctTxn].[dbo].[dim_account];

SELECT * FROM [DIM_Banking_AcctTxn].[dbo].[dim_transaction];

SELECT * FROM [DIM_Banking_AcctTxn].[dbo].[fact_transaction];

SELECT * FROM [DIM_Banking_AcctTxn].[dbo].[bridge_account_transaction];

--DROP TABLE SCRIPTS:

DROP TABLE [DIM_Banking_AcctTxn].[dbo].[dim_account];

DROP TABLE [DIM_Banking_AcctTxn].[dbo].[dim_transaction];

DROP TABLE [DIM_Banking_AcctTxn].[dbo].[fact_transaction];

DROP TABLE [DIM_Banking_AcctTxn].[dbo].[bridge_account_transaction];


/*
Here's an SQL Server script that creates the dimensional model tables, the fact table, and the corresponding source transaction table with date timestamp columns, and inserts 5 records into each of these tables:
*/

-- Create the dim_account table
CREATE TABLE dim_account (
    account_id INT PRIMARY KEY,
    account_name NVARCHAR(255),
    account_type NVARCHAR(255)
);

-- Insert data into the dim_account table
INSERT INTO dim_account (account_id, account_name, account_type)
VALUES
    (101, 'Account 101', 'Savings'),
    (102, 'Account 102', 'Checking'),
    (103, 'Account 103', 'Checking');

-- Create the dim_transaction table
CREATE TABLE dim_transaction (
    txn_id INT PRIMARY KEY,
    transaction_type NVARCHAR(255),
    amount DECIMAL(10, 2),
    txn_timestamp DATETIME
);

-- Insert data into the dim_transaction table
INSERT INTO dim_transaction (txn_id, transaction_type, amount,txn_timestamp)
VALUES
    (1001, 'Deposit', 1000.00, '2023-09-09 10:00:00.000'),
    (1002, 'Withdrawal', 500.00, '2023-09-09 11:30:00.000'),
    (1003, 'Transfer', 200.00, '2023-09-09 14:15:00.000'),
    (1004, 'Purchase', 50.00, '2023-09-09 14:15:00.000'),
    (1005, 'Deposit', 800.00, '2023-09-09 10:00:00.000');


-- Create the bridge_account_transaction table
CREATE TABLE bridge_account_transaction (
    account_id INT,
    txn_id INT,
    sender_receiver NVARCHAR(50)
);

-- Insert data into the bridge_account_transaction table
INSERT INTO bridge_account_transaction (account_id, txn_id, sender_receiver)
VALUES
    (101, 1001, NULL),
    (102, 1001, NULL),
    (101, 1002, NULL),
    (101, 1003, 'Sender'),
    (103, 1003, 'Receiver');

-- Create the fact_transaction table
CREATE TABLE fact_transaction (
    fact_id INT PRIMARY KEY,
    account_id INT,
    txn_id INT,
    txn_timestamp DATETIME
);

-- Insert data into the fact_transaction table
INSERT INTO fact_transaction (fact_id, account_id, txn_id, txn_timestamp)
VALUES
    (1, 101, 1001, '2023-09-09 10:00:00.000'),
    (2, 102, 1001, '2023-09-09 10:00:00.000'),
    (3, 101, 1002, '2023-09-09 11:30:00.000'),
    (4, 101, 1003, '2023-09-09 14:15:00.000'),
    (5, 103, 1003, '2023-09-09 14:15:00.000');

/*
This script creates all the required tables, including the dimensional model 
tables (`dim_account`, `dim_transaction`, `bridge_account_transaction`, 
and `fact_transaction`), as well as the source transaction table 
(`transaction_tbl`) with corresponding timestamp columns. 
It also inserts 5 sample records into each of these tables for testing purposes.
*/
/*
To query the fact table `fact_transaction` to get all the transactions for one particular account in the example with many-to-many relationships between accounts and transactions, you can use a SQL query like this:
*/

SELECT
    f.fact_id,
    a.account_id,
    a.account_name,
    a.account_type,
    t.txn_id,
    t.transaction_type,
    t.amount,
    f.txn_timestamp,
    bat.sender_receiver
FROM
    fact_transaction f
JOIN
    dim_account a ON f.account_id = a.account_id
JOIN
    dim_transaction t ON f.txn_id = t.txn_id
LEFT JOIN
    bridge_account_transaction bat 
    ON f.account_id = bat.account_id AND f.txn_id = bat.txn_id
WHERE
    a.account_id = 101; -- Replace 101 with the account ID you want to query




/****** Script for SelectTopNRows command from Staging  ******/
SELECT *   FROM [STG_Banking_AcctTxn].[dbo].[account];

SELECT *   FROM [STG_Banking_AcctTxn].[dbo].[account_transaction];

SELECT *   FROM [STG_Banking_AcctTxn].[dbo].[transaction_tbl];

--DROP TABLE SCRIPTS:
DROP TABLE [STG_Banking_AcctTxn].[dbo].[account];

DROP TABLE [STG_Banking_AcctTxn].[dbo].[account_transaction];

DROP TABLE [STG_Banking_AcctTxn].[dbo].[transaction_tbl];


-- To create test data for this scenario where one account (ID 101) 
-- is associated with two transaction IDs (1001 and 1002), 
-- and transaction ID 1001 is associated with two accounts (101 and 102) 
-- with one account being the sender and another the receiver, 
-- you can use the following SQL statements and queries:

-- Create the account table
CREATE TABLE account (
    account_id INT PRIMARY KEY,
    account_name NVARCHAR(255),
    account_type NVARCHAR(255)
);

-- Create the transaction_tbl table
CREATE TABLE transaction_tbl (
    txn_id INT PRIMARY KEY,
    transaction_type NVARCHAR(255),
    amount DECIMAL(10, 2),
    txn_timestamp DATETIME
);


-- Create the cross join table to associate accounts and transactions
CREATE TABLE account_transaction (
    account_id INT,
    txn_id INT,
    sender_receiver NVARCHAR(50)
);


-- Insert data into the account table
INSERT INTO account (account_id, account_name, account_type)
VALUES
    (101, 'Account 101', 'Savings'),
    (102, 'Account 102', 'Checking'),
    (103, 'Account 103', 'Checking');


-- Insert data into the transaction_tbl table
INSERT INTO transaction_tbl (txn_id, transaction_type, amount, txn_timestamp)
VALUES
    (1001, 'Deposit', 1000.00, '2023-09-10 08:15:00.000'),
    (1002, 'Withdrawal', 500.00, '2023-09-10 12:30:00.000'),
    (1003, 'Transfer', 200.00, '2023-09-11 14:45:00.000'),
    (1004, 'Purchase', 50.00, '2023-09-11 16:30:00.000'),
    (1005, 'Deposit', 800.00, '2023-09-12 09:00:00.000');


-- Insert data into the cross join table to associate accounts and transactions
INSERT INTO account_transaction (account_id, txn_id, sender_receiver)
VALUES
    (101, 1001, NULL),
    (102, 1001, NULL),
    (101, 1002, NULL),
    (101, 1003, 'Sender'),
    (103, 1003, 'Receiver');


/*
In the account_transaction table, we use 'Sender' to indicate 
that account 101 is the sender in transaction 1001, 
'Receiver' to indicate that account 102 is the receiver in transaction 1001, 
and we use NULL to indicate that transaction 1002 is not associated 
with any specific sender or receiver.

Now, you can query the data to access the information you need:
*/

-- List all accounts associated with transaction 1001

SELECT
    a.account_id AS account_id,
    a.account_name AS account_name,
    t.txn_id AS transaction_id,
    t.transaction_type AS transaction_type,
    t.amount AS transaction_amount,
    at.sender_receiver AS sender_receiver
FROM
    account a
JOIN
    account_transaction at ON a.account_id = at.account_id
JOIN
    transaction_tbl t ON at.txn_id = t.txn_id
WHERE
    t.txn_id = 1001;

-- List all transactions associated with account 101
SELECT
    a.account_id AS account_id,
    a.account_name AS account_name,
    t.txn_id AS transaction_id,
    t.transaction_type AS transaction_type,
    t.amount AS transaction_amount,
    at.sender_receiver AS sender_receiver
FROM
    account a
JOIN
    account_transaction at ON a.account_id = at.account_id
JOIN
    transaction_tbl t ON at.txn_id = t.txn_id
WHERE
    a.account_id = 101;


