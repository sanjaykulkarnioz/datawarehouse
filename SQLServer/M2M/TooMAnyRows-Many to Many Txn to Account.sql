/* 
I have an account table and transaction table with many to many relationships.
The account table has columns like account_id,account_name,account_type. 
The transaction table has columns like txn_id,transaction_type,amount. 
I am creating a join between these two tables with cross join table 
with columns like account_id,txn_id,txn_timestamp. 
I would like to create test data with 10 rows for each of these three table. 
Also a SQL query to list all the transactions associated with each account. 
Can you please help with creating the test data and the query in 
SQL Server format?
*/

-- Create the account table
CREATE TABLE account (
    account_id INT PRIMARY KEY,
    account_name NVARCHAR(255),
    account_type NVARCHAR(255)
);

-- Insert 10 rows into the account table with random data
INSERT INTO account (account_id, account_name, account_type)
SELECT
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),  -- account_id
    'Account ' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(10)),  -- account_name
    'Type ' + CAST((RAND() * 100) AS NVARCHAR(10))  -- account_type (random integer)
FROM sys.all_objects;

-- Create the transaction table
CREATE TABLE transaction_tbl (
    txn_id INT PRIMARY KEY,
    transaction_type NVARCHAR(255),
    amount DECIMAL(10, 2)  -- Assuming transactions have a decimal amount
);

-- Insert 10 rows into the transaction table with random data
INSERT INTO transaction_tbl (txn_id, transaction_type, amount)
SELECT
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),  -- txn_id
    'Transaction ' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(10)),  -- transaction_type
    CAST((RAND() * 1000) AS DECIMAL(10, 2))  -- amount (random decimal)
FROM sys.all_objects;

-- Create the cross join table
CREATE TABLE account_transaction (
    account_id INT,
    txn_id INT,
    txn_timestamp DATETIME DEFAULT GETDATE()
);

-- Insert 10 rows into the cross join table with random account_id and txn_id
INSERT INTO account_transaction (account_id, txn_id)
SELECT
    CAST((RAND() * 10) + 1 AS INT),  -- Random account_id between 1 and 10
    CAST((RAND() * 10) + 1 AS INT)   -- Random txn_id between 1 and 10
FROM sys.all_objects;


--here's the SQL query to list all the transactions associated with each account:

SELECT
    a.account_id,
    a.account_name,
    t.txn_id,
    t.transaction_type,
    t.amount,
    at.txn_timestamp
FROM
    account a
JOIN
    account_transaction at ON a.account_id = at.account_id
JOIN
    transaction_tbl t ON at.txn_id = t.txn_id
ORDER BY
    a.account_id,
    t.txn_id;

