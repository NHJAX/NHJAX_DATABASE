create PROCEDURE [dbo].[procENET_Asset_Movement_SelectAll]

 AS
	
SELECT     
	MOV.AssetMovementId, 
	MOV.Reported, 
	MOV.AssetId,
	MOV.FromAudienceId,
	FROMAUD.DisplayName AS FromDisplayName, 
	FROMAUD.OrgChartCode AS FromOrgChartCode, 
	MOV.ToAudienceId,
	TOAUD.DisplayName AS ToDisplayName, 
	TOAUD.OrgChartCode AS ToOrgChartCode, 
	ASSET.PlantAccountPrefix, 
	ASSET.PlantAccountNumber, 
	ASSET.SerialNumber,
	ASSET.EqpMgtBarCode,
	TYP.AssetTypeDesc, 
	SUB.AssetSubTypeDesc, 
	MOD.ModelDesc, 
	MANF.ManufacturerDesc, 
	ASSET.Room, 
	MOV.CreatedDate,
	MOV.CreatedBy,
	BLDG.BuildingDesc
FROM	ASSET_MOVEMENT AS MOV 
	INNER JOIN ASSET 
	ON MOV.AssetId = ASSET.AssetId 
	INNER JOIN AUDIENCE AS FROMAUD 
	ON MOV.FromAudienceId = FROMAUD.AudienceId 
	INNER JOIN ASSET_TYPE AS TYP 
	ON ASSET.AssetTypeId = TYP.AssetTypeId 
	INNER JOIN ASSET_SUBTYPE AS SUB 
	ON ASSET.AssetSubtypeId = SUB.AssetSubTypeId 
	INNER JOIN AUDIENCE AS TOAUD 
	ON MOV.ToAudienceId = TOAUD.AudienceId 
	INNER JOIN MODEL AS MOD 
	ON ASSET.ModelId = MOD.ModelId 
	INNER JOIN MANUFACTURER AS MANF 
	ON MOD.ManufacturerId = MANF.ManufacturerId
	INNER JOIN BUILDING AS BLDG
	ON ASSET.BuildingId = BLDG.BuildingId
WHERE     (MOV.FromAudienceId > 0) 
	AND (MOV.ToAudienceId > 0)
	AND (MOV.FromAudienceId <> MOV.ToAudienceId)
	
				




