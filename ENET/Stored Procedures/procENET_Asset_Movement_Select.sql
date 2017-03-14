CREATE PROCEDURE [dbo].[procENET_Asset_Movement_Select]
(
	@sdate datetime,
	@edate datetime,
	@all bit
)
 AS

--PRINT @sdate
--PRINT @edate
--PRINT @all

--print datediff(n,@sdate,'1/1/1776')

IF @sdate > '1/1/1776'
BEGIN
	IF @all = 1
	BEGIN
		--PRINT '1'

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
		BLDG.BuildingDesc,
		ASSET.NetworkName
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
		AND (MOV.CreatedDate BETWEEN dbo.StartofDay(@sdate) 
		AND dbo.EndofDay(@edate))
	END

	ELSE
	BEGIN

		--PRINT '2'

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
		BLDG.BuildingDesc,
		ASSET.NetworkName
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
		AND (MOV.Reported = 0)
		AND (MOV.CreatedDate BETWEEN dbo.StartofDay(@sdate) 
		AND dbo.EndofDay(@edate))
	END
END

ELSE
BEGIN
	IF @all = 1
	BEGIN

		--PRINT '3'

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
		BLDG.BuildingDesc,
		ASSET.NetworkName
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
	END

	ELSE
	BEGIN

		--PRINT '4'

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
		BLDG.BuildingDesc,
		ASSET.NetworkName
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
		AND (MOV.Reported = 0)
	END
END

/*	
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
	AND (MOV.Reported = 0)
				
*/



