create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateReportedDate]
(
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET LastReportedDate = getdate()
WHERE LoginId = @log;



