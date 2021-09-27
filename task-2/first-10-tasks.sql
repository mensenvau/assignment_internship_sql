-- TASK 1
-- FIRST STRING LIKE 2015-06%
SELECT orderid ,
       orderdate ,
       custid ,
       empid
FROM Sales.Orders
WHERE Sales.Orders.orderdate LIKE '2015-06%';


-- TASK 2
-- The EOMONTH()  function returns the last day of the month of a specified date .
SELECT orderid ,
       orderdate ,
       custid ,
       empid
FROM Sales.Orders
WHERE DAY(EOMONTH(orderdate))=DAY(orderdate);


-- TASK 3
-- lastname LIKE LIKE '%e%e%'
SELECT empid ,
       firstname,
       lastname
FROM HR.Employees
WHERE HR.Employees.lastname  LIKE '%e%e%';


-- TASK 4
-- ..
SELECT  orderid,
        qty*unitprice AS totalvalue
FROM  Sales.OrderDetails
WHERE qty*unitprice> 10000
ORDER BY totalvalue  DESC;



-- TASK 5
-- (Latin1_General_BIN) case sensitive
SELECT empid ,
       lastname
FROM HR.Employees
WHERE  LEFT(lastname,1) COLLATE  Latin1_General_BIN BETWEEN  'a' AND 'z'


-- TASK 6
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

-- Query 1 - Har bir empid uchun takrorlanish soni hisoblaydi agar orderdate < '20160501'
-- Query 2 - Har bir empid uchun takrorlanish soni hisoblaydi agar MAX(orderdate) < '20160501'
-- Bir xil natija


-- TASK 7
-- TOP 3 MAX avgfreight
SELECT TOP 3
       shipcountry,
       AVG(freight) AS avgfreight
FROM  Sales.Orders
GROUP BY shipcountry
ORDER BY avgfreight DESC


-- TASK 8
-- FUNCTION ROW_NUMBER()
SELECT custid ,
       orderdate,
       orderid ,
       ROW_NUMBER() OVER (PARTITION BY custid ORDER BY orderid) AS rownum
FROM Sales.Orders


-- TASK 9
-- SWITCH CASE
SELECT empid ,
       firstname,
       lastname ,
       titleofcourtesy,
       CASE
           WHEN titleofcourtesy='Ms.' OR titleofcourtesy='Mrs.' THEN 'Female'
           WHEN titleofcourtesy='Mr.' THEN  'Male'
           ELSE 'Unknown'
      END AS gender
FROM HR.Employees


-- TASK 10
-- CASE 1 => ISNULL REPLACE CHAR(255)
SELECT  custid ,
        region
FROM  Sales.Customers
ORDER BY  ISNULL(region,CHAR(255)) , region
