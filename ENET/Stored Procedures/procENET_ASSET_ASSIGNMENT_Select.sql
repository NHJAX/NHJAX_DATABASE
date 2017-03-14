create PROCEDURE [dbo].[procENET_ASSET_ASSIGNMENT_Select]
(
	@ast int,
	@tech int
)
 AS

SELECT AssignmentId
FROM ASSET_ASSIGNMENT
WHERE AssetId = @ast
AND AssignedTo = @tech



