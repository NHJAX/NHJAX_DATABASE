
create PROCEDURE [dbo].[procENET_TICKET_ASSET_Insert]
(
	@tik int,
	@ast int
)
AS
INSERT INTO TICKET_ASSET
(
TicketId,
AssetId
)
VALUES
(
@tik,
@ast
)



