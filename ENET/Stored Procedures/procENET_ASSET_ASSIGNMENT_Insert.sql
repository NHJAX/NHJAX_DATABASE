create PROCEDURE [dbo].[procENET_ASSET_ASSIGNMENT_Insert]
(
	@ast int,
	@asg int,
	@cby int,
	@uby int,
	@prim bit
)
 AS

INSERT INTO ASSET_ASSIGNMENT
(
	AssetId,
	AssignedTo,
	CreatedBy,
	UpdatedBy,
	PrimaryUser
)
VALUES
(	
	@ast,
	@asg,
	@cby,
	@uby,
	@prim
)



