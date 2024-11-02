--------------------------------------------------------------------------------
/*				                 Create Database         	 		          */
--------------------------------------------------------------------------------

CREATE DATABASE banking;

--------------------------------------------------------------------------------
/*				             Connect to Database        		  	          */
--------------------------------------------------------------------------------

-- **DO NOT DELETE OR ALTER THE CODE BELOW!**
-- **THIS IS NEEDED FOR CODEGRADE TO RUN YOUR ASSIGNMENT**

\connect banking;

--------------------------------------------------------------------------------
/*				                 Banking DDL           		  		          */
--------------------------------------------------------------------------------
-- Branch Table
CREATE TABLE branch (
    branch_name VARCHAR(40) PRIMARY KEY,
    branch_city VARCHAR(40) NOT NULL CHECK (branch_city IN ('Brooklyn', 'Bronx', 'Manhattan', 'Yonkers')),
    assets MONEY NOT NULL
);

-- Customer Table
CREATE TABLE customer (
    cust_ID VARCHAR(40) PRIMARY KEY,
    customer_name VARCHAR(40) NOT NULL,
    customer_street VARCHAR(40) NOT NULL,
    customer_city VARCHAR(40) NOT NULL
);

-- Loan Table
CREATE TABLE loan (
    loan_number VARCHAR(40) PRIMARY KEY,
    branch_name VARCHAR(40) NOT NULL REFERENCES branch(branch_name) ON UPDATE CASCADE ON DELETE CASCADE,
    amount MONEY NOT NULL DEFAULT '0.00'
);

-- Borrower Table
CREATE TABLE borrower (
    cust_ID VARCHAR(40) NOT NULL,
    loan_number VARCHAR(40) NOT NULL,
    PRIMARY KEY (cust_ID, loan_number),
    FOREIGN KEY (cust_ID) REFERENCES customer(cust_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (loan_number) REFERENCES loan(loan_number) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Account Table
CREATE TABLE account (
    account_number VARCHAR(40) PRIMARY KEY,
    branch_name VARCHAR(40) NOT NULL REFERENCES branch(branch_name) ON UPDATE CASCADE ON DELETE CASCADE,
    balance MONEY NOT NULL DEFAULT '0.00'
);

-- Depositor Table
CREATE TABLE depositor (
    cust_ID VARCHAR(40) NOT NULL,
    account_number VARCHAR(40) NOT NULL,
    PRIMARY KEY (cust_ID, account_number),
    FOREIGN KEY (cust_ID) REFERENCES customer(cust_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (account_number) REFERENCES account(account_number) ON UPDATE CASCADE ON DELETE CASCADE
);