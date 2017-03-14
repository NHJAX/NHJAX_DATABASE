CREATE PROCEDURE [dbo].[upAssetPrinterSelect]
(
	@asset int,
	@prt int
)
AS
SELECT AssetPrinterId,
	AssetId,
	PrinterId,
	CreatedDate,
	CreatedBy,
	UpdatedDate,
	UpdatedBy,
	Inactive
	FROM ASSET_PRINTER
	WHERE AssetId = @asset
	AND PrinterId = @prt

