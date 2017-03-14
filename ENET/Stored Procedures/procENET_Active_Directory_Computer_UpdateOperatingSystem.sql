create PROCEDURE [dbo].[procENET_Active_Directory_Computer_UpdateOperatingSystem]
(
@cn varchar(50), 
@os varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_COMPUTER
SET operatingSystem = @os,
LastReportedDate = getdate()
WHERE CommonName = @cn;



