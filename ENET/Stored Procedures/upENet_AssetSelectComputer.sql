CREATE PROCEDURE [dbo].[upENet_AssetSelectComputer]
(
	@pre	varchar(50) = '',
	@num	varchar(50) = '',
	@ser	varchar(50) = '',
	@debug bit = 0
)
AS
DECLARE @sql nvarchar(4000)
DECLARE @param nvarchar(4000)
SELECT @sql = 'SELECT AssetId
		FROM ASSET
		INNER JOIN DISPOSITION
		ON ASSET.DispositionId = DISPOSITION.DispositionId
		WHERE ASSET.AssetTypeId = 1
		AND DISPOSITION.ViewLevelId = 1 '
IF DataLength(@pre) > 0 AND DataLength(@num) > 0
	SELECT @sql = @sql + 'AND ASSET.PlantAccountPrefix = @pre AND ASSET.PlantAccountNumber = @num '
IF DataLength(@ser) > 0
	SELECT @sql = @sql + 'AND ASSET.SerialNumber = @ser '
IF @debug > 0
	PRINT @sql
	PRINT @ser
SELECT @param = 	'@pre varchar(50),
			@num varchar(50),
			@ser varchar(50) '
EXEC sp_executesql @sql,@param,@pre,@num,@ser

