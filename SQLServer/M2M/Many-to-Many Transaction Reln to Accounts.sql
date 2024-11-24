One account can have many Transaction
One transaction can be associated with many Accounts

so we have something like this:
Account

id | name | Transaction_sent (Transaction.id) | Transaction_received (Transaction.id)

Transaction

id | notes | sender (Account.id) | recipient (Account.id)

Simplify the design by having an additional Account_X_Transaction TABLE that 
will store the composite key from Account and Transaction tables and add a
new column of transaction_type (S-Send/R-Receive) in Transaction table.




