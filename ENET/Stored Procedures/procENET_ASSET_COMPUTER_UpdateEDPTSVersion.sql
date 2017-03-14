create PROCEDURE [dbo].[procENET_ASSET_COMPUTER_UpdateEDPTSVersion]

(
	@ast		int,
	@ver		varchar(10)
)
 AS

UPDATE ASSET_COMPUTER SET
	EDPTSVersion = @ver
WHERE AssetId = @ast


