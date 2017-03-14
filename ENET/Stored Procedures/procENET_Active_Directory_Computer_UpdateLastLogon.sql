create PROCEDURE [dbo].[procENET_Active_Directory_Computer_UpdateLastLogon]
(
@cn varchar(50), 
@last datetime
)
 AS

UPDATE ACTIVE_DIRECTORY_COMPUTER
SET lastLogon = @last,
LastReportedDate = getdate()
WHERE CommonName = @cn;



