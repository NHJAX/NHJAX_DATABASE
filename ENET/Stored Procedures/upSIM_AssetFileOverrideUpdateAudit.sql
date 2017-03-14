CREATE PROCEDURE [dbo].[upSIM_AssetFileOverrideUpdateAudit]
(
	@ast int
)
AS

UPDATE ASSET_FILE_OVERRIDE
SET AuditOverride = 0,
UpdatedDate = getdate()
WHERE AssetId = @ast
AND AuditOverride = 1
