CREATE PROCEDURE [dbo].[upENet_AssetFileUpdate]
(
	@afl		int,
	@afn 		varchar(100) = '',
	@rem		bit = 0,
	@udate 	datetime,
	@uby		int = 0,
	@ast		int = 0,
	@sft		int = 0,
	@debug	bit = 0
)
 AS
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)
SELECT @sql = 'UPDATE ASSET_FILE SET
			Removed = @rem, '
IF DataLength(@afn) > 0
	SELECT @sql = @sql + 'AssetFileName = @afn, '
SELECT @sql = @sql + 'UpdatedBy = @uby,
			UpdatedDate = @udate 
			WHERE 1 = 1 '
IF @afl > 0
	SELECT @sql = @sql + 'AND AssetFileId = @afl '
IF @ast > 0
	SELECT @sql = @sql + 'AND AssetId = @ast '
IF @sft > 0
	SELECT @sql = @sql + 'AND SoftwareId = @sft '
IF @debug = 1
	PRINT @sql
	
SELECT @paramlist = 	'@afl		int,
			@afn		varchar(100),
			@rem		bit,
			@ast		int,
			@sft		int,
			@udate		datetime,
			@uby		int '
EXEC sp_executesql	@sql, @paramlist, @afl, @afn, @rem, @ast, @sft, @udate,@uby

