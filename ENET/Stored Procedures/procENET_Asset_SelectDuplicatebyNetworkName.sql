create PROCEDURE [dbo].[procENET_Asset_SelectDuplicatebyNetworkName]
(
	@net varchar(100)
)
 AS

SELECT 
	AST.AssetId 
FROM ASSET AST
    INNER JOIN DISPOSITION DISP 
ON DISP.DispositionId = AST.DispositionId 
WHERE AST.NetworkName = @net 
    AND DISP.ViewLevelId < 3
ORDER BY AST.UpdatedDate DESC

