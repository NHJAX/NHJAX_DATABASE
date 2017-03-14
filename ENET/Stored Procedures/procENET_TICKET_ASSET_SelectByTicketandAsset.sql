
CREATE PROCEDURE [dbo].[procENET_TICKET_ASSET_SelectByTicketandAsset]
(
	@tik int,
	@ast int
)
AS
SELECT 
	Count(TicketAssetId)
FROM TICKET_ASSET
WHERE TicketId = @tik
	AND AssetId = @ast





