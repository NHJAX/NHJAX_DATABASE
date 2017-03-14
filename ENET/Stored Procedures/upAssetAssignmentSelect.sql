CREATE PROCEDURE [dbo].[upAssetAssignmentSelect](
	@ast		int = 0,
	@tech		int = 0,
	@debug	bit = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT
			ASG.AssignmentId,
			TECH.UserId, 
			ASG.PrimaryUser,
        			TECH.UFName,
        			TECH.ULName,
       			TECH.UMName, 
        			AUD.DisplayName, 
        			Aud.OrgChartCode, 
        			TECH.UPhone,
        			TECH.Extension
		        	FROM TECHNICIAN TECH
		        	INNER JOIN ASSET_ASSIGNMENT ASG
		       	ON TECH.UserId = ASG.AssignedTo
		        	INNER JOIN AUDIENCE AUD
		       	ON TECH.AudienceId = AUD.AudienceId 
		WHERE 
			1 = 1 '

IF @ast > 0
	SELECT @sql = @sql + 'AND ASG.AssetId = @ast '

IF @tech > 0
	SELECT @sql = @sql + 'AND ASG.AssignedTo = @tech '

IF @debug = 1
	PRINT @sql
	PRINT @ast
	PRINT @tech

SELECT @paramlist = 	'@ast		int = 0,
			@tech		int = 0'
			
EXEC sp_executesql	@sql, @paramlist, @ast, @tech
