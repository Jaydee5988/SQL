/*
    Name: James Witherington
    DTSC660: Data and Database Managment with SQL
    Assignment 5- PART 1
*/

--------------------------------------------------------------------------------
/*				                 Query 1            		  		          */
--------------------------------------------------------------------------------
SELECT DISTINCT c.cust_ID, a.account_number, l.loan_number
FROM customer c
JOIN depositor dp ON c.cust_ID = dp.cust_ID
JOIN account a ON dp.account_number = a.account_number
JOIN borrower br ON c.cust_ID = br.cust_ID
JOIN loan l ON br.loan_number = l.loan_number;



--------------------------------------------------------------------------------
/*				                  Query 2           		  		          */
--------------------------------------------------------------------------------
SELECT c.cust_ID, c.customer_city, b.branch_city, b.branch_name, a.account_number
FROM customer c
JOIN depositor dp ON c.cust_ID = dp.cust_ID
JOIN account a ON dp.account_number = a.account_number
JOIN branch b ON a.branch_name = b.branch_name
WHERE c.customer_city = b.branch_city;


--------------------------------------------------------------------------------
/*				                  Query 3           		  		          */
--------------------------------------------------------------------------------
SELECT c.cust_ID, c.customer_name
FROM customer c
WHERE EXISTS (
    SELECT 1 FROM borrower br WHERE br.cust_ID = c.cust_ID
)
AND NOT EXISTS (
    SELECT 1 FROM depositor dp WHERE dp.cust_ID = c.cust_ID
);


--------------------------------------------------------------------------------
/*				                  Query 4           		  		          */
--------------------------------------------------------------------------------
SELECT c.cust_ID, c.customer_name
FROM customer c
WHERE (c.customer_street, c.customer_city) IN (
    SELECT c2.customer_street, c2.customer_city
    FROM customer c2
    WHERE c2.cust_ID = '12345'
);


--------------------------------------------------------------------------------
/*				                  Query 5           		  		          */
--------------------------------------------------------------------------------
SELECT DISTINCT b.branch_name
FROM branch b
JOIN account a ON b.branch_name = a.branch_name
JOIN depositor dp ON a.account_number = dp.account_number
JOIN customer c ON dp.cust_ID = c.cust_ID
WHERE c.customer_city = 'Harrison';

--------------------------------------------------------------------------------
/*				                  Query 6           		  		          */
--------------------------------------------------------------------------------
SELECT c.cust_ID, c.customer_name
FROM customer c
WHERE NOT EXISTS (
    -- Select all branches in 'Brooklyn'
    SELECT b.branch_name FROM branch b WHERE b.branch_city = 'Brooklyn'
    EXCEPT
    -- Select branches in 'Brooklyn' where the customer has a deposit account
    SELECT b.branch_name FROM branch b
    JOIN account a ON b.branch_name = a.branch_name
    JOIN depositor dp ON a.account_number = dp.account_number
    WHERE dp.cust_ID = c.cust_ID AND b.branch_city = 'Brooklyn'
);

--------------------------------------------------------------------------------
/*				                  Query 7           		  		          */
--------------------------------------------------------------------------------
SELECT l.loan_number, c.customer_name, b.branch_name
FROM loan l
JOIN borrower br ON l.loan_number = br.loan_number
JOIN customer c ON br.cust_ID = c.cust_ID
JOIN branch b ON l.branch_name = b.branch_name
WHERE b.branch_name = 'Yonkahs Bankahs'
AND CAST(l.amount AS NUMERIC) > (
    SELECT AVG(CAST(l2.amount AS NUMERIC)) FROM loan l2
    JOIN branch b2 ON l2.branch_name = b2.branch_name
    WHERE b2.branch_name = 'Yonkahs Bankahs'
)



  