CREATE PROCEDURE [dbo].[upAssetPrinterInsert]
(
	@asset int,
	@prt int,
	@cby int,
	@uby int
)
AS
INSERT INTO ASSET_PRINTER
(
AssetId, 
PrinterId, 
CreatedBy, 
UpdatedBy
)
VALUES
(
@asset, 
@prt, 
@cby, 
@uby
)

