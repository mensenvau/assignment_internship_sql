
-- function vs stored procedure
-- https://www.dotnettricks.com/learn/sqlserver/difference-between-stored-procedure-and-function-in-sql-server
--  CASE 1
--  top 20 employe function
CREATE PROC GET20TOPEmploye
AS
BEGIN
    SELECT TOP 20
           *
    FROM Employee
END;

-- run proc
EXEC GET20TOPEmploye

-- get text
EXEC sp_helptext  'GET20TOPEmploye'

--  CASE 2
-- the sum of the digits of the number
CREATE PROCEDURE numSum(@num int)
AS
begin
    declare  @sum int  =0 ;
    while(@num!=0) begin
       SET @sum=@sum+@num%10;
       SET @num= @num/10;
       print(@num)
    end
    select @sum ;
end

EXEC  numSum 15012; -- ans = 9


-- CASE  3
-- TRY CATCH

CREATE PROC DeleteProduct(@pid int)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION   -- tran ochti .....
            DELETE FROM  Product WHERE ProductID = @pid ;
--          ERROR BERADI PASDAGI
            RAISERROR(1,1,1); -- xato kelib qolsa agar ...
        COMMIT TRANSACTION  -- to'g'ri bo'sa yopadi ....
    END TRY

    BEGIN CATCH
        --  @@TRANCOUNT xato bo'lguncha bo'lgan amalar soni .
        PRINT ('SONI: ')
        PRINT(@@TRANCOUNT) ;
        IF @@TRANCOUNT > 0
             ROLLBACK TRANSACTION  -- orqaga qaytarish

         -- ERROR NI OLAMIZ
         DECLARE @em NVARCHAR(4000), @es INT;
         SELECT @em = ERROR_MESSAGE(),@es = ERROR_SEVERITY();
         --  ERROR BERAMIZ
         RAISERROR(@em, @es, 1)

    END CATCH
END


EXEC  DeleteProduct 1


--  CASE 4
-- INPUT OUTPUT
--  in out misol
CREATE PROCEDURE inoutExample(
    @color nvarchar(30),
    @out nvarchar(30) output
)
AS
BEGIN
    SET @out = (SELECT COUNT(*) FROM Product WHERE Color=@color)
END

--  run proc
DECLARE  @out nvarchar(30)
EXEC  inoutExample 'Black' , @out out
SELECT  @out AS BlackCountProduct


-- DROP , ALTER PROC  