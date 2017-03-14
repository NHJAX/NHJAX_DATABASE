create PROCEDURE [dbo].[procENET_Active_Directory_Computer_UpdatedistinguishedName]
(
@cn varchar(50), 
@dist varchar(255)
)
 AS

UPDATE ACTIVE_DIRECTORY_COMPUTER
SET distinguishedName = @dist,
LastReportedDate = getdate()
WHERE CommonName = @cn;



