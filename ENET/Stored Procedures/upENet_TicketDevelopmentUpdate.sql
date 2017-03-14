
create PROCEDURE [dbo].[upENet_TicketDevelopmentUpdate]
(
	@tic		int,
	@pri		int,
	@prob		int,
	@sys		int,
	@sft		int,
	@dept		int,
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
	DepartmentId = @dept,
	CustomerName = @cust,
	EstimatedHours = @est,
	Comments = @desc,
	UpdatedDate = @udate,
	UpdatedBy = @uby
WHERE TicketId = @tic

