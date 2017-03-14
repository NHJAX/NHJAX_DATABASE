create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateDirectorateDesc]
(
@dir varchar(50), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET DirectorateDesc = @dir,
LastReportedDate = getdate()
WHERE LoginId = @log;



