

CREATE PROCEDURE [dbo].[upAssetFileInsert]
(
	@ast int,
	@file varchar(100),
	@path varchar(500),
	@fcr datetime,
	@fwr datetime,
	@fac datetime,
	@size bigint,
	@ext int,
	@ver varchar(50) = '',
	@com varchar(100) = ''
)
AS
if @ver = ''
	BEGIN
		SET @ver = 'N/A'
	END

INSERT INTO ASSET_FILE
(
AssetId, 
AssetFileName,
AssetFilePath,
FileCreated,
FileWritten,
FileAccessed, 
FileSize,
AssetFileExtensionId,
FileVersion,
FileComments
)
VALUES
(
@ast, 
@file, 
@path,
@fcr,
@fwr,
@fac,
@size,
@ext,
@ver,
@com
)


