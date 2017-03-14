CREATE PROCEDURE [dbo].[upAssetFileUpdateRemove]
(
	@ast int,
	@ext int
)
AS
UPDATE ASSET_FILE
SET 	
	Removed = 1,
	UpdatedDate = getdate(),
	UpdatedBy = 0
WHERE
	DATEDIFF(d,UpdatedDate,getdate()) > 90
	AND AssetId = @ast
	AND AssetFileExtensionId = @ext
	AND Removed = 0
