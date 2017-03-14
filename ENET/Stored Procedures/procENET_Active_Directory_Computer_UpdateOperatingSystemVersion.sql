create PROCEDURE [dbo].[procENET_Active_Directory_Computer_UpdateOperatingSystemVersion]
(
@cn varchar(50), 
@osv varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_COMPUTER
SET operatingSystemVersion = @osv,
LastReportedDate = getdate()
WHERE CommonName = @cn;



