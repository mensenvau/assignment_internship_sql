-- CASE 1
-- Product table I create views by taking some parts
CREATE VIEW V_Praduct_Class AS
(SELECT ProductID,ProductName,Class FROM Product WHERE Class IS Not NULL);

-- SELECT VIEW
SELECT *FROM V_Praduct_Class;


-- CASE 2
-- Create views in Category Name and Sub Category Name
CREATE VIEW V_Category AS (
SELECT ProductSubCategoryName,
       Name
FROM ProductSubcategory
    INNER JOIN  ProductCategory PC on ProductSubcategory.ProductCategoryID = PC.ProductCategoryID
)
-- SELECT VIEW
SELECT *FROM V_Category


-- CASE 3
-- SalesOrderDetail Table GROUP by PraductID SUM line totol
CREATE VIEW V_PraductLineSum AS (
    SELECT ProductID,
           SUM(LineTotal) AS sum
    FROM SalesOrderDetail
    GROUP BY ProductID
)

-- SELECT VIEW
SELECT *FROM V_PraductLineSum



-- ALTER VIEW  - update VIEW
-- DROP VIEW  -  delete VIEW
-- UPDATE VIEW  - bazi holatlarda 