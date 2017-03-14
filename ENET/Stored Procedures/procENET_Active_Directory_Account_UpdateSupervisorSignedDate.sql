CREATE PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateSupervisorSignedDate]
(
@ada bigint, 
@sup datetime,
@uby int
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET SupervisorSignedDate = @sup,
UpdatedBy = @uby,
UpdatedDate = getdate(),
SupervisorSignedDateBy = @uby
WHERE ActiveDirectoryAccountId = @ada;



