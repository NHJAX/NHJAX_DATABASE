CREATE PROCEDURE [dbo].[upENet_AssetFileSelect](
	@rem		bit = 0,
	@afl		int = 0,
	@ast		int = 0,
	@afe		int = 0,
	@afn		varchar(100) = '',
	@sft		int = 0,
	@debug	bit = 0
)
 AS
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)
SELECT @sql = 'SELECT     
	AFL.AssetFileId, 
	AFL.AssetId, 
	AFL.AssetFileExtensionId, 
	AFL.AssetFileName, 
	AFL.AssetFilePath, 
	AFL.FileCreated, 
	AFL.FileWritten, 
	AFL.FileAccessed, 
	AFL.FileSize, 
	AFL.CreatedDate, 
	AFL.CreatedBy, 
	AFL.UpdatedDate, 
	AFL.UpdatedBy, 
	AFL.Removed, 
	AFL.SoftwareId, 
	AST.PlantAccountPrefix, 
	AST.PlantAccountNumber, 
	AST.SerialNumber, 
	AST.NetworkName, 
	SFT.SoftwareDesc, 
	TECH.UFName, 	
	TECH.ULName, 
	TECH.UMName, 
	AUD.DisplayName
FROM   ASSET_FILE AS AFL 
	INNER JOIN ASSET AS AST 
	ON AFL.AssetId = AST.AssetId 
	INNER JOIN SOFTWARE_NAME AS SFT 
	ON AFL.SoftwareId = SFT.SoftwareId 
	INNER JOIN vwPointOfContact AS POC 
	ON AST.AssetId = POC.AssetId 
	INNER JOIN TECHNICIAN AS TECH 
	ON POC.POCid = TECH.UserId 
	INNER JOIN AUDIENCE AS AUD 
	ON AST.AudienceId = AUD.AudienceId
WHERE     (1 = 1) '
IF @rem = 0
	SELECT @sql = @sql + 'AND AFL.Removed = 0 '
IF @sft > 0
	SELECT @sql = @sql + 'AND AFL.SoftwareId = @sft '
IF DataLength(@afn) > 0
	SELECT @sql = @sql + 'AND AFL.AssetFileName = @afn '
IF @ast > 0
	SELECT @sql = @sql + 'AND AFL.AssetId = @ast '
IF @afl > 0
	SELECT @sql = @sql + 'AND AFL.AssetFileId = @afl '
IF @afe > 0
	SELECT @sql = @sql + 'AND AFL.AssetFileId = @afe '
SELECT @sql = @sql + 'ORDER BY AST.PlantAccountPrefix, AST.PlantAccountNumber '
IF @debug = 1
	PRINT @sql
	PRINT @rem
	PRINT @sft
SELECT @paramlist = 	'@rem bit,
			@afl int,
			@ast int,
			@afe int,
			@afn varchar(100),
			@sft int '
			
EXEC sp_executesql	@sql, @paramlist, @rem, @afl, @ast, @afe, @afn, @sft
