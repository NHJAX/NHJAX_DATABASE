CREATE PROCEDURE [dbo].[upProjectSelect](
	@inactive	bit = 0,
	@proj 		int = 0,
	@debug	bit = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT
			ProjectId,
			ProjectDesc,
			CreatedDate,
			CreatedBy,
			UpdatedDate,
			UpdatedBy,
			Inactive
		FROM         
			PROJECT
		WHERE 
			1 = 1 '

IF @inactive = 0
	SELECT @sql = @sql + 'AND Inactive = 0 '

IF @proj > 0
	SELECT @sql = @sql + 'AND ProjectId = @proj '

SELECT @sql = @sql + 'ORDER BY ProjectId '

IF @debug = 1
	PRINT @sql
	PRINT @inactive

SELECT @paramlist = 	'@inactive bit,
			@proj int'
			
EXEC sp_executesql	@sql, @paramlist, @inactive, @proj
