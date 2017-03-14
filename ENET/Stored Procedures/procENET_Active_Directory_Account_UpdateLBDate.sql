CREATE PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateLBDate]
(
@ada bigint, 
@lb datetime,
@uby int
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET LBDate = @lb,
UpdatedBy = @uby,
UpdatedDate = getdate(),
LBDateBy = @uby
WHERE ActiveDirectoryAccountId = @ada;



