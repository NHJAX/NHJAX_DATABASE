CREATE PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateDoDEDI]
(
@dod nvarchar(10), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET DoDEDI = @dod
WHERE LoginId = @log;



