create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateInactive]
(
@inac bit, 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET Inactive = @inac,
LastReportedDate = getdate()
WHERE LoginId = @log;



