CREATE PROCEDURE [dbo].[upENet_TicketUpdate]
(
	@tic		int,
	@prob		int,
	@sys		int,
	@sft		int,
	@dept		int,
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
	DepartmentId = @dept,
	CustomerName = @cust,
	Comments = @desc,
	UpdatedDate = @udate,
	UpdatedBy = @uby
WHERE TicketId = @tic
