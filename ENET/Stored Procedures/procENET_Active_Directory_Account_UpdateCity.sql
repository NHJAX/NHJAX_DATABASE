create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateCity]
(
@city varchar(50), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET City = @city,
LastReportedDate = getdate()
WHERE LoginId = @log;



