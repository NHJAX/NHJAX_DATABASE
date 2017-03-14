CREATE PROCEDURE [dbo].[procAIM_AssetSelectbyMacs] 
(
	@mac varchar(50),
	@mac2 varchar(50)
)
AS

SELECT
	AST.AssetId, 
	AST.NetworkName, 
	AST.AudienceId, 
	BLDG.BaseId, 
	AST.BuildingId, 
	AST.DeckId, 
	AST.Room, 
	AST.PlantAccountPrefix, 
    AST.PlantAccountNumber, 
	AST.UpdatedDate,
	UPPER(AST.SerialNumber) AS SerialNumber,
	AST.ModelId,
	MOD.ManufacturerId,
	AST.AssetSubTypeId,
	AST.DispositionId,
	AST.MacAddress,
	AST.MacAddress2,
	AST.ProjectId,
	AST.AcquisitionDate,
	AST.UnitCost,
	AST.WarrantyMonths,
	AST.ReqDocNumber,
	AST.IsAIMException
	FROM ASSET AST 
	INNER JOIN BUILDING BLDG 
	ON AST.BuildingId = BLDG.BuildingId 
	INNER JOIN DISPOSITION DISP 
	ON AST.DispositionId = DISP.DispositionId
	INNER JOIN MODEL MOD
	ON AST.ModelId = MOD.ModelId
	WHERE (DISP.DispositionId IN(SELECT DispositionId FROM DISPOSITION WHERE ViewLevelId = 1)) 
	AND ((AST.MacAddress = @mac) OR (AST.MacAddress2 = @mac2))
