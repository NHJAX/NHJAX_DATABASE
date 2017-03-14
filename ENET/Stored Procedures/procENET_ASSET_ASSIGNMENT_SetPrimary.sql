create PROCEDURE [dbo].[procENET_ASSET_ASSIGNMENT_SetPrimary]
(
	@ast int,
	@tech int,
	@asg int
)
 AS

UPDATE ASSET_ASSIGNMENT
SET PrimaryUser = 1,
UpdatedBy = @tech,
UpdatedDate = getdate()
WHERE AssetId = @ast
AND AssignedTo = @asg



