/*
In a dimensional model structure, you can represent the many-to-many 
relationship between the `account` and `transaction` tables using 
a fact table and dimension tables. 
The fact table will contain transaction-level data, and the dimension tables 
will contain attributes related to accounts and transactions. 
Additionally, you can use a bridge table (cross join table) to model the 
many-to-many relationship between accounts and transactions.

Here's how you can structure the dimensional model with fact and dimension 
tables:

**Dimension Tables:**

1. `dim_account` table:
   - `account_id` (Primary Key)
   - `account_name`
   - `account_type`

2. `dim_transaction` table:
   - `txn_id` (Primary Key)
   - `transaction_type`
   - `amount`

**Fact Table:**

3. `fact_transaction` table:
   - `fact_id` (Primary Key)
   - `account_id` (Foreign Key referencing `dim_account`)
   - `txn_id` (Foreign Key referencing `dim_transaction`)
   - `txn_timestamp`

**Bridge (Cross Join) Table:**

4. `bridge_account_transaction` table:
   - `account_id` (Foreign Key referencing `dim_account`)
   - `txn_id` (Foreign Key referencing `dim_transaction`)
   - `sender_receiver`

Now, let's create realistic data with three rows and explain how they are related:

**Test Data:**

**Dimension Tables:**

- `dim_account` (Three rows):

| account_id | account_name     | account_type     |
|------------|------------------|------------------|
| 101        | Savings Account  | Personal Savings |
| 102        | Checking Account | Personal Checking|
| 103        | Business Account | Business Checking|

- `dim_transaction` (Three rows):

| txn_id | transaction_type | amount  |
|--------|------------------|---------|
| 201    | Deposit          | 1000.00 |
| 202    | Withdrawal       | 500.00  |
| 203    | Transfer         | 200.00  |

**Bridge Table:**

- `bridge_account_transaction` (Three rows):

| account_id | txn_id | sender_receiver |
|------------|--------|------------------|
| 101        | 201    | NULL             |
| 102        | 201    | NULL             |
| 101        | 202    | NULL             |

In this example:

- The `dim_account` table contains three accounts.
- The `dim_transaction` table contains three transactions.
- The `bridge_account_transaction` table establishes relationships 
between accounts and transactions. 
For the given data, transaction 201 is associated with accounts 101 and 102, 
and there is no sender/receiver distinction (hence, NULL). 
Transaction 202 is associated with account 101, and again, 
there's no sender/receiver distinction.

**Fact Table (fact_transaction):**

You can populate the fact table by joining the dimension tables and bridge table to create transaction-level records. The `txn_timestamp` can be generated based on the actual transaction timestamp or loading timestamp, depending on your requirements.

Now, let's create a query to select data from this dimensional model:
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
    bridge_account_transaction bat ON f.account_id = bat.account_id AND f.txn_id = bat.txn_id;

--This query retrieves data from the fact table and joins it 
--with the dimension tables and the bridge table to get information 
--about accounts, transactions, and whether there's a sender or receiver 
--association. It provides a comprehensive view of the data in a dimensional 
--model structure.

/*
Here's an example with 5 realistic records in the fact_transaction,
 dim_account, dim_transaction, and bridge_account_transaction tables. 
 This example includes scenarios where one account has multiple transactions 
 and one transaction is associated with multiple accounts.

**Dimension Tables:**

- `dim_account` (Three rows):

| account_id | account_name     | account_type     |
|------------|------------------|------------------|
| 101        | Savings Account  | Personal Savings |
| 102        | Checking Account | Personal Checking|
| 103        | Business Account | Business Checking|

- `dim_transaction` (Three rows):

| txn_id | transaction_type | amount  |
|--------|------------------|---------|
| 201    | Deposit          | 1000.00 |
| 202    | Withdrawal       | 500.00  |
| 203    | Transfer         | 200.00  |

**Bridge Table:**

- `bridge_account_transaction` (Five rows):

| account_id | txn_id | sender_receiver |
|------------|--------|------------------|
| 101        | 201    | NULL             |
| 102        | 201    | NULL             |
| 101        | 202    | NULL             |
| 101        | 203    | Sender           |
| 103        | 203    | Receiver         |

**Fact Table (fact_transaction):**

- `fact_transaction` (Five rows):

| fact_id | account_id | txn_id | txn_timestamp           |
|---------|------------|--------|--------------------------|
| 1       | 101        | 201    | 2023-09-09 10:00:00.000 |
| 2       | 102        | 201    | 2023-09-09 10:00:00.000 |
| 3       | 101        | 202    | 2023-09-09 11:30:00.000 |
| 4       | 101        | 203    | 2023-09-09 14:15:00.000 |
| 5       | 103        | 203    | 2023-09-09 14:15:00.000 |

In this data scenario:

- Accounts 101 and 102 are associated with transaction 201, 
indicating that both have some involvement in this transaction, 
but there's no sender/receiver distinction.

- Account 101 is associated with transaction 202, which is a withdrawal.
- Transaction 203 is a transfer involving accounts 101 and 103, 
with account 101 as the sender and account 103 as the receiver.

These records represent a mix of different scenarios involving accounts 
and transactions within the dimensional model structure.

Here's an SQL Server script to create the realistic records 
for the fact_transaction, dim_account, dim_transaction, 
and bridge_account_transaction tables:
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
    (101, 'Savings Account', 'Personal Savings'),
    (102, 'Checking Account', 'Personal Checking'),
    (103, 'Business Account', 'Business Checking');

-- Create the source transaction table
CREATE TABLE source_transaction (
    source_txn_id INT PRIMARY KEY,
    source_transaction_type NVARCHAR(255),
    source_amount DECIMAL(10, 2),
    source_txn_timestamp DATETIME
);

-- Insert data into the source transaction table
INSERT INTO source_transaction (source_txn_id, source_transaction_type, source_amount, source_txn_timestamp)
VALUES
    (1001, 'Deposit', 1000.00, '2023-09-10 08:15:00.000'),
    (1002, 'Withdrawal', 500.00, '2023-09-10 12:30:00.000'),
    (1003, 'Transfer', 200.00, '2023-09-11 14:45:00.000'),
    (1004, 'Purchase', 50.00, '2023-09-11 16:30:00.000'),
    (1005, 'Deposit', 800.00, '2023-09-12 09:00:00.000');


-- Create the bridge_account_transaction table
CREATE TABLE bridge_account_transaction (
    account_id INT,
    txn_id INT,
    sender_receiver NVARCHAR(50)
);

-- Insert data into the bridge_account_transaction table
INSERT INTO bridge_account_transaction (account_id, txn_id, sender_receiver)
VALUES
    (101, 201, NULL),
    (102, 201, NULL),
    (101, 202, NULL),
    (101, 203, 'Sender'),
    (103, 203, 'Receiver');

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
    (1, 101, 201, '2023-09-09 10:00:00.000'),
    (2, 102, 201, '2023-09-09 10:00:00.000'),
    (3, 101, 202, '2023-09-09 11:30:00.000'),
    (4, 101, 203, '2023-09-09 14:15:00.000'),
    (5, 103, 203, '2023-09-09 14:15:00.000');

--This SQL Server script creates the necessary tables (dim_account, 
--dim_transaction, bridge_account_transaction, and fact_transaction) 
--and inserts the realistic records as described in the previous response.

