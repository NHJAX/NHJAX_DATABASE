
create PROCEDURE [dbo].[procENET_TICKET_ASSET_Delete]
(
	@tik int
)
AS
DELETE FROM TICKET_ASSET
WHERE TicketId = @tik




