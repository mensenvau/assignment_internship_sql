---------------------------------------------------------------------
-- Exercises
---------------------------------------------------------------------

-- 1 
-- Return orders placed in June 2015
-- Tables involved: TSQLV4 database, Sales.Orders table

-- Desired output:
orderid     orderdate  custid      empid
----------- ---------- ----------- -----------
10555       2015-06-02 71          6
10556       2015-06-03 73          2
10557       2015-06-03 44          9
10558       2015-06-04 4           1
10559       2015-06-05 7           6
10560       2015-06-06 25          8
10561       2015-06-06 24          2
10562       2015-06-09 66          1
10563       2015-06-10 67          2
10564       2015-06-10 65          4
...

(30 row(s) affected)

-- 2 
-- Return orders placed on the last day of the month
-- Tables involved: Sales.Orders table

-- Desired output:
orderid     orderdate  custid      empid
----------- ---------- ----------- -----------
10269       2014-07-31 89          5
10317       2014-09-30 48          6
10343       2014-10-31 44          4
10399       2014-12-31 83          8
10432       2015-01-31 75          3
10460       2015-02-28 24          8
10461       2015-02-28 46          1
10490       2015-03-31 35          7
10491       2015-03-31 28          8
10522       2015-04-30 44          4
...

(26 row(s) affected)

-- 3 
-- Return employees with last name containing the letter 'e' twice or more
-- Tables involved: HR.Employees table

-- Desired output:
empid       firstname  lastname
----------- ---------- --------------------
4           Yael       Peled
5           Sven       Mortensen

(2 row(s) affected)

-- 4 
-- Return orders with total value(qty*unitprice) greater than 10000
-- sorted by total value
-- Tables involved: Sales.OrderDetails table

-- Desired output:
orderid     totalvalue
----------- ---------------------
10865       17250.00
11030       16321.90
10981       15810.00
10372       12281.20
10424       11493.20
10817       11490.70
10889       11380.00
10417       11283.20
10897       10835.24
10353       10741.60
10515       10588.50
10479       10495.60
10540       10191.70
10691       10164.80

(14 row(s) affected)

-- 5
-- Write a query against the HR.Employees table that returns employees
-- with a last name that starts with a lower case letter.
-- Remember that the collation of the sample database
-- is case insensitive (Latin1_General_CI_AS).
-- For simplicity, you can assume that only English letters are used
-- in the employee last names.
-- Tables involved: Sales.OrderDetails table

-- Desired output:
empid       lastname
----------- --------------------

(0 row(s) affected)

-- 6
-- Explain the difference between the following two queries

-- Query 1
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
WHERE orderdate < '20160501'
GROUP BY empid;

-- Query 2
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY empid
HAVING MAX(orderdate) < '20160501';

-- 7 
-- Return the three ship countries with the highest average freight for orders placed in 2015
-- Tables involved: Sales.Orders table

-- Desired output:
shipcountry     avgfreight
--------------- ---------------------
Austria         178.3642
Switzerland     117.1775
Sweden          105.16

(3 row(s) affected)

-- 8 
-- Calculate row numbers for orders
-- based on order date ordering (using order id as tiebreaker)
-- for each customer separately
-- Tables involved: Sales.Orders table

-- Desired output:
custid      orderdate  orderid     rownum
----------- ---------- ----------- --------------------
1           2015-08-25 10643       1
1           2015-10-03 10692       2
1           2015-10-13 10702       3
1           2016-01-15 10835       4
1           2016-03-16 10952       5
1           2016-04-09 11011       6
2           2014-09-18 10308       1
2           2015-08-08 10625       2
2           2015-11-28 10759       3
2           2016-03-04 10926       4
...

(830 row(s) affected)

-- 9
-- Figure out and return for each employee the gender based on the title of courtesy
-- Ms., Mrs. - Female, Mr. - Male, Dr. - Unknown
-- Tables involved: HR.Employees table

-- Desired output:
empid       firstname  lastname             titleofcourtesy           gender
----------- ---------- -------------------- ------------------------- -------
1           Sara       Davis                Ms.                       Female
2           Don        Funk                 Dr.                       Unknown
3           Judy       Lew                  Ms.                       Female
4           Yael       Peled                Mrs.                      Female
5           Sven       Mortensen            Mr.                       Male
6           Paul       Suurs                Mr.                       Male
7           Russell    King                 Mr.                       Male
8           Maria      Cameron              Ms.                       Female
9           Patricia   Doyle                Ms.                       Female

(9 row(s) affected)

-- 10
-- Return for each customer the customer ID and region
-- sort the rows in the output by region
-- having NULLs sort last (after non-NULL values)
-- Note that the default in T-SQL is that NULLs sort first
-- Tables involved: Sales.Customers table

