
create PROCEDURE [dbo].[procENET_TICKET_ASSET_SelectByTicket]
(
	@tik int
)
AS
SELECT 
	TicketAssetId,
	TicketId,
	AssetId,
	CreatedDate
FROM TICKET_ASSET
WHERE TicketId = @tik





