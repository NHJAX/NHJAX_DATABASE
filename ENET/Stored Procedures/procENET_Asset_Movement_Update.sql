create PROCEDURE [dbo].[procENET_Asset_Movement_Update]
(
	@am		bigint,
	@uby	int,
	@rep	bit
)
 AS
UPDATE ASSET_MOVEMENT SET 
    Reported = @rep,
	UpdatedBy = @uby,
	UpdatedDate = getdate()
    WHERE AssetMovementId = @am




