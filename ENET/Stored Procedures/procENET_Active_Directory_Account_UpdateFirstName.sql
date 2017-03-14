create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateFirstName]
(
@fname varchar(50), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET FirstName = @fname,
LastReportedDate = getdate()
WHERE LoginId = @log;



