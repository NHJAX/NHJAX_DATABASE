create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateAddress2]
(
@add2 varchar(100), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET Address2 = @add2,
LastReportedDate = getdate()
WHERE LoginId = @log;



