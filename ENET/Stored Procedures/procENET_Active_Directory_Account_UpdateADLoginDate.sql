create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateADLoginDate]
(
@last varchar(50), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET ADLoginDate = @last,
LastReportedDate = getdate()
WHERE LoginId = @log;



