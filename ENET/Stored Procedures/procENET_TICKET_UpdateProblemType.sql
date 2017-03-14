create PROCEDURE [dbo].[procENET_TICKET_UpdateProblemType]
(
	@tik int,
	@uby int,
	@prob int
)
AS
UPDATE TICKET SET
	ProblemTypeId = @prob,
	UpdatedBy = @uby,
	UpdatedDate = getdate()
WHERE TicketId = @tik;


