-- TASK 1-1
-- CASE 1 ,
-- JOIN Employess and Nums

SELECT empid,firstname,lastname,n FROM HR.Employees , Nums
WHERE n BETWEEN  1 AND 5

-- CASE 2 UNION
SELECT empid,firstname,lastname,1 AS n FROM HR.Employees
UNION
SELECT empid,firstname,lastname,2 FROM HR.Employees
UNION
SELECT empid,firstname,lastname,3 FROM HR.Employees
UNION
SELECT empid,firstname,lastname,4 FROM HR.Employees
UNION
SELECT empid,firstname,lastname,5 FROM HR.Employees
ORDER BY n


-- TASK 1-2
--  Interval date save tmp_date ..
--  FULL JOIN Employess and tmp_date ..
DECLARE  @start DATE  = '2016-06-11';
WITH tmp_date AS (
    SELECT DATEADD(DAY, n, @start) as idate FROM nums
    WHERE DATEADD(DAY, n, @start) BETWEEN '2016-06-12' AND '2016-06-16'
)
SELECT empid,tmp_date.idate FROM Hr.Employees,tmp_date
ORDER BY  empid


-- TASK 2
-- error query
-- SELECT Customers.custid, Customers.companyname, Orders.orderid, Orders.orderdate
-- FROM Sales.Customers AS C
--   INNER JOIN Sales.Orders AS O
--     ON Customers.custid = Orders.custid;
-- #########################
-- Here we changed the TABLE names via AS
-- so its fields can be referenced by the New Name (C, O)
-- here is the right solution :)
SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
  INNER JOIN Sales.Orders AS O
    ON C.custid = O.custid;

-- TASK 3
-- INNER JOIN 3 Table Customers,Orders,OrderDetails
SELECT O.custid ,
       COUNT(DISTINCT O.orderid) AS numorders ,
       SUM(qty) AS totalqty
FROM Sales.Orders AS O
INNER JOIN  Sales.Customers AS C
    ON C.custid = O.custid
INNER JOIN Sales.OrderDetails AS OD
    ON O.orderid = OD.orderid
WHERE C.country = 'USA'
GROUP BY O.custid

-- TASK 4
-- LEFT JOIN two tables Customers and Orders
SELECT C.custid ,
       C.companyname,
       O.orderid ,
       O.orderdate
FROM Sales.Customers AS C LEFT JOIN Sales.Orders O
     ON C.custid = O.custid

-- TASK 5
-- LEFT JOIN two tables Customers and Orders
-- WHERE orderid IS NULL
SELECT C.custid ,
       C.companyname
FROM Sales.Customers AS C LEFT JOIN Sales.Orders O
     ON C.custid = O.custid
WHERE O.orderid IS NULL


-- TASK 6
-- LEFT JOIN two tables Customers and Orders
-- CASE 1
-- WHERE YEAR(O.orderdate)=2016 AND MONTH(O.orderdate)=2 AND DAY(O.orderdate)=12
SELECT C.custid ,
       C.companyname,
       O.orderid ,
       O.orderdate
FROM Sales.Customers AS C INNER JOIN Sales.Orders O
     ON C.custid = O.custid
WHERE YEAR(O.orderdate)=2016 AND MONTH(O.orderdate)=2 AND DAY(O.orderdate)=12
-- CASE 2
-- WHERE O.orderdate = '2016-02-12'

-- TASK 7
--  ORDER date 2016-02-12 save tmp ...
WITH tmp AS (
    SELECT *
    FROM Sales.Orders AS O
    WHERE YEAR(O.orderdate)=2016 AND MONTH(O.orderdate)=2 AND DAY(O.orderdate)=12
)
SELECT C.custid ,
       C.companyname,
       O.orderid ,
       O.orderdate
FROM Sales.Customers AS C LEFT JOIN tmp AS  O
     ON C.custid = O.custid

-- TASK 8
-- wrong query
-- where Coustemers connects to all Orders and only dates that are ‘2016-02-12’ or NULL are obtained
SELECT C.custid,
       C.companyname,
       O.orderid,
       O.orderdate
FROM Sales.Customers AS C
  LEFT OUTER JOIN Sales.Orders AS O
    ON O.custid = C.custid
WHERE O.orderdate = '20160212'
   OR O.orderid IS NULL;

-- TASK 9
--  ORDER date 2016-02-12 save tmp ...
--  Copy TASK 7 and EDIT
WITH tmp AS (
    SELECT *
    FROM Sales.Orders AS O
    WHERE YEAR(O.orderdate)=2016 AND MONTH(O.orderdate)=2 AND DAY(O.orderdate)=12
)
SELECT C.custid ,
       C.companyname,
       IIF(O.orderid IS NULL,'NO','YES') AS HasOrderOn20160212
FROM Sales.Customers AS C LEFT JOIN tmp AS  O
     ON C.custid = O.custid
ORDER BY custid

-- TASK 10
-- The union column will not have duplicate fields uninon all this is available
-- Union - (only distinct values)
-- Union all -  (allows duplicate values)

-- TASK 11
-- Roles = 'Actor' and (Tom,Bob) save tmp_M
WITH tmp_M AS (
    SELECT Mname FROM Movie
       WHERE Roles = 'Actor'
       GROUP BY MName
       HAVING count(DISTINCT AName) > 1
)
SELECT MName , AName , Roles FROM Movie AS M1
   WHERE Roles = 'Actor'
   AND  Mname IN (SELECT *FROM tmp_M)

-- TASK 12
-- IIF function max 3 value
SELECT Year1,IIF(Max1>Max2,IIF(Max1>Max3,Max1,Max3),IIF(Max2>Max3,Max2,Max3)) AS MaxValue FROM TestMax

-- TASK 13
-- INNER JOIN Person to Person P1.EmpSalary > P2.EmpSalary SELECT
SELECT P1.* FROM Person AS P1
    INNER JOIN Person AS P2
        ON P1.MgrID = P2.EmpID
WHERE P1.EmpSalary>P2.EmpSalary


-- TASK 14
SELECT Name FROM tblFruit
