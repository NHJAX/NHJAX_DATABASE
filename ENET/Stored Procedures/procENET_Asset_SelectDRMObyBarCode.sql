create PROCEDURE [dbo].[procENET_Asset_SelectDRMObyBarCode]
(
	@eqp 		varchar(50)
)
 AS
	
SELECT     
	COUNT(AST.AssetId) 
FROM   ASSET AST WITH (NOLOCK)
RIGHT OUTER JOIN DISPOSITION DISP WITH (NOLOCK)	
	ON AST.DispositionId = DISP.DispositionId
WHERE AST.AssetId > 0 
	AND DISP.ViewLevelId < 4 
	AND AST.EqpMgtBarCode =  @eqp
				