-- Desired output:
custid      region
----------- ---------------
55          AK
10          BC
42          BC
45          CA
37          Co. Cork
33          DF
71          ID
38          Isle of Wight
46          Lara
78          MT
...
1           NULL
2           NULL
3           NULL
4           NULL
5           NULL
6           NULL
7           NULL
8           NULL
9           NULL
11          NULL
...

(91 row(s) affected)


-- 11 
-- Write a query that returns all orders placed on the last day of
-- activity that can be found in the Orders table
-- Tables involved: TSQLV4 database, Orders table

--Desired output
orderid     orderdate   custid      empid
----------- ----------- ----------- -----------
11077       2016-05-06  65          1
11076       2016-05-06  9           4
11075       2016-05-06  68          8
11074       2016-05-06  73          7

(4 row(s) affected)

-- 12 
-- Write a query that returns all orders placed
-- by the customer(s) who placed the highest number of orders
-- * Note: there may be more than one customer
--   with the same number of orders
-- Tables involved: TSQLV4 database, Orders table

-- Desired output:
custid      orderid     orderdate  empid
----------- ----------- ---------- -----------
71          10324       2014-10-08 9
71          10393       2014-12-25 1
71          10398       2014-12-30 2
71          10440       2015-02-10 4
71          10452       2015-02-20 8
71          10510       2015-04-18 6
71          10555       2015-06-02 6
71          10603       2015-07-18 8
71          10607       2015-07-22 5
71          10612       2015-07-28 1
71          10627       2015-08-11 8
71          10657       2015-09-04 2
71          10678       2015-09-23 7
71          10700       2015-10-10 3
71          10711       2015-10-21 5
71          10713       2015-10-22 1
71          10714       2015-10-22 5
71          10722       2015-10-29 8
71          10748       2015-11-20 3
71          10757       2015-11-27 6
71          10815       2016-01-05 2
71          10847       2016-01-22 4
71          10882       2016-02-11 4
71          10894       2016-02-18 1
71          10941       2016-03-11 7
71          10983       2016-03-27 2
71          10984       2016-03-30 1
71          11002       2016-04-06 4
71          11030       2016-04-17 7
71          11031       2016-04-17 6
71          11064       2016-05-01 1

(31 row(s) affected)

-- 13
-- Write a query that returns employees
-- who did not place orders on or after May 1st, 2016
-- Tables involved: TSQLV4 database, Employees and Orders tables

-- Desired output:
empid       FirstName  lastname
----------- ---------- --------------------
3           Judy       Lew
5           Sven       Mortensen
6           Paul       Suurs
9           Patricia   Doyle

(4 row(s) affected)

-- 14
-- Write a query that returns
-- countries where there are customers but not employees
-- Tables involved: TSQLV4 database, Customers and Employees tables

-- Desired output:
country
---------------
Argentina
Austria
Belgium
Brazil
Canada
Denmark
Finland
France
Germany
Ireland
Italy
Mexico
Norway
Poland
Portugal
Spain
Sweden
Switzerland
Venezuela

(19 row(s) affected)

-- 15
-- Write a query that returns for each customer
-- all orders placed on the customer's last day of activity
-- Tables involved: TSQLV4 database, Orders table

-- Desired output:
custid      orderid     orderdate   empid
----------- ----------- ----------- -----------
1           11011       2016-04-09  3
2           10926       2016-03-04  4
3           10856       2016-01-28  3
4           11016       2016-04-10  9
5           10924       2016-03-04  3
...
87          11025       2016-04-15  6
88          10935       2016-03-09  4
89          11066       2016-05-01  7
90          11005       2016-04-07  2
91          11044       2016-04-23  4

(90 row(s) affected)

-- 16
-- Write a query that returns customers
-- who placed orders in 2015 but not in 2016
-- Tables involved: TSQLV4 database, Customers and Orders tables

-- Desired output:
custid      companyname
----------- ----------------------------------------
21          Customer KIDPX
23          Customer WVFAF
33          Customer FVXPQ
36          Customer LVJSO
43          Customer UISOJ
51          Customer PVDZC
85          Customer ENQZT

(7 row(s) affected)

-- 17 
-- Write a query that returns customers
-- who ordered product 12
-- Tables involved: TSQLV4 database,
-- Customers, Orders and OrderDetails tables

-- Desired output:
custid      companyname
----------- ----------------------------------------
48          Customer DVFMB
39          Customer GLLAG
71          Customer LCOUJ
65          Customer NYUHS
44          Customer OXFRU
51          Customer PVDZC
86          Customer SNXOJ
20          Customer THHDP
90          Customer XBBVR
46          Customer XPNIK
31          Customer YJCBX
87          Customer ZHYOS

(12 row(s) affected)

-- 18 
-- Write a query that calculates a running total qty
-- for each customer and month using subqueries
-- Tables involved: TSQLV4 database, Sales.CustOrders view

