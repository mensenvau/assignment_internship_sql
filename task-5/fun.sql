-- CASE 1
--  scalar-valued function  => in which case the result of the defined type returns
--  Praduct table ListPrice and ListPrice find the difference
CREATE FUNCTION  SCOST_LPRICE_DIFF(
  @PraductId INT
)
RETURNS Numeric(10,2) --  INT
    AS
BEGIN
    DECLARE @ans INT =0
    SET @ans = (SELECT ListPrice-StandardCost FROM Product WHERE ProductID = @PraductId)
    RETURN @ans
END

-- run fun
SELECT  dbo.SCOST_LPRICE_DIFF(750)


-- CASE 2
-- inline table-valued function -> as a result the table returns
-- The view difference parameter is present in the function

-- search like praduct name
CREATE FUNCTION  SEARCH_PRADUCT(
  @SEARCH_TX VARCHAR(200)
)
RETURNS TABLE AS
RETURN (
    SELECT *FROM Product WHERE ProductName LIKE '%'+@SEARCH_TX+'%'
)

-- run fun
-- search like praduct name
SELECT *FROM  dbo.SEARCH_PRADUCT('Road');


-- CASE 3
-- multi-statement table-valued function -> The result returns to the table with only the variable
-- Order once @start_year Date of first and last order of products
CREATE FUNCTION  PRADUCT_FIRST_ODATE(
  @start_year VARCHAR(200)
)
RETURNS @ans TABLE(
    ProductID int ,
    FirstOrder datetime ,
    LastOrder datetime
)
AS
begin
with cte AS (
    SELECT  ProductID ,
            MIN(OrderDate) AS FirstOrder,
            MAX(OrderDate) AS LastOrder
    FROM SalesOrderDetail SD INNER JOIN SalesOrderHeader SOH on SD.SalesOrderID = SOH.SalesOrderID
    GROUP BY  ProductID
)

  INSERT @ans SELECT *FROM cte WHERE YEAR(FirstOrder)=@start_year
  return
end

-- run fun
-- search like praduct name
SELECT *FROM  dbo.PRADUCT_FIRST_ODATE('2011');



-- ALTER FUNCTION  - update function
-- DROP FUNCTION  -  delete function