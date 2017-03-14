create PROCEDURE [dbo].[procENET_Active_Directory_Computer_UpdateReportedDate]
(
@cn varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_COMPUTER
SET LastReportedDate = getdate()
WHERE CommonName = @cn;



