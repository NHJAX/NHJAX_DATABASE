CREATE PROCEDURE [dbo].[procENET_ASSET_ASSIGNMENT_SelectIssued]
(
	@tech int
)
AS

SELECT 
	TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName, 
	AST.NetworkName, 
	AST.SerialNumber
FROM  ENET.dbo.TECHNICIAN AS TECH 
	INNER JOIN ENET.dbo.ASSET_ASSIGNMENT AS ASG 
	ON TECH.UserId = ASG.AssignedTo 
	INNER JOIN ENET.dbo.ASSET AS AST 
	ON ASG.AssetId = AST.AssetId
WHERE (TECH.UserId = @tech) 
	AND (AST.AssetSubtypeId IN (3, 4)) 
	AND (AST.DispositionId IN (0, 1, 14, 15, 19, 20)) 
	AND (ASG.PrimaryUser = 1)


