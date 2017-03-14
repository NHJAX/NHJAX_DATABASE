create PROCEDURE [dbo].[procENET_Active_Directory_Computer_UpdateLocation]
(
@cn varchar(50), 
@loc varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_COMPUTER
SET Location = @loc,
LastReportedDate = getdate()
WHERE CommonName = @cn;



