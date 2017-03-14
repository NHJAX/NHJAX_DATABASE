create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateDescription]
(
@desc varchar(50), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET [Description] = @desc,
LastReportedDate = getdate()
WHERE LoginId = @log;



