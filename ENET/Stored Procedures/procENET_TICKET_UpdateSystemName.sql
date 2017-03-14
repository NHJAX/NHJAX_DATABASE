create PROCEDURE [dbo].[procENET_TICKET_UpdateSystemName]
(
	@tik int,
	@uby int,
	@sys int
)
AS
UPDATE TICKET SET
	SystemNameId = @sys,
	UpdatedBy = @uby,
	UpdatedDate = getdate()
WHERE TicketId = @tik;


