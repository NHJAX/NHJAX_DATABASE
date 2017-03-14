create PROCEDURE [dbo].[procENET_Active_Directory_Account_UpdateENetStatus]
(
@stat int, 
@log varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_ACCOUNT
SET ENetStatus = @stat
WHERE LoginId = @log;