-- Desired output:
custid      ordermonth              qty         runqty
----------- ----------------------- ----------- -----------
1           2015-08-01 00:00:00.000 38          38
1           2015-10-01 00:00:00.000 41          79
1           2016-01-01 00:00:00.000 17          96
1           2016-03-01 00:00:00.000 18          114
1           2016-04-01 00:00:00.000 60          174
2           2014-09-01 00:00:00.000 6           6
2           2015-08-01 00:00:00.000 18          24
2           2015-11-01 00:00:00.000 10          34
2           2016-03-01 00:00:00.000 29          63
3           2014-11-01 00:00:00.000 24          24
3           2015-04-01 00:00:00.000 30          54
3           2015-05-01 00:00:00.000 80          134
3           2015-06-01 00:00:00.000 83          217
3           2015-09-01 00:00:00.000 102         319
3           2016-01-01 00:00:00.000 40          359
...

(636 row(s) affected)

-- 19
-- Explain the difference between IN and EXISTS

-- 20 
-- Write a query that returns for each order the number of days that past
-- since the same customer’s previous order. To determine recency among orders,
-- use orderdate as the primary sort element and orderid as the tiebreaker.
-- Tables involved: TSQLV4 database, Sales.Orders table

-- Desired output:
custid      orderdate  orderid     diff
----------- ---------- ----------- -----------
1           2015-08-25 10643       NULL
1           2015-10-03 10692       39
1           2015-10-13 10702       10
1           2016-01-15 10835       94
1           2016-03-16 10952       61
1           2016-04-09 11011       24
2           2014-09-18 10308       NULL
2           2015-08-08 10625       324
2           2015-11-28 10759       112
2           2016-03-04 10926       97
...

(830 row(s) affected)

------------------------------------------------------------------------------------------------------------
-- You cannot use TSQLV4 database tables for the following excercises
-- Each question comes with table DDLs (Data Dafinition Language scripts) for you to create required tables.
------------------------------------------------------------------------------------------------------------
 
-- Question # 21: Using the below tables, 
-- Find 3 lowest paid employees who have finished at least 3 projects 	
CREATE TABLE [dbo].[Employee](
	[ID] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[Salary] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Projects](
	[Project_ID] [int] NULL,
	[Employee_ID] [int] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Employee] ([ID], [Name], [Salary]) VALUES (1, N'A', 100)
GO
INSERT [dbo].[Employee] ([ID], [Name], [Salary]) VALUES (2, N'B', 50)
GO
INSERT [dbo].[Employee] ([ID], [Name], [Salary]) VALUES (3, N'C', 200)
GO
INSERT [dbo].[Employee] ([ID], [Name], [Salary]) VALUES (4, N'D', 150)
GO
INSERT [dbo].[Employee] ([ID], [Name], [Salary]) VALUES (5, N'E', 30)
GO
INSERT [dbo].[Employee] ([ID], [Name], [Salary]) VALUES (6, N'F', 10)
GO
INSERT [dbo].[Employee] ([ID], [Name], [Salary]) VALUES (7, N'G', 90)
GO
INSERT [dbo].[Employee] ([ID], [Name], [Salary]) VALUES (8, N'H', 180)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (1, 1)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (2, 3)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (3, 4)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (4, 5)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (5, 6)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (6, 2)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (7, 8)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (8, 7)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (9, 7)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (10, 8)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (11, 4)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (12, 3)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (13, 1)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (14, 1)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (15, 3)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (16, 4)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (17, 5)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (18, 6)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (19, 7)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (20, 8)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (21, 2)
GO
INSERT [dbo].[Projects] ([Project_ID], [Employee_ID]) VALUES (22, 5)
GO

--22. Find the Parent who have both male and femal children. 
-- This is a real Google Interview quesiton, Level = Easy

SELECT 'A' as Parent, 'Male' as ChildGender INTO tblPerson
UNION ALL
SELECT 'A' as Parent, 'Male' as ChildGender
UNION ALL
SELECT 'A' as Parent, 'Female' as ChildGender
UNION ALL
SELECT 'A' as Parent, 'Male' as ChildGender
UNION ALL
SELECT 'A' as Parent, 'Female' as ChildGender
UNION ALL
SELECT 'B' as Parent, 'Male' as ChildGender
UNION ALL
SELECT 'B' as Parent, 'Male' as ChildGender
UNION ALL
SELECT 'B' as Parent, 'Male' as ChildGender
UNION ALL
SELECT 'C' as Parent, 'Female' as ChildGender
UNION ALL
SELECT 'C' as Parent, 'Male' as ChildGender
UNION ALL
SELECT 'D' as Parent, 'Male' as ChildGender

-- Desired Output
Parent
------
A
C
