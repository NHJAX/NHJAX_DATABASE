create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateTitle]
(
@tit varchar(50), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET Title = @tit,
LastReportedDate = getdate()
WHERE LoginId = @log;



