create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateADExpiresDate]
(
@exp varchar(50), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET ADExpiresDate = @exp,
LastReportedDate = getdate()
WHERE LoginId = @log;



