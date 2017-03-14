create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateIsHidden]
(
@ada bigint, 
@hid bit,
@uby int
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET IsHidden = @hid,
UpdatedBy = @uby,
UpdatedDate = getdate()
WHERE ActiveDirectoryAccountId = @ada;



