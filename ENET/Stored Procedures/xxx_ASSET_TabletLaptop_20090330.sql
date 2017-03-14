create PROCEDURE [dbo].[xxx_ASSET_TabletLaptop_20090330]

AS

SELECT     
	AST.PlantAccountNumber, 
	AST.NetworkName, 
	AST.SerialNumber, 
	DISP.DispositionDesc, 
	TECH.ULName, 
	TECH.UFName, 
	TECH.UMName, 
	AST.Room, 
	AUDIENCE.DisplayName
FROM ASSET AS AST 
	INNER JOIN DISPOSITION AS DISP 
	ON AST.DispositionId = DISP.DispositionId 
	INNER JOIN vwPointOfContact AS POC 
	ON AST.AssetId = POC.AssetId 
	INNER JOIN TECHNICIAN AS TECH 
	ON POC.POCid = TECH.UserId 
	INNER JOIN AUDIENCE 
	ON AST.AudienceId = AUDIENCE.AudienceId
WHERE     (AST.AssetTypeId = 1) 
	AND (AST.DispositionId IN (0, 1, 14, 15, 19)) 
	AND (AST.AssetSubtypeId IN (3, 4))
ORDER BY AST.NetworkName





