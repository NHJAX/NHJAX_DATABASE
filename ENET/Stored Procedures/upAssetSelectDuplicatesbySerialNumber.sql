CREATE PROCEDURE [dbo].[upAssetSelectDuplicatesbySerialNumber] AS
SELECT     AST.AssetId, 
	MOD.ModelId, 
	ISNULL(MOD.ModelDesc, 'UNKNOWN') AS ModelDesc, 
	MAN.ManufacturerId, 
	MAN.ManufacturerDesc, 
             AST.PlantAccountPrefix, 
	AST.PlantAccountNumber, 
	AST.NetworkName, 
	UPPER(AST.SerialNumber) AS SerialNumber, 
	AST.AcquisitionDate, AST.MacAddress, AST.Remarks, 
	AST.AssetDesc, AST.WarrantyMonths, AST.UnitCost, 
	AST.EqpMgtBarCode, AST.ReqDocNumber, PROJ.ProjectId, PROJ.ProjectDesc, TYPE.AssetTypeId, 
	TYPE.AssetTypeDesc, STYPE.AssetSubTypeId, 
	STYPE.AssetSubTypeDesc, 
	AUD.AudienceId, 
	AUD.DisplayName, 
	AUD.OrgChartCode, 
	ISNULL(BASE.BaseId, 0) AS BaseId, 
	ISNULL(BASE.BaseName, 'UNKNOWN') AS BaseName, 
	BLDG.BuildingId, BLDG.BuildingDesc, DECK.DeckId, 
	DECK.DeckDesc, AST.Room, AST.MissionCritical, 
	AST.RemoteAccess, AST.OnLoan, AST.LeasedPurchased, 
	DISP.DispositionId, DISP.DispositionDesc, 
	DOM.DomainId, DOM.DomainName, TECH.UserId AS POCId, 
	TECH.UFName AS POCFName, TECH.ULName AS POCLName, 
	ISNULL(TECH.UMName, '') 
	AS POCMName, TECH1.UserId AS CById, 
	TECH1.UFName AS CByFName, TECH1.ULName AS CByLName, 
	ISNULL(TECH1.UMName, '') AS CByMName, 
	AST.CreatedDate, TECH2.UserId AS UById, 
	TECH2.UFName AS UByFName, TECH2.ULName AS UByLName, 
	ISNULL(TECH2.UMName, '') 
	AS UByMName, AST.UpdatedDate, 
	AST.InventoryDate, AST.PrinterConfig, 
	AST.SharePC, ASSET_1.NetworkName AS SharePCDesc
FROM DECK RIGHT OUTER JOIN
      ASSET ASSET_1 RIGHT OUTER JOIN
      vwDuplicateAssetbySerialNumber INNER JOIN
      ASSET_TYPE TYPE INNER JOIN
      ASSET AST ON TYPE.AssetTypeId = AST.AssetTypeId LEFT OUTER JOIN
      ASSET_SUBTYPE STYPE 
      ON STYPE.AssetSubTypeId = AST.AssetSubtypeId INNER JOIN
      TECHNICIAN TECH1 ON AST.CreatedBy = TECH1.UserId INNER JOIN
      TECHNICIAN TECH2 ON AST.UpdatedBy = TECH2.UserId INNER JOIN
      vwPointOfContact POC ON AST.AssetId = POC.AssetId INNER JOIN
      TECHNICIAN TECH ON POC.POCid = TECH.UserId 
      ON vwDuplicateAssetbySerialNumber.SerialNumber = AST.SerialNumber 
      ON ASSET_1.AssetId = AST.SharePC LEFT OUTER JOIN
      DOMAIN DOM ON AST.DomainId = DOM.DomainId LEFT OUTER JOIN
      DISPOSITION DISP ON AST.DispositionId = DISP.DispositionId 
      ON DECK.DeckId = AST.DeckId LEFT OUTER JOIN
      PROJECT PROJ ON AST.ProjectId = PROJ.ProjectId LEFT OUTER JOIN
      MANUFACTURER MAN INNER JOIN
      MODEL MOD ON MAN.ManufacturerId = MOD.ManufacturerId 
      ON AST.ModelId = MOD.ModelId LEFT OUTER JOIN
      BASE INNER JOIN
      BUILDING BLDG ON BASE.BaseId = BLDG.BaseId 
      ON AST.BuildingId = BLDG.BuildingId LEFT OUTER JOIN
      AUDIENCE AUD ON AST.AudienceId = AUD.AudienceId
WHERE     (AST.AssetId > 0) AND (DISP.ViewLevelId < 4)
ORDER BY AST.SerialNumber
