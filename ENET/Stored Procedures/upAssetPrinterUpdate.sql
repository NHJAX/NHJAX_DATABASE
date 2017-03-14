CREATE PROCEDURE [dbo].[upAssetPrinterUpdate]
(
	@inactive bit,
	@udate datetime,
	@uby int,
	@asset int,
	@prt int
)
AS
UPDATE ASSET_PRINTER SET
	Inactive = @inactive,
	UpdatedDate = @udate,
	UpdatedBy = @uby
WHERE AssetId = @asset
	AND PrinterId = @prt

