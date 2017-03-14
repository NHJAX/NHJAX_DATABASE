create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateBaseDesc]
(
@bas varchar(50), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET BaseDesc = @bas,
LastReportedDate = getdate()
WHERE LoginId = @log;



