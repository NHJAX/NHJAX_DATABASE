CREATE PROCEDURE [dbo].[procENET_TICKET_ASSIGNMENT_InsertExpress]
(
	@asgto int,
	@asgby int,
	@asgdt datetime,
	@clsdt datetime,
	@cby int,
	@tik int,
	@rem text,
	@hrs decimal(18,2)
)
AS
INSERT INTO TICKET_ASSIGNMENT
(
AssignedTo,
AssignedBy,
StatusId,
AssignmentDate,
ClosedDate,
ClosedBy,
TicketId,
Remarks,
[Hours]
)
VALUES
(
@asgto,
@asgby,
3,
@asgdt,
@clsdt,
@cby,
@tik,
@rem,
@hrs
);



