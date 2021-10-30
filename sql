SQL keywords are NOT case sensitive:
select is the same as SELECT
Table is same as TABLE and TaBle
---------------------------------------------------------------------------------------------------

SELECT - extracts data from a database, it return a table.
UPDATE - updates data in a database
DELETE - deletes data from a database
INSERT INTO - inserts new data into a database
CREATE DATABASE - creates a new database
ALTER DATABASE - modifies a database
CREATE TABLE - creates a new table
ALTER TABLE - modifies a table
DROP TABLE - deletes a table
CREATE INDEX - creates an index (search key)
DROP INDEX - deletes an index

---------------------------------------------------------------------------------------------------

SELECT return a result table

(SELECT distinct column1, column2 from tablename) return the unique entries from (SELECT distinct column1, column2 from tablename)

---------------------------------------------------------------------------------------------------

Order by column1, column2    // sbse phle ordering hogi column1 k according, uske baad column 2 k according.
							// if sorting is not possible for particula one then ordering will be take place
							// for other column

By defautl odering is done in ascending order

---------------------------------------------------------------------------------------------------

INSERT into nit(rollNo,name,branch) VALUES(185206,"radhika");   //error, if branch is mentioned then values related to that field mustbbe given
INSERT into nit(rollNo,name) VALUES(185206,"radhika");			// it will work perfectly.

---------------------------------------------------------------------------------------------------

A field with a NULL value is a field with no value.
A NULL value is different from a zero value or a field that contains spaces. A field with a NULL value is one that has been left blank during record creation!

IS NULL and IS NOT NULL

select * from nit where branch is null;

---------------------------------------------------------------------------------------------------

update nit
set rollNo=18526
where name="Sunny";

if we neglect the where clause then it will upadte the column values in all row

---------------------------------------------------------------------------------------------------

DELETE from nit where name="radhika";
if we neglect the where clause then it will delete the all rows.

---------------------------------------------------------------------------------------------------

Limit/top/first

limit is used to return only specifoed rows.
select * from nit limit 3; // only top 3 row will be printed

---------------------------------------------------------------------------------------------------
SELECT COUNT(ProductID)
FROM Products;
SELECT AVG(Price)
FROM Products;
SELECT SUM(Quantity)
FROM OrderDetails;
---------------------------------------------------------------------------------------------------
The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.

There are two wildcards often used in conjunction with the LIKE operator:

 The percent sign (%) represents zero, one, or multiple characters
 The underscore sign (_) represents one, single character

 Finds any values that start with "a"     // "a%"
 Finds any values that end with "a"		  // "%a"
 Finds any values that have "or" in any position	//"%or%"
 Finds any values that have "r" in the second position  //"_r%"
 Finds any values that start with "a" and are at least 2 characters in length  //"a_%"
 Finds any values that start with "a" and are at least 3 characters in length	//"a__%"
 Finds any values that start with "a" and ends with "o"		"a%o"

select min(rollNo) from nit where branch like "%e";
---------------------------------------------------------------------------------------------------
Wildcard Characters in SQL Server
Symbol	Description	Example
%	Represents zero or more characters	   						bl% finds bl, black, blue, and blob
_	Represents a single character	       						h_t finds hot, hat, and hit
[]	Represents any single character within the brackets			h[oa]t finds hot and hat, but not hit
^	Represents any character not in the brackets				h[^oa]t finds hit, but not hot and hat
-	Represents any single character within the specified range	c[a-b]t finds cat and cbt

[],^,- dont work in mysql database
---------------------------------------------------------------------------------------------------
The IN operator allows you to specify multiple values in a WHERE clause.
The IN operator is a shorthand for multiple OR conditions.
SELECT * FROM students WHERE gender in ('M',"F");

The BETWEEN operator selects values within a given range. The values can be numbers, text, or dates.
The BETWEEN operator is inclusive: begin and end values are included.
SELECT * FROM students WHERE gender between 'A' and "Z"; 

---------------------------------------------------------------------------------------------------
SQL aliases are used to give a table, or a column in a table, a temporary name.
Aliases are often used to make column names more readable.
An alias only exists for the duration of that query.
An alias is created with the AS keyword.

 Note: It requires double quotation marks or square brackets if the alias name contains spaces:
 as [Contact Person]

SELECT CustomerName, CONCAT(Address,', ',PostalCode,', ',City,', ',Country) AS Address      // it combine address,postal code,city and country
FROM Customers;

select a.id,s.name,a.address from address as a,students as s where a.id=s.id;


---------------------------------------------------------------------------------------------------
The UNION operator is used to combine the result-set of two or more SELECT statements.

Every SELECT statement within UNION must have the same number of columns
The columns must also have similar data types
The columns in every SELECT statement must also be in the same order

SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;

The UNION operator selects only distinct values by default. To allow duplicate values, use UNION ALL:
The column names in the result-set are usually equal to the column names in the first SELECT statement.

