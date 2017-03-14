CREATE PROCEDURE [dbo].[procENET_Active_Directory_Computer_SelectbyName]
(
	@cn varchar(50)
)
 AS

SELECT 
	ActiveDirectoryComputerId,    
	CommonName, 
	operatingSystem,
	operatingSystemServicePack,
	lastLogon,
	OperatingSystemVersion,
	DNSHostName,
	Location,
	distinguishedName,
	Remarks,
	IsHidden
FROM ACTIVE_DIRECTORY_COMPUTER
WHERE CommonName = @cn

