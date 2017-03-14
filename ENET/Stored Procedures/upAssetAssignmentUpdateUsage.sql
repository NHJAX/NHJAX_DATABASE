create PROCEDURE [dbo].[upAssetAssignmentUpdateUsage]
(
	@ast int,
	@asg int
)
AS

UPDATE ASSET_ASSIGNMENT SET
	Usage = Usage + 1
WHERE AssetId = @ast
AND AssignedTo = @asg;
