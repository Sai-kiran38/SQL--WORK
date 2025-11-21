DROP DATABASE IF EXISTS company_db;
CREATE DATABASE company_db;
USE company_db;

CREATE TABLE test_table (
  id INT,
  name VARCHAR(100)
);

INSERT INTO test_table (id, name) VALUES
(10, 'Rohit'),
(11, 'Megha'),
(12, 'Tarun'),
(13, 'Nidhi');

SELECT * FROM test_table;

#Alter table 
ALTER TABLE company_db.test_table
ADD Email varchar(255);

# INSERTING NEW COLUMN AND ITS VALUES
INSERT INTO test_table (id, name, Email)
VALUES (20, 'Harsha', 'harsha@example.com'),
(21, 'kiran', 'kiran@example.com');
SELECT * FROM test_table;

# MAKING 'ID' AS PRIMARY KEY
ALTER TABLE test_table
ADD PRIMARY KEY (id);

# UPDATE TABLE 
UPDATE test_table
SET Email = 'rohit@gmail.com'
WHERE id = 10;
SELECT * FROM test_table;

-- 2) NOT NULL and UNIQUE constraints demo

DROP TABLE IF EXISTS company_db.Person_Master;

CREATE TABLE company_db.Person_Master (
    PersonID   INT NOT NULL UNIQUE,
    LastName   VARCHAR(255) NOT NULL,
    FirstName  VARCHAR(255),
    Age        INT
);

SELECT * FROM company_db.Person_Master;

-- Valid rows
INSERT INTO company_db.Person_Master (PersonID, LastName, FirstName, Age)
VALUES (1, 'Sharma', 'Ankit', 29);

INSERT INTO company_db.Person_Master (PersonID, LastName, FirstName, Age)
VALUES (2, 'Reddy', NULL, NULL);  -- NULL allowed for FirstName and Age

-- The next two are EXAMPLES of failure; keep commented unless you want to see errors

-- -- Will FAIL (duplicate PersonID = 1)
-- INSERT INTO company_db.Person_Master (PersonID, LastName, FirstName, Age)
-- VALUES (1, 'Khan', 'Aamir', 40);

-- -- Will FAIL (LastName is NOT NULL)
-- INSERT INTO company_db.Person_Master (PersonID, LastName, FirstName, Age)
-- VALUES (3, NULL, 'Saanvi', 25);
------------------------------------------------------------
-- 3) PRIMARY KEY

ALTER TABLE company_db.Person_Master
ADD PRIMARY KEY (PersonID);

-- Check constraints
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'company_db'
  AND TABLE_NAME = 'Person_Master';

-- Drop PK and add it back with a custom name (to show constraint naming)
ALTER TABLE company_db.Person_Master
DROP PRIMARY KEY;

ALTER TABLE company_db.Person_Master
ADD CONSTRAINT PK_PersonMaster PRIMARY KEY (PersonID);
------------------------------------------------------------
-- 4) FOREIGN KEY demo: Orders referencing Person_Master

DROP TABLE IF EXISTS company_db.Person_Orders;

CREATE TABLE company_db.Person_Orders (
    OrderID    INT PRIMARY KEY,
    OrderDate  DATE,
    PersonID   INT,
    CONSTRAINT FK_PersonOrders_Person
      FOREIGN KEY (PersonID) REFERENCES Person_Master(PersonID)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

-- Valid order (PersonID exists)
INSERT INTO company_db.Person_Orders (OrderID, OrderDate, PersonID)
VALUES (5001, '2024-06-10', 1);

SELECT * FROM company_db.Person_Orders;
SELECT * FROM company_db.Person_Master;

-- Show parent and child
SELECT * FROM company_db.Person_Master; -- parent
SELECT * FROM company_db.Person_Orders; -- child

-- Demonstrate ON UPDATE CASCADE:
-- Change PersonID = 1 to 10 in the parent, child should follow
UPDATE company_db.Person_Master
SET PersonID = 10
WHERE PersonID = 1;

SELECT * FROM company_db.Person_Master;  -- PersonID now 10
SELECT * FROM company_db.Person_Orders;  -- PersonID also updated to 10
------------------------------------------------------------
-- 5) CHECK and DEFAULT constraints on employee table

DROP TABLE IF EXISTS company_db.Employee_Details;

CREATE TABLE company_db.Employee_Details (
    EmpID      INT NOT NULL,
    LastName   VARCHAR(255) NOT NULL,
    FirstName  VARCHAR(255),
    Age        INT CHECK (Age >= 18),
    City       VARCHAR(255) DEFAULT 'New York'
);

SELECT * FROM company_db.Employee_Details;

-- Valid insert
INSERT INTO company_db.Employee_Details (EmpID, LastName, FirstName, Age, City)
VALUES (101, 'Patel', 'Neha', 25, 'Dallas');

-- Uses DEFAULT City ('New York')
INSERT INTO company_db.Employee_Details (EmpID, LastName, FirstName, Age)
VALUES (102, 'Singh', 'Kabir', 30);


