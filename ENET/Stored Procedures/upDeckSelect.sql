CREATE PROCEDURE [dbo].[upDeckSelect](
	@inactive	bit = 0,
	@deck		int = 0,
	@debug	bit = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT
			DeckId,
			DeckDesc,
			CreatedDate,
			CreatedBy,
			UpdatedDate,
			UpdatedBy,
			Inactive
		FROM         
			DECK
		WHERE 
			1 = 1 '

IF @inactive = 0
	SELECT @sql = @sql + 'AND Inactive = 0 '

IF @deck > 0
	SELECT @sql = @sql + 'AND DeckId = @deck '

SELECT @sql = @sql + 'ORDER BY DeckId '

IF @debug = 1
	PRINT @sql
	PRINT @inactive

SELECT @paramlist = 	'@inactive bit,
			@deck int'
			
EXEC sp_executesql	@sql, @paramlist, @inactive, @deck
