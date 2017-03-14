CREATE PROCEDURE [dbo].[procAIM_ASSET_COMPUTER_UpdateAimVersion]
(
	@ver varchar(10),
	@ast int
)
AS
UPDATE ASSET_COMPUTER 
SET
	AIMVersion = @ver,
	UpdatedDate = GETDATE()
WHERE AssetId = @ast

