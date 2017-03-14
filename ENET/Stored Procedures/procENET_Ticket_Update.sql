create PROCEDURE [dbo].[procENET_Ticket_Update]
(
	@tic		int,
	@prob		int,
	@sys		int,
	@sft		int,
	@aud		bigint,
	@cust		varchar(50),
	@desc		text,
	@udate		datetime,
	@uby		int
)
 AS

UPDATE TICKET
	SET ProblemTypeId = @prob,
	SystemNameId = @sys,
	SoftwareId = @sft,
	AudienceId = @aud,
	CustomerName = @cust,
	Comments = @desc,
	UpdatedDate = @udate,
	UpdatedBy = @uby
WHERE TicketId = @tic


