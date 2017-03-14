CREATE PROCEDURE [dbo].[procENET_DM_ADC_Select]
(
	@sess varchar(50) = 'xyz'
)
 AS

SELECT     
	SessionKey, 
	DMCreatedDate, 
	ActiveDirectoryComputerId, 
	CommonName, 
	OperatingSystem, 
	OperatingSystemServicePack, 
	LastLogon, 
	OperatingSystemVersion, 
	DNSHostName, 
	Location, 
	distinguishedName, 
	CreatedDate, 
	UpdatedDate, 
	LastReportedDate, 
	DeletedDate, 
	DispositionDesc, 
	Remarks, 
	LastReportedDays, 
	DispositionId, 
	IsHidden
FROM DM_ADC
WHERE SessionKey = @sess