---------------------------------------------------------------------------------------------------
We can harcode the particular column in result set as:
SELECT "Tyagi" as cast, fullName from name;
---------------------------------------------------------------------------------------------------
The GROUP BY statement groups rows that have the same values into summary rows, like "find the number of customers in each country".
The GROUP BY statement is often used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()) to group the result-set by one or more columns.

SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country;

---------------------------------------------------------------------------------------------------
select D.name as Department,e.name as Employee,e.salary as Salary from Department as D inner join Employee as e on e.departmentId=D.id where (e.departmentId,e.salary) in (select departmentId,max(salary) from Employee group by departmentId);

select name, gender from students group by gender;      // this will print radhika F,sumit M, last name of each gender

select count(name), gender from students group by gender;   //this will print 3 F,7 M,

---------------------------------------------------------------------------------------------------
having clause is added to sql because where clause can not be used with aggregate funct;
select count(name),gender from students group by gender having count(name)>4; 
---------------------------------------------------------------------------------------------------
The EXISTS operator returns TRUE if the subquery returns one or more records.

//Below statement will return the supplier name if the price is grater than 20
SELECT SupplierName
FROM Suppliers
WHERE EXISTS (SELECT ProductName FROM Products WHERE Products.SupplierID = Suppliers.supplierID AND Price < 20);

---------------------------------------------------------------------------------------------------
ANY and ALL- are used to compare values of single column with multiple values

select ProductName from Products
where ProductID= ANY
(SELECT ProductID from OrderDetails where quantity>99); 
---------------------------------------------------------------------------------------------------
The SELECT INTO statement copies data from one table into a new table.

select ProductName into NewTable in 'NewDatabse.mbd' from Oldtable where price>20;
Tip: SELECT INTO can also be used to create a new, empty table using the schema of another. Just add a WHERE clause that causes the query to return no data:

---------------------------------------------------------------------------------------------------
The INSERT INTO SELECT statement copies data from one table and inserts it into another table.

The INSERT INTO SELECT statement requires that the data types in source and target tables matches.

Note: The existing records in the target table are unaffected.

INSERT INTO table2
SELECT * FROM table1
WHERE condition;
---------------------------------------------------------------------------------------------------
The CASE statement goes through conditions and returns a value when the first condition is met (like an if-then-else statement). So, once a condition is true, it will stop reading and return the result. If no conditions are true, it returns the value in the ELSE clause.

If there is no ELSE part and no conditions are true, it returns NULL.
The following SQL goes through conditions and returns a value when the first condition is met:

Example
SELECT OrderID, Quantity,
CASE
    WHEN Quantity > 30 THEN 'The quantity is greater than 30'
    WHEN Quantity = 30 THEN 'The quantity is 30'
    ELSE 'The quantity is under 30'
END AS QuantityText
FROM OrderDetails;

The following SQL will order the customers by City. However, if City is NULL, then order by Country:

Example
SELECT CustomerName, City, Country
FROM Customers
ORDER BY
(CASE
    WHEN City IS NULL THEN Country
    ELSE City
END);
---------------------------------------------------------------------------------------------------
ifNULL(column, value)- if column value is null, then ifNULL will return the value(2nd arguement)
---------------------------------------------------------------------------------------------------
What is a Stored Procedure?
A stored procedure is a prepared SQL code that you can save, so the code can be reused over and over again.

So if you have an SQL query that you write over and over again, save it as a stored procedure, and then just call it to execute it.

You can also pass parameters to a stored procedure, so that the stored procedure can act based on the parameter value(s) that is passed.

Stored Procedure Syntax
CREATE PROCEDURE procedure_name
AS
sql_statement
GO;
Execute a Stored Procedure
EXEC procedure_name;



Stored Procedure With One Parameter
The following SQL statement creates a stored procedure that selects Customers from a particular City from the "Customers" table:

Example
CREATE PROCEDURE SelectAllCustomers @City nvarchar(30)
AS
SELECT * FROM Customers WHERE City = @City
GO;
Examples---------------------------------------------------------------------------------------------------

Write an SQL query to find employees who have the highest salary in each of the departments.(https://leetcode.com/problems/department-highest-salary/)

select D.name as Department,e.name as Employee,e.salary as Salary from Department as D inner join Employee as e on e.departmentId=D.id where (e.departmentId,e.salary) in (select departmentId,max(salary) from Employee group by departmentId);
---------------------------------------------------------------------------------------------------
Write an SQL query to find all numbers that appear at least three times consecutively. (https://leetcode.com/problems/consecutive-numbers/)

select distinct num as ConsecutiveNums from logs as l where exists (select num from logs where id=l.id AND num=l.num ) and exists (select num from logs where id=l.id-1 AND num=l.num ) and exists (select num from logs where id=l.id-2 AND num=l.num );
