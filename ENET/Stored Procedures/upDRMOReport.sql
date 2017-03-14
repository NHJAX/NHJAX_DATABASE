CREATE PROCEDURE [dbo].[upDRMOReport]
(
	@tech int
)

 AS

SELECT	CASE ISNULL(ASSET_TYPE.AssetTypeId,9999)
		WHEN 9999 THEN 'NOT FOUND'
		ELSE
			CASE 
				WHEN DISP.DispositionId < 2 THEN ASSET_TYPE.AssetTypeDesc
				ELSE DISP.DispositionDesc
			END 
	END AS Expr1,
	CASE
		WHEN DataLength(DRMO.PlantPrefix) < 1 THEN AST.PlantAccountPrefix
		ELSE DRMO.PlantPrefix
	END AS PlantPrefix, 
	CASE
		WHEN DataLength(DRMO.PlantNumber) < 1 THEN AST.PlantAccountPrefix
		ELSE DRMO.PlantNUmber
	END AS PlantNumber,
	
	CASE
		WHEN DataLength(DRMO.SerialNumber) < 1 THEN UPPER(AST.SerialNumber)
		ELSE UPPER(DRMO.SerialNumber)
	END AS SerialNumber,
	CASE
		WHEN DataLength(DRMO.EquipmentNumber) < 1 THEN AST.EqpMgtBarCode
		ELSE DRMO.EquipmentNumber
	END AS EquipmentNumber, 
	MODEL.ModelDesc, 
	MANUFACTURER.ManufacturerDesc, 
	AST.DispositionId, 
	ISNULL(AST.UnitCost, 0) AS Expr2
FROM    ASSET_TYPE 
	INNER JOIN ASSET AST 
	ON ASSET_TYPE.AssetTypeId = AST.AssetTypeId 
	INNER JOIN MODEL 
	ON AST.ModelId = MODEL.ModelId 
	INNER JOIN MANUFACTURER 
	ON MODEL.ManufacturerId = MANUFACTURER.ManufacturerId
	INNER JOIN DISPOSITION DISP 
	ON AST.DispositionId = DISP.DispositionId 
	FULL OUTER JOIN sessDRMO DRMO 
	LEFT OUTER JOIN vwDRMOAssets vwDRMO 
	ON DRMO.DRMOId = vwDRMO.DRMOId 
	ON AST.AssetId = vwDRMO.AssetId
WHERE   (DRMO.CreatedBy = @tech)
ORDER BY DRMO.DRMOId
