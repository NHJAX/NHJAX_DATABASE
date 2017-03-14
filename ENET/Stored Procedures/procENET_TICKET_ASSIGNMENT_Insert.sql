create PROCEDURE [dbo].[procENET_TICKET_ASSIGNMENT_Insert]
(
	@asgto int,
	@asgby int,
	@tik int,
	@rem text
)
AS
INSERT INTO TICKET_ASSIGNMENT
(
AssignedTo,
AssignedBy,
TicketId,
Remarks
)
VALUES
(
@asgto,
@asgby,
@tik,
@rem
);



