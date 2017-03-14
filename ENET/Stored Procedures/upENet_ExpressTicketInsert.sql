CREATE PROCEDURE [dbo].[upENet_ExpressTicketInsert]
(
	@datestr varchar(4),
	@prob int,
	@sys int,
	@sft int,
	@dept int,
	@comments text,
	@c4 int,
	@aby int,
	@adate datetime,
	@stat int,
	@cdate datetime,
	@cby int,
	@cust varchar(50),
	@odate datetime
)
AS
INSERT INTO TICKET
(
TicketNumber,
ProblemTypeId,
SystemNameId,
SoftwareId,
DepartmentId,
Comments,
CreatedFor,
AssignedBy,
AssignedDate,
StatusId,
ClosedDate,
ClosedBy,
CustomerName,
OpenDate
)
VALUES
(
dbo.NewTicketNumber(@datestr),
@prob,
@sys,
@sft,
@dept,
@comments,
@c4,
@aby,
@adate,
@stat,
@cdate,
@cby,
@cust,
@odate
);
SELECT TicketId, TicketNumber FROM TICKET
WHERE TicketId = SCOPE_IDENTITY()
