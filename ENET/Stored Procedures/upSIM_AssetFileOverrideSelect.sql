CREATE PROCEDURE [dbo].[upSIM_AssetFileOverrideSelect]
(
	@ast		int,
	@def		bit = 0,
	@inactive	bit = 0,
	@debug	bit = 0
)
AS
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000),
	@count		int 

SELECT @count = Count(AssetId) FROM ASSET_FILE_OVERRIDE WHERE AssetId = @ast AND AuditOverride = 1

IF @count > 0
BEGIN


	SELECT @sql = 	'SELECT
				AFE.AssetFileExtensionId,  
				AFE.AssetFileExtensionDesc, 
				SIM.MaxDate
			FROM   ASSET_FILE_OVERRIDE AFO 
				INNER JOIN vwSIM_MaxUpdateExtension SIM 
				ON AFO.AssetId = SIM.AssetId 
				AND AFO.AssetFileExtensionId = SIM.AssetFileExtensionId 
				RIGHT OUTER JOIN ASSET_FILE_EXTENSION AFE 
				ON AFO.AssetFileExtensionId = AFE.AssetFileExtensionId
			WHERE AFO.AssetId = @ast 
				AND AFO.AuditOverride = 1 '
	
	IF @def = 1 OR @inactive = 1
	BEGIN
	SELECT @sql = @sql + '	UNION
			SELECT  
				AFE.AssetFileExtensionId,   
				AFE.AssetFileExtensionDesc, 
				SIM.MaxDate
				FROM ASSET_FILE_EXTENSION AFE 
				INNER JOIN vwSIM_MaxUpdateExtension SIM 
				ON AFE.AssetFileExtensionId = SIM.AssetFileExtensionId
			WHERE     (SIM.AssetId = @ast) '
	
		IF @inactive = 0
		SELECT @sql = @sql +	'AND AFE.Inactive = 0 '
	END
END
ELSE
BEGIN
	SELECT @sql = 'SELECT    
				AFE.AssetFileExtensionId, 
				AFE.AssetFileExtensionDesc, 
				SIM.MaxDate
			FROM ASSET_FILE_EXTENSION AFE 
				INNER JOIN vwSIM_MaxUpdateExtension SIM 
				ON AFE.AssetFileExtensionId = SIM.AssetFileExtensionId
			WHERE     (SIM.AssetId = @ast) '

	IF @inactive = 0
	SELECT @sql = @sql + 'AND AFE.Inactive = 0 '
END

IF @debug = 1
	PRINT @sql
	PRINT @inactive
	PRINT 'def: ' PRINT @def
SELECT @paramlist = 	'@ast int,
			@def bit,
			@inactive bit'
			
EXEC sp_executesql	@sql, @paramlist, @ast, @def, @inactive
