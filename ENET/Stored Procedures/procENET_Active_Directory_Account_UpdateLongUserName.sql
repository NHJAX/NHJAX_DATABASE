create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateLongUserName]
(
@long varchar(150), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET LongUserName = @long,
LastReportedDate = getdate()
WHERE LoginId = @log;



