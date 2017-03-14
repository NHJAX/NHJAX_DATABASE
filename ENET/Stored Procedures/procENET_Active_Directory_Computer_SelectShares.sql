create PROCEDURE [dbo].[procENET_Active_Directory_Computer_SelectShares]
(
	@ball bit = 0
)
 AS

IF @ball = 1
BEGIN
	SELECT  DISTINCT   
		ADC.ActiveDirectoryComputerId, 
		ADC.CommonName, 
		ADC.operatingSystem, 
		ADC.operatingSystemServicePack, 
		ADC.lastLogon, 
		ADC.OperatingSystemVersion, 
		ADC.DNSHostName, 
		ADC.Location, 
		ADC.distinguishedName, 
		ADC.CreatedDate, 
		ADC.UpdatedDate, 
		ADC.LastReportedDate, 
		ADC.DeletedDate, 
		ISNULL(ASTD.DispositionDesc, 'Not in ENet') AS DispositionDesc,
		ADC.Remarks,
		DATEDIFF(day,ADC.LastReportedDate,
		(
			SELECT TOP 1 LastReportedDate 
			FROM dbo.vwENET_ACTIVE_DIRECTORY_COMPUTER_LastReportedDate)
		) AS LastReportedDays,
		ISNULL(ASTD.DispositionId, -1) AS DispositionId,
		ADC.IsHidden,
		ADC.ShareUpdatedDate
	FROM vwENET_ASSET_DISPOSITION AS ASTD 
		RIGHT OUTER JOIN ACTIVE_DIRECTORY_COMPUTER AS ADC 
		ON ASTD.NetworkName = ADC.CommonName
	WHERE     (1 = 1) 
	AND ADC.DeletedDate < '7/4/1776' 
	AND ADC.ShareUpdatedDate IS NOT NULL 
END
ELSE
BEGIN
	SELECT  DISTINCT   
		ADC.ActiveDirectoryComputerId, 
		ADC.CommonName, 
		ADC.operatingSystem, 
		ADC.operatingSystemServicePack, 
		ADC.lastLogon, 
		ADC.OperatingSystemVersion, 
		ADC.DNSHostName, 
		ADC.Location, 
		ADC.distinguishedName, 
		ADC.CreatedDate, 
		ADC.UpdatedDate, 
		ADC.LastReportedDate, 
		ADC.DeletedDate, 
		ISNULL(ASTD.DispositionDesc, 'Not in ENet') AS DispositionDesc,
		ADC.Remarks,
		DATEDIFF(day,ADC.LastReportedDate,
		(
			SELECT TOP 1 LastReportedDate 
			FROM dbo.vwENET_ACTIVE_DIRECTORY_COMPUTER_LastReportedDate)
		) AS LastReportedDays,
		ISNULL(ASTD.DispositionId, -1) AS DispositionId,
		ADC.IsHidden,
		ADC.ShareUpdatedDate
	FROM vwENET_ASSET_DISPOSITION AS ASTD 
		RIGHT OUTER JOIN ACTIVE_DIRECTORY_COMPUTER AS ADC 
		ON ASTD.NetworkName = ADC.CommonName
	WHERE     (1 = 1) 
	AND ADC.DeletedDate < '7/4/1776' 
END





