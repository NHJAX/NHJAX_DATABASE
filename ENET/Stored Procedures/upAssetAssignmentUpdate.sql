CREATE PROCEDURE [dbo].[upAssetAssignmentUpdate]
(
	@ast int,
	@prim bit,
	@uby int,
	@asg int
)
AS
UPDATE ASSET_ASSIGNMENT SET
	PrimaryUser = 0, 
	UpdatedBy = @uby,
	UpdatedDate = getdate()
WHERE AssetId = @ast;



UPDATE ASSET_ASSIGNMENT SET
	PrimaryUser = 1,
	Inactive = 0,
	UpdatedBy = @uby,
	UpdatedDate = getdate()
WHERE AssetId = @ast
	AND AssignedTo = @asg;
