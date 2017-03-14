CREATE PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateSignedDate]
(
@ada bigint, 
@sig datetime,
@uby int
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET SignedDate = @sig,
UpdatedBy = @uby,
UpdatedDate = getdate(),
SignedDateBy = @uby
WHERE ActiveDirectoryAccountId = @ada;



