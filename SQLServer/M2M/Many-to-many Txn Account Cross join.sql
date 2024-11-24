/*
Certainly! Let's create a more realistic scenario with three rows of data and tell a data story about how they are related.

**Data Story: Account Usage and Transactions**

In this scenario, we have three accounts and their corresponding transactions. The loading of the cross join table is required to establish the relationship between accounts and transactions.

**Account Data:**

- Account 1: 
  - Account ID: 101
  - Account Name: Savings Account
  - Account Type: Personal Savings

- Account 2:
  - Account ID: 102
  - Account Name: Checking Account
  - Account Type: Personal Checking

- Account 3:
  - Account ID: 103
  - Account Name: Business Account
  - Account Type: Business Checking

**Transaction Data:**

- Transaction 1:
  - Transaction ID: 201
  - Transaction Type: Deposit
  - Amount: $1000.00

- Transaction 2:
  - Transaction ID: 202
  - Transaction Type: Withdrawal
  - Amount: $500.00

- Transaction 3:
  - Transaction ID: 203
  - Transaction Type: Transfer
  - Amount: $200.00

**Cross Join Table Data:**

The purpose of the cross join table is to establish the relationships between accounts and transactions. It contains information about which transactions are associated with which accounts and when these associations were made.

- Cross Join Table 1:
  - Account ID: 101
  - Transaction ID: 201
  - Transaction Timestamp: 2023-09-09 10:00:00
  - Explanation: This record in the cross join table indicates that Account 1 (Savings Account) had a deposit transaction (Transaction 1) on September 9, 2023, at 10:00 AM.

- Cross Join Table 2:
  - Account ID: 102
  - Transaction ID: 202
  - Transaction Timestamp: 2023-09-09 11:30:00
  - Explanation: This record in the cross join table indicates that Account 2 (Checking Account) had a withdrawal transaction (Transaction 2) on September 9, 2023, at 11:30 AM.

- Cross Join Table 3:
  - Account ID: 103
  - Transaction ID: 203
  - Transaction Timestamp: 2023-09-09 14:15:00
  - Explanation: This record in the cross join table indicates that Account 3 (Business Account) had a transfer transaction (Transaction 3) on September 9, 2023, at 2:15 PM.

**Data Relationship Explanation:**

- Accounts: We have three different types of accounts - a personal savings account, a personal checking account, and a business checking account. These accounts represent the financial profiles of different customers.

- Transactions: Each transaction represents a financial activity related to an account. We have a deposit, withdrawal, and transfer transactions. These transactions are typical actions that customers perform with their accounts.

- Cross Join Table: This table establishes connections between accounts and transactions. It helps us track which transactions are associated with which accounts and when these associations occurred. This information is valuable for auditing, reporting, and understanding the financial activities of customers.

In summary, the cross join table acts as a bridge between accounts and transactions, allowing us to maintain a record of how different accounts are used for various financial activities. This data story highlights the importance of data relationships in tracking and analyzing financial data.
*/
/****** Script for SelectTopNRows command from Staging  ******/
SELECT *   FROM [STG_Banking_AcctTxn].[dbo].[account];

SELECT *   FROM [STG_Banking_AcctTxn].[dbo].[account_transaction];

SELECT *   FROM [STG_Banking_AcctTxn].[dbo].[transaction_tbl];


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
    (102, 'Account 102', 'Checking');


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
    (101, 1001, 'Sender'),
    (102, 1001, 'Receiver'),
    (101, 1002, NULL);


/*
In the account_transaction table, we use 'Sender' to indicate 
that account 101 is the sender in transaction 1001, 
'Receiver' to indicate that account 102 is the receiver in transaction 1001, 
and we use NULL to indicate that transaction 1002 is not associated 
with any specific sender or receiver.

Now, you can query the data to access the information you need:
*/
T
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

