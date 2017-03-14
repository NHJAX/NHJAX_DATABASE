create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateServiceAccount]
(
@ada bigint, 
@svc bit,
@uby int
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET ServiceAccount = @svc,
UpdatedBy = @uby,
UpdatedDate = getdate()
WHERE ActiveDirectoryAccountId = @ada;



