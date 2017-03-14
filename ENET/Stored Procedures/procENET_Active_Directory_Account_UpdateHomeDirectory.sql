create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateHomeDirectory]
(
@hmdir varchar(150), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET HomeDirectory = @hmdir,
LastReportedDate = getdate()
WHERE LoginId = @log;



