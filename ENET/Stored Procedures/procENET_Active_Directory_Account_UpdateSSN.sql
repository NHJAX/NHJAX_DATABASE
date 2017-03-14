create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateSSN]
(
@ssn varchar(11), 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET SSN = @ssn
WHERE LoginId = @log;



