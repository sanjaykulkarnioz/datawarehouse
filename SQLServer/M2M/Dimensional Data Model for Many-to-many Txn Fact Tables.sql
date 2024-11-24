In a dimensional model structure, you can represent the 
many-to-many relationship between the `account` and `transaction` tables 
using a fact table and dimension tables. 
The fact table will contain transaction-level data, and the dimension tables 
will contain attributes related to accounts and transactions. 
Additionally, you can use a bridge table (cross join table) to model the 
many-to-many relationship between accounts and transactions.

Here's a textual representation of the data model:

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

Now, here's a simplified textual representation of the data model:

```
              +------------------+
              |  dim_account     |
              |------------------|
              | account_id (PK)  |
              | account_name     |
              | account_type     |
              +------------------+
                      |
                      | (Many-to-Many)
                      |
              +------------------+
              |  bridge_account_ |
              |  transaction     |
              |------------------|
              | account_id (FK)  |
              | txn_id (FK)      |
              | sender_receiver  |
              +------------------+
                      |
                      | (Many-to-Many)
                      |
              +------------------+
              |  dim_transaction |
              |------------------|
              | txn_id (PK)      |
              | transaction_type |
              | amount           |
              +------------------+
                      |
                      | (Fact)
                      |
              +------------------+
              |  fact_transaction|
              |------------------|
              | fact_id (PK)     |
              | account_id (FK)  |
              | txn_id (FK)      |
              | txn_timestamp    |
              +------------------+
```
/*
In this data model:

- `dim_account` and `dim_transaction` are dimension tables containing 
attributes related to accounts and transactions, respectively.
- `bridge_account_transaction` serves as a bridge table that establishes 
relationships between accounts and transactions, including the 
sender/receiver distinction.
- `fact_transaction` is the fact table that contains transaction-level data, 
linking accounts and transactions through foreign keys.

This structure allows you to perform analytics and reporting on the 
transactions while maintaining flexibility for querying and aggregating data 
based on various dimensions related to accounts and transactions.

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

/*
In this query:

- We select columns from the fact table `fact_transaction`, 
as well as related attributes from the dimension tables (`dim_account` 
and `dim_transaction`) and the sender/receiver information from the 
`bridge_account_transaction` table.

- We use `JOIN` clauses to join the fact table with the dimension tables 
and the bridge table to bring together information about accounts, 
transactions, and sender/receiver associations.

- We add a `WHERE` clause to filter the results for a specific account. 
Replace `101` with the account ID you want to query.

This query will return all transactions associated with the specified 
account, including sender/receiver information if available due to the 
many-to-many relationships between accounts and transactions.
*/
