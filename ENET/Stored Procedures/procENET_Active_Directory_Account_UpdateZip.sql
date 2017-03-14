create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateZip]
(
@zip varchar(10), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET Zip = @zip,
LastReportedDate = getdate()
WHERE LoginId = @log;



