﻿CREATE PROCEDURE [dbo].[procAIM_AssetSelectbyPlant] 
(
	@pre varchar(50),
	@num varchar(50)
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
	AND ((AST.PlantAccountPrefix = @pre) AND (AST.PlantAccountNumber = @num))
