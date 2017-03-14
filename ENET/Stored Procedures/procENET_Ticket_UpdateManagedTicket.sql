
create PROCEDURE [dbo].[procENET_Ticket_UpdateManagedTicket]
(
	@tic		int,
	@prob		int,
	@sys		int,
	@sft		int,
	@aud		bigint,
	@cust		varchar(50),
	@loc		varchar(50),
	@uby		int
)
 AS

UPDATE TICKET
	SET ProblemTypeId = @prob,
	SystemNameId = @sys,
	SoftwareId = @sft,
	AudienceId = @aud,
	CustomerName = @cust,
	TicketLocation = @loc,
	UpdatedDate = getdate(),
	UpdatedBy = @uby
WHERE TicketId = @tic



