create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateHomeDrive]
(
@hmdrv varchar(50), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET HomeDrive = @hmdrv,
LastReportedDate = getdate()
WHERE LoginId = @log;



