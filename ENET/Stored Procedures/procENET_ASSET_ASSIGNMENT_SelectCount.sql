create PROCEDURE [dbo].[procENET_ASSET_ASSIGNMENT_SelectCount]
(
	@ast int,
	@tech int
)
 AS

SELECT Count(AssignmentId)
FROM ASSET_ASSIGNMENT
WHERE AssetId = @ast
AND AssignedTo = @tech



