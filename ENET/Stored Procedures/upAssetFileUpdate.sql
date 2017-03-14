



CREATE PROCEDURE [dbo].[upAssetFileUpdate]
(
	@ast int,
	@file varchar(100),
	@path varchar(500),
	@fcr datetime,
	@fwr datetime,
	@fac datetime,
	@size bigint,
	@udate datetime,
	@ver varchar(50) = '',
	@com varchar(100) = ''
)
AS

if @ver = ''
	BEGIN
		SET @ver = 'N/A'
	END
UPDATE ASSET_FILE SET
	AssetFilePath = @path,
	FileCreated = @fcr,
	FileWritten = @fwr,
	FileAccessed = @fac,
	FileSize = @size,
	UpdatedDate = @udate,
	FileVersion = @ver,
	FileComments = @com
WHERE AssetId = @ast
	AND AssetFilePath = @path




