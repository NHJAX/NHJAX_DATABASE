create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateAddress1]
(
@add1 varchar(100), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET Address1 = @add1,
LastReportedDate = getdate()
WHERE LoginId = @log;



