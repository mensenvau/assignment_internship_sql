-- TASK 11
-- orderdate equal max orderdate
SELECT orderid ,
       orderdate,
       custid,
       empid
FROM Sales.Orders
WHERE  orderdate = (SELECT MAX(orderdate) FROM Sales.Orders)

-- TASK 12
-- Varibale num MAX count(custid) .
DECLARE @num INT;
SELECT TOP 1 @num=COUNT(custid) FROM Sales.Orders GROUP BY custid ORDER BY COUNT(custid) DESC;
SELECT custid ,
       orderid,
       orderdate,
       empid
FROM  (SELECT *,
       COUNT(custid) OVER(PARTITION BY custid ORDER BY custid) as c
FROM Sales.Orders ) AS T
WHERE T.c=@num


-- TASK 13
-- NOT IN INTERVAL ORDERS DATE
SELECT empid ,
       firstName,
       lastname
FROM Hr.Employees
WHERE empid NOT IN (SELECT distinct empid FROM Sales.Orders WHERE orderdate>='2016-05-01')

-- TASK 14
-- NOT IN Employees country
SELECT
    distinct  country
FROM Sales.Customers
WHERE country NOT IN (SELECT distinct country FROM HR.Employees)

-- TASK 15
-- WITH tmp max date => custid
WITH tmp AS (
    SELECT custid,
           max(orderdate) as mdate
    FROM Sales.Orders
    GROUP BY custid)

SELECT  T.custid,
        T.orderid,
        T.orderdate ,
        T.empid
FROM Sales.Orders as T INNER JOIN tmp
ON T.custid = tmp.custid AND T.orderdate=tmp.mdate
ORDER BY  T.custid

-- TASK 16
SELECT C.custid ,
       C.companyname
FROM Sales.Customers C
WHERE
      C.custid NOT IN (SELECT custid FROM Sales.Orders WHERE YEAR(orderdate) = 2016) AND
      C.custid     IN (SELECT custid FROM Sales.Orders WHERE YEAR(orderdate) = 2015)


-- TASK 17
SELECT C.custid ,
       C.companyname
FROM Sales.Customers C
WHERE C.custid IN (SELECT custid FROM Sales.Orders O INNER JOIN Sales.OrderDetails CD ON CD.orderid = O.orderid WHERE CD.productid = 12)

-- TASK 18
SELECT custid,
       mon,
       qty,
       SUM(sum) OVER (PARTITION BY custid ORDER BY mon,custid ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING) AS sum
FROM (
         SELECT custid,
                qty,
                MIN(ordermonth) as mon,
                sum(qty) as sum
         FROM Sales.CustOrders
         GROUP BY custid,MONTH(ordermonth),qty
     ) AS T

-- TASK 19

-- IN - Bu qaysdir columns ni IN tenglashtirgan qiymatlar ichida mavjudligni tekshiradi . masalan user_id IN (1,2,3,4,5,10)  ..
-- EXISTS - Bu so'rovning hich bo'lmaganda bita rows qaytishini kutadi agar qaytmasa FALSE bo'ladi .

-- TASK 20


-- TASK 21


-- TASK 22
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

-- my answer .....
SELECT Parent FROM tblPerson
GROUP BY Parent
HAVING COUNT(DISTINCT ChildGender)>1