create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdatePhone]
(
@ph varchar(50), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET Phone = @ph,
LastReportedDate = getdate()
WHERE LoginId = @log;



