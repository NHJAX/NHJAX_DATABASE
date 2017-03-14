CREATE PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateCompletedDatebyUserId]
(
@usr int, 
@uby int
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET CompletedDate = getdate(),
UpdatedBy = @uby,
UpdatedDate = getdate(),
CompletedDateBy = @uby
WHERE LoginId = (
	SELECT TECHNICIAN.LoginId
	FROM TECHNICIAN
	WHERE UserId = @usr)



