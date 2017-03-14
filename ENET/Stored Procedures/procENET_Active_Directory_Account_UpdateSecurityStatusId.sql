create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateSecurityStatusId]
(
@ada bigint, 
@ss int,
@uby int
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET SecurityStatusId = @ss,
UpdatedBy = @uby,
UpdatedDate = getdate()
WHERE ActiveDirectoryAccountId = @ada;



