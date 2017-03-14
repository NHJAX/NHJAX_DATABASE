create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateEmployeeId]
(
@emp varchar(50), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET EmployeeId = @emp,
LastReportedDate = getdate()
WHERE LoginId = @log;



