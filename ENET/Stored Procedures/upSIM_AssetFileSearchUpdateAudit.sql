CREATE PROCEDURE [dbo].[upSIM_AssetFileSearchUpdateAudit]
(
	@ast int,
	@run int
)
AS

UPDATE ASSET_FILE_SEARCH
SET RunAudit = @run,
SearchAll = 0,
IncludeDefaults = 0,
UpdatedDate = getdate()
WHERE AssetId = @ast
