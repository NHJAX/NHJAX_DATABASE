create PROCEDURE [dbo].[procENET_Active_Directory_Computer_SelectbyId]
(
	@adc bigint
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
WHERE ActiveDirectoryComputerId = @adc

