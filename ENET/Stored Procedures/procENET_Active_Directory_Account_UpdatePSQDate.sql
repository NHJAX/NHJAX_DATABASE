CREATE PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdatePSQDate]
(
@ada bigint, 
@psq datetime,
@uby int
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET PSQDate = @psq,
UpdatedBy = @uby,
UpdatedDate = getdate(),
PSQDateBy = @uby
WHERE ActiveDirectoryAccountId = @ada;



