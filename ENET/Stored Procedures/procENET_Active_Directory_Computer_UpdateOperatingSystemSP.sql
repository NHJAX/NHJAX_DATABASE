create PROCEDURE [dbo].[procENET_Active_Directory_Computer_UpdateOperatingSystemSP]
(
@cn varchar(50), 
@ossp varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_COMPUTER
SET operatingSystemServicePack = @ossp,
LastReportedDate = getdate()
WHERE CommonName = @cn;



