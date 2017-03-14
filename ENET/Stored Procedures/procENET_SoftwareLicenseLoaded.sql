
CREATE PROCEDURE [dbo].[procENET_SoftwareLicenseLoaded]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT  DISTINCT   
	LIC.SoftwareId, 
	LIC.SoftwareDesc, 
	LIC.TotalCost, 
	LIC.TotalLicenses, 
	LIC.SeparateLicenses, 
	ISNULL(LD.ULName + ', ' + LD.UFName + ' ' + LD.UMName, '') AS UserName, 
	ISNULL(LD.NetworkName,'') AS NetworkName, 
	ISNULL(LD.CreatedDate,'') AS CreatedDate
FROM vwENET_SoftwareLicenses AS LIC 
LEFT OUTER JOIN vwENET_SoftwareLoaded AS LD ON LIC.SoftwareId = LD.SoftwareId
INNER JOIN ASSET ON ASSET.NetworkName = LD.NetworkName
WHERE ASSET.DispositionId IN (SELECT DispositionId FROM DISPOSITION WHERE ViewLevelId = 1)
ORDER BY LIC.SoftwareDesc
      
END

