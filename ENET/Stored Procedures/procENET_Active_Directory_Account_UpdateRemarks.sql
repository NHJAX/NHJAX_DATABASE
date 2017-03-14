create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateRemarks]
(
@ada bigint, 
@rem text,
@uby int
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET Remarks = @rem,
UpdatedBy = @uby,
UpdatedDate = getdate()
WHERE ActiveDirectoryAccountId = @ada;



