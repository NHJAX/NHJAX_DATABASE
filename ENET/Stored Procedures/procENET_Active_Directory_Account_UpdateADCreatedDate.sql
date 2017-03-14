create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateADCreatedDate]
(
@cre datetime, 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET ADCreatedDate = @cre,
LastReportedDate = getdate()
WHERE LoginId = @log;



