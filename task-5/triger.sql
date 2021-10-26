--  craete log table ....
CREATE TABLE Product_LOG (
     ID int PRIMARY KEY  IDENTITY (1,1),
     log_text TEXT ,
     Savetime datetime default  current_timestamp
)

--  CASE 1
--  Product Insert Save log table
CREATE TRIGGER  ProductInsert ON Product
    FOR INSERT
AS
BEGIN
    DECLARE  @pid INT
    DECLARE  @pname nvarchar(200)
    -- men kam ma'lumot oldim ko'proq ma'lumot log qilsa bo'ladi .
    SELECT @pid=ProductID,@pname=ProductName FROM inserted
    INSERT INTO Product_LOG(log_text) values ('INSERT|'+CAST(@pid AS nvarchar(200))+'|'+@pname)
END ;

-- run triger insert date .....
INSERT [dbo].[Product] ([ProductName], [ProductNumber], [MakeFlag], [FinishedGoodsFlag], [Color], [SafetyStockLevel], [ReorderPoint], [StandardCost], [ListPrice], [SizeUnitMeasureCode], [WeightUnitMeasureCode], [Weight], [DaysToManufacture], [ProductLine], [Class], [Style], [ProductSubcategoryID], [ProductModelID], [SellStartDate], [SellEndDate], [DiscontinuedDate], [rowguid], [ModifiedDate])
VALUES ( N'Adjustable Race', N'AR_5381', 0, 0, NULL, 1000, 750, 0.0000, 0.0000, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, CAST(N'2008-04-30T00:00:00.000' AS DateTime), NULL, NULL, N'694215b7-08f7-4c0d-acb1-d734ba44c0c8', CAST(N'2014-02-08T10:01:36.827' AS DateTime))


--  CASE 2
--  Product delete Save log table
CREATE TRIGGER  ProductDelete ON Product
    FOR DELETE
AS
BEGIN
    DECLARE  @pid INT
    DECLARE  @pname nvarchar(200)
    -- men kam ma'lumot oldim ko'proq ma'lumot log qilsa bo'ladi .
    SELECT @pid=ProductID,@pname=ProductName FROM deleted
    INSERT INTO Product_LOG(log_text) values ('DELETE|'+CAST(@pid AS nvarchar(200))+'|'+@pname)
END ;

-- run triger delete
DELETE FROM Product WHERE ProductID=1009


--  CASE 3
--  Product update Save log table
CREATE TRIGGER  ProductUpdate ON Product
    FOR UPDATE
AS
BEGIN
    -- men kam ma'lumot oldim ko'proq ma'lumot log qilsa bo'ladi .
    -- delete data
    DECLARE  @pid1 INT
    DECLARE  @pname1 nvarchar(200)
    SELECT @pid1=ProductID,@pname1=ProductName FROM deleted

    -- new data
    DECLARE  @pid2 INT
    DECLARE  @pname2 nvarchar(200)
    SELECT @pid2=ProductID,@pname2=ProductName FROM inserted
    INSERT INTO Product_LOG(log_text) values ('ESKI|'+CAST(@pid1 AS nvarchar(200))+'|'+@pname1+'|YANGI'++CAST(@pid2 AS nvarchar(200))+'|'+@pname2)
END ;

-- run triger update table
UPDATE  Product SET ProductName='Shapka' WHERE ProductID = 1010


--  qolversa trigger delete update insert paytida bazi holar ham qolip ketti if berish kerag bo'ladi .....
--  trigger bilan table dan tashqari database eventlarni olsa ham bo'ladi ....
