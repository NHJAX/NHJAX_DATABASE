CREATE PROCEDURE [dbo].[upAIM_AssetSelect] 
(
	@network varchar(100) = '',
	@mac varchar(50) = '',
	@mac2 varchar(50) = '',
	@pre varchar(50) = '',
	@num varchar(50) = '',
	@ser varchar(50) = '',
	@debug bit = 0
)
AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT
			AST.AssetId, 
			AST.NetworkName, 
			AST.DepartmentId, 
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
			AST.ReqDocNumber
			FROM ASSET AST 
			INNER JOIN BUILDING BLDG 
			ON AST.BuildingId = BLDG.BuildingId 
			INNER JOIN DISPOSITION DISP 
			ON AST.DispositionId = DISP.DispositionId
			INNER JOIN MODEL MOD
			ON AST.ModelId = MOD.ModelId
			WHERE (DISP.DispositionId IN(SELECT DispositionId FROM DISPOSITION WHERE ViewLevelId = 1)) '

IF DataLength(@network) > 0
	SELECT @sql = @sql + 'AND (AST.NetworkName = @network) '

IF DataLength(@ser) > 0
	SELECT @sql = @sql + 'AND (AST.SerialNumber = @ser) '

IF DataLength(@mac2) > 0 AND DataLength(@mac) > 0
	BEGIN
	SELECT @sql = @sql + 'AND ((AST.MacAddress = @mac) OR (AST.MacAddress2 = @mac2)) '
	END
ELSE
	BEGIN
	IF DataLength(@mac) > 0
		BEGIN
		SELECT @sql = @sql + 'AND (AST.MacAddress = @mac) '
		END
	END	

IF DataLength(@pre) > 0 AND DataLength(@num) > 0
	BEGIN
	SELECT @sql = @sql + 'AND ((AST.PlantAccountPrefix = @pre) AND (AST.PlantAccountNumber = @num)) '
	END		

SELECT @sql = @sql + '	ORDER BY DISP.DispositionId DESC '

IF @debug = 1
	PRINT @sql
	PRINT @network
	PRINT @mac
	PRINT @mac2
	

SELECT @paramlist = 	'@network varchar(100),
			@mac	varchar(50),
			@mac2 varchar(50),
			@pre varchar(50),
			@num varchar(50),
			@ser varchar(50) '

EXEC sp_executesql	@sql, @paramlist, @network,@mac,@mac2,@pre,@num,@ser
