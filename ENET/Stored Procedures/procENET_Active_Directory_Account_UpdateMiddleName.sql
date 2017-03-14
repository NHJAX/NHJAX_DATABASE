create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateMiddleName]
(
@mname varchar(50), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET MiddleName = @mname,
LastReportedDate = getdate()
WHERE LoginId = @log;



