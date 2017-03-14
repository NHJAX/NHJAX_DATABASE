CREATE PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateCompletedDate]
(
@ada bigint, 
@comp datetime,
@uby int
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET CompletedDate = @comp,
UpdatedBy = @uby,
UpdatedDate = getdate(),
CompletedDateBy = @uby
WHERE ActiveDirectoryAccountId = @ada;



