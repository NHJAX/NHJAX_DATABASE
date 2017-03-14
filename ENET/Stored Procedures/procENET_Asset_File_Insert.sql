create PROCEDURE [dbo].[procENET_Asset_File_Insert]
(
	@ast int,
	@afe int,
	@cby int,
	@sft int,
	@lic int
)
AS
INSERT INTO ASSET_FILE
(
	AssetId, 
	AssetFileExtensionId,
	CreatedBy,
	SoftwareId,
	SoftwareLicenseId
)
VALUES(
	@ast, 
	@afe,
	@cby,
	@sft,
	@lic
);
SELECT SCOPE_IDENTITY();

