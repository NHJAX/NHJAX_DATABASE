create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateDisplayName]
(
@disp varchar(150), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET DisplayName = @disp,
LastReportedDate = getdate()
WHERE LoginId = @log;



