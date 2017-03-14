CREATE PROCEDURE [dbo].[upDomainSelect](
	@inactive	bit = 0,
	@dom		int = 0,
	@desc		varchar(50) = '',
	@debug	bit = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT
			DomainId,
			DomainName,
			CreatedDate,
			Inactive
		FROM         
			DOMAIN
		WHERE 
			1 = 1 '

IF @inactive = 0
	SELECT @sql = @sql + 'AND Inactive = 0 '

IF @dom > 0
	SELECT @sql = @sql + 'AND DomainId = @atyp '

IF DataLength(@desc) > 0
	SELECT @sql = @sql + 'AND DomainName = @desc '

SELECT @sql = @sql + 'ORDER BY DomainName '

IF @debug = 1
	PRINT @sql
	PRINT @inactive

SELECT @paramlist = 	'@inactive bit,
			@dom int,
			@desc varchar(50)'
			
EXEC sp_executesql	@sql, @paramlist, @inactive, @dom, @desc
