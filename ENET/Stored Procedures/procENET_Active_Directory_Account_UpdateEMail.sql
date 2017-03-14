CREATE PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateEMail]
(
@email varchar(250), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET EMail = RTRIM(LTRIM(@email)),
LastReportedDate = getdate()
WHERE LoginId = @log;



