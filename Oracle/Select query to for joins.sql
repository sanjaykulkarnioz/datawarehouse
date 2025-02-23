-- Select query to get all related customers and their orders

SELECT 
    c.customer_id,
    c.first_name || c.last_name AS customer_name,
    o.order_id,
    o.order_amount
FROM 
    customer c
RIGHT OUTER JOIN 
    orders o ON c.customer_id = o.customer_id
ORDER BY 
    c.customer_id, o.order_id;


SELECT * FROM CUSTOMER;

    SELECT * FROM ORDERS;