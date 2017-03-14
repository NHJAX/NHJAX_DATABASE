create PROCEDURE [dbo].[procENET_ASSET_ASSIGNMENT_ResetPrimary]
(
	@ast int,
	@tech int
)
 AS

UPDATE ASSET_ASSIGNMENT
SET PrimaryUser = 0,
UpdatedBy = @tech,
UpdatedDate = getdate()
WHERE AssetId = @ast



