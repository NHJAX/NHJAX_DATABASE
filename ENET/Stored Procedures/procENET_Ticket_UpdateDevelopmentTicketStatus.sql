
create PROCEDURE [dbo].[procENET_Ticket_UpdateDevelopmentTicketStatus]
(
	@tic		int,
	@pri		int,
	@prob		int,
	@sys		int,
	@sft		int,
	@aud		bigint,
	@cust		varchar(50),
	@est		decimal,
	@desc		text,
	@udate		datetime,
	@uby		int
)
 AS

UPDATE TICKET
	SET PriorityId = @pri,
	ProblemTypeId = @prob,
	SystemNameId = @sys,
	SoftwareId = @sft,
	AudienceId = @aud,
	CustomerName = @cust,
	EstimatedHours = @est,
	Comments = @desc,
	UpdatedDate = @udate,
	UpdatedBy = @uby,
	StatusId = 3,
	ClosedBy = @uby,
	ClosedDate = @udate
WHERE TicketId = @tic



