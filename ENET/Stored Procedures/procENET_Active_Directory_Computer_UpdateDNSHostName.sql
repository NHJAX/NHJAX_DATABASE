create PROCEDURE [dbo].[procENET_Active_Directory_Computer_UpdateDNSHostName]
(
@cn varchar(50), 
@dns varchar(50)
)
 AS

UPDATE ACTIVE_DIRECTORY_COMPUTER
SET DNSHostName = @dns,
LastReportedDate = getdate()
WHERE CommonName = @cn;



