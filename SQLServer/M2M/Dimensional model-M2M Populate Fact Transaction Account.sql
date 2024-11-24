/*
The `txn_timestamp` column in the `fact_transaction` table typically derives
 its value from the source transaction table. In practice, the `txn_timestamp`
  would represent the timestamp when the transaction occurred or was recorded
   in the source system. You can populate this column in the fact table by
    extracting the timestamp values from the source transaction table.

Here are 5 example records for the source transaction table along with 
transaction timestamp values:

**Source Transaction Table:**

- `source_transaction` (Five rows):

| source_txn_id | source_transaction_type | source_amount | source_txn_timestamp       |
|---------------|-------------------------|---------------|----------------------------|
| 1001          | Deposit                 | 1000.00       | 2023-09-10 08:15:00.000    |
| 1002          | Withdrawal              | 500.00        | 2023-09-10 12:30:00.000    |
| 1003          | Transfer                | 200.00        | 2023-09-11 14:45:00.000    |
| 1004          | Purchase                | 50.00         | 2023-09-11 16:30:00.000    |
| 1005          | Deposit                 | 800.00        | 2023-09-12 09:00:00.000    |

You can use the values from the `source_txn_timestamp` column in the source 
transaction table to populate the `txn_timestamp` column in the `fact_transaction` table while loading data into the data warehouse or data mart.
*/
/*
Here's an SQL Server script to create a source transaction table with 5 records, 
including date timestamp columns for each transaction:
*/

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


--This script creates a table called `source_transaction` with columns for the transaction ID (`source_txn_id`), transaction type (`source_transaction_type`), transaction amount (`source_amount`), and the transaction timestamp (`source_txn_timestamp`). It then inserts 5 sample records into the table with different transaction types and timestamps.


/*
Here's an example SQL statement to populate the `fact_transaction` table with data from the source transaction table while extracting the transaction timestamp:
*/



INSERT INTO fact_transaction (fact_id, account_id, txn_id, txn_timestamp)
SELECT
    st.source_txn_id AS fact_id,
    a.account_id,
    dt.txn_id,
    st.source_txn_timestamp AS txn_timestamp
FROM
    source_transaction st
JOIN
    dim_account a ON ... -- Join condition to match account
JOIN
    dim_transaction dt ON ... -- Join condition to match transaction
WHERE
    a.account_id = 101; -- Replace with the desired account ID

/*
In this SQL statement, we use a `JOIN` operation to combine data from the source transaction table with the dimension tables (`dim_account` and `dim_transaction`) and extract the timestamp from the source transaction table (`source_txn_timestamp`) to populate the `txn_timestamp` column in the `fact_transaction` table.