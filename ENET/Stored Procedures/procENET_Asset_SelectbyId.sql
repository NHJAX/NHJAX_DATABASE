create PROCEDURE [dbo].[procENET_Asset_SelectbyId]
(
	@id 		int
)
 AS
SELECT     
	AST.AssetId, 
	MOD.ModelId, 
	MOD.ModelDesc, 
	MAN.ManufacturerId, 
	MAN.ManufacturerDesc, 
	AST.PlantAccountPrefix, 
	AST.PlantAccountNumber, 
	AST.NetworkName, 
	UPPER(AST.SerialNumber) AS SerialNumber, 
	AST.AcquisitionDate, 
	AST.MacAddress, 
	AST.Remarks, 
    AST.AssetDesc, 
	AST.WarrantyMonths, 
	AST.UnitCost, 
	AST.EqpMgtBarCode, 
	AST.ReqDocNumber, 
	PROJ.ProjectId, 
	PROJ.ProjectDesc, 
	TYPE.AssetTypeId, 
    TYPE.AssetTypeDesc, 
	STYPE.AssetSubTypeId, 
	STYPE.AssetSubTypeDesc, 
	AUD.AudienceId, 
	AUD.AudienceDesc, 
	AUD.OrgChartCode, 
    ISNULL(BASE.BaseId, 0) AS BaseId, 
	ISNULL(BASE.BaseName, 'UNKNOWN') AS BaseName, 
	BLDG.BuildingId, 
	BLDG.BuildingDesc, 
	DECK.DeckId, 
	DECK.DeckDesc, 
	AST.Room, 
	AST.MissionCritical, 
	AST.RemoteAccess, 
	AST.OnLoan, 
	AST.LeasedPurchased, 
	DISP.DispositionId, 
	DISP.DispositionDesc, 
   	DOM.DomainId, 
	DOM.DomainName, 
	TECH.UserId AS POCId, 
	TECH.UFName AS POCFName, 
	TECH.ULName AS POCLName, 
	ISNULL(TECH.UMName, '') AS POCMName, 
	TECH1.UserId AS CById, 
	TECH1.UFName AS CByFName, 
	TECH1.ULName AS CByLName, 
	ISNULL(TECH1.UMName, '') AS CByMName, 
     	AST.CreatedDate, 
	TECH2.UserId AS UById, 
	TECH2.UFName AS UByFName, 
	TECH2.ULName AS UByLName, 
	ISNULL(TECH2.UMName, '') AS UByMName, 
	AST.UpdatedDate, 
	AST.InventoryDate, 
	AST.PrinterConfig, 
	AST.SharePC, 
	ASSET_1.NetworkName AS SharePCDesc,
	AUD.DisplayName,
	TECH.UPhone AS POCPhone
FROM   MANUFACTURER MAN WITH (NOLOCK)
	INNER JOIN MODEL MOD WITH (NOLOCK)
	ON MAN.ManufacturerId = MOD.ManufacturerId 
	INNER JOIN DISPOSITION DISP WITH (NOLOCK)
	INNER JOIN DOMAIN DOM WITH (NOLOCK)
	INNER JOIN ASSET_TYPE TYPE WITH (NOLOCK)
	INNER JOIN ASSET AST WITH (NOLOCK)
	ON TYPE.AssetTypeId = AST.AssetTypeId 
	INNER JOIN ASSET_SUBTYPE STYPE WITH (NOLOCK)
	ON STYPE.AssetSubTypeId = AST.AssetSubtypeId 
	INNER JOIN TECHNICIAN TECH1 WITH (NOLOCK)
	ON AST.CreatedBy = TECH1.UserId 
	INNER JOIN TECHNICIAN TECH2 WITH (NOLOCK)
	ON AST.UpdatedBy = TECH2.UserId 
	INNER JOIN vwPointOfContact POC 
	ON AST.AssetId = POC.AssetId 
	INNER JOIN TECHNICIAN TECH WITH (NOLOCK)
	ON POC.POCid = TECH.UserId 
	LEFT OUTER JOIN ASSET ASSET_1 WITH (NOLOCK)
	ON AST.SharePC = ASSET_1.AssetId 
	ON DOM.DomainId = AST.DomainId 
	ON DISP.DispositionId = AST.DispositionId 
	INNER JOIN DECK WITH (NOLOCK)
	ON AST.DeckId = DECK.DeckId 
	INNER JOIN PROJECT PROJ WITH (NOLOCK)
	ON AST.ProjectId = PROJ.ProjectId 
	ON MOD.ModelId = AST.ModelId 
	INNER JOIN BASE WITH (NOLOCK)
	INNER JOIN BUILDING BLDG WITH (NOLOCK)
	ON BASE.BaseId = BLDG.BaseId 
	ON AST.BuildingId = BLDG.BuildingId 
	INNER JOIN AUDIENCE AUD WITH (NOLOCK)
	ON AST.AudienceId = AUD.AudienceId 
WHERE AST.AssetId > 0 
	AND DISP.ViewLevelId < 4 
	AND AST.AssetId = @id
