create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateAudienceDesc]
(
@aud varchar(50), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET AudienceDesc = @aud,
LastReportedDate = getdate()
WHERE LoginId = @log;



