create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateCountry]
(
@cou varchar(50), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET Country = @cou,
LastReportedDate = getdate()
WHERE LoginId = @log;



