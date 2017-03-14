CREATE PROCEDURE [dbo].[upAIM_AssetAssignmentUpdate]
(
	@ast int,
	@prim bit,
	@uby int,
	@asg int
)
AS
IF @prim = 1
BEGIN
UPDATE ASSET_ASSIGNMENT SET
	PrimaryUser = 0, 
	UpdatedBy = @uby,
	UpdatedDate = getdate()
WHERE AssetId = @ast;
END
UPDATE ASSET_ASSIGNMENT SET
	PrimaryUser = @prim,
	Inactive = 0,
	UpdatedBy = @uby,
	UpdatedDate = getdate()
WHERE AssetId = @ast
	AND AssignedTo = @asg;

