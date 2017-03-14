CREATE PROCEDURE [dbo].[upDispositionSelect](
	@disp		int = 0,
	@vw		int = 0,
	@debug	bit = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT
			DispositionId,
			DispositionDesc,
			ViewLevelId
		FROM         
			DISPOSITION
		WHERE 
			1 = 1 '
IF @disp > 0
	SELECT @sql = @sql + 'AND DispositionId = @disp '

IF @vw > 0
	SELECT @sql = @sql + 'AND ViewLevelId < @vw '

SELECT @sql = @sql + 'ORDER BY DispositionDesc '

IF @debug = 1
	PRINT @sql
	
SELECT @paramlist = 	'@disp int,
			@vw int'
			
EXEC sp_executesql	@sql, @paramlist, @disp, @vw
