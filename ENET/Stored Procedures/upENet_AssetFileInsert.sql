CREATE PROCEDURE [dbo].[upENet_AssetFileInsert]
(
	@ast int,
	@afe int,
	@cby int,
	@sft int
)
AS
INSERT INTO ASSET_FILE
(
	AssetId, 
	AssetFileExtensionId,
	CreatedBy,
	SoftwareId
)
VALUES(
	@ast, 
	@afe,
	@cby,
	@sft
);
SELECT SCOPE_IDENTITY();

