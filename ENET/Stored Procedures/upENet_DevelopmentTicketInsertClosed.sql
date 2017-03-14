
create PROCEDURE [dbo].[upENet_DevelopmentTicketInsertClosed]
(
	@datestr varchar(4),
	@pri int,
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
	@est decimal,
	@odate datetime
)
AS
INSERT INTO TICKET
(
TicketNumber,
PriorityId,
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
EstimatedHours,
OpenDate
)
VALUES
(
dbo.NewTicketNumber(@datestr),
@pri,
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
@est,
@odate
);
SELECT TicketId, TicketNumber FROM TICKET
WHERE TicketId = SCOPE_IDENTITY()

