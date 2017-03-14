

CREATE PROCEDURE [dbo].[upAssetFileSelect]
(
	@ast int,
	@file varchar(100)
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
	AND AssetFileName = @file



