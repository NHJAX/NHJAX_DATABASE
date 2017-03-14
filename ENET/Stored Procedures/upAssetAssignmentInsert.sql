CREATE PROCEDURE [dbo].[upAssetAssignmentInsert]
(
	@ast int,
	@asg int,
	@cby int,
	@uby int,
	@prim bit
)
AS

IF @prim = 1
UPDATE ASSET_ASSIGNMENT SET
	PrimaryUser = 0, 
	UpdatedBy = @uby,
	UpdatedDate = getdate()
WHERE AssetId = @ast;


INSERT INTO ASSET_ASSIGNMENT
(
	AssetId, 
	AssignedTo,
	CreatedBy, 
	UpdatedBy,
	PrimaryUser,
	Usage
)
VALUES(
	@ast, 
	@asg,
	@cby, 
	@uby,
	@prim,
	1
);
