


create PROCEDURE [dbo].[upAssetFileSelectPath]
(
	@ast int,
	@path varchar(500)
)
AS
SELECT AssetFileId,
	AssetId,
	AssetFileName,
	AssetFilePath,
	FileCreated,
	FileWritten,
	FileAccessed,
	FileSize,
	CreatedDate,
	CreatedBy,
	UpdatedDate,
	UpdatedBy,
	Removed,
	AssetFileExtensionId,
	FileVersion,
	FileComments
	FROM ASSET_FILE
	WHERE AssetId = @ast
	AND AssetFilePath = @path




