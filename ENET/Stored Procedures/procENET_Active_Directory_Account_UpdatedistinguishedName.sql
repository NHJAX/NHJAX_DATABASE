CREATE PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdatedistinguishedName]
(
@dist varchar(255), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET distinguishedName = @dist,
LastReportedDate = getdate()
WHERE LoginId = @log;



