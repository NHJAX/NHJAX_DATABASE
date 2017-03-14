
CREATE PROCEDURE [dbo].[procENet_Ticket_InsertDevelopmentTicket]
(
	@datestr varchar(4),
	@pri int,
	@prob int,
	@sys int,
	@sft int,
	@aud bigint,
	@comments text,
	@c4 int,
	@aby int,
	@adate datetime,
	@stat int,
	@cust varchar(50),
	@est decimal,
	@odate datetime,
	@cby int = 0
)
AS
INSERT INTO TICKET
(
TicketNumber,
PriorityId,
ProblemTypeId,
SystemNameId,
SoftwareId,
AudienceId,
Comments,
CreatedFor,
AssignedBy,
AssignedDate,
StatusId,
CustomerName,
EstimatedHours,
OpenDate,
CreatedBy
)
VALUES
(
dbo.NewTicketNumber(@datestr),
@pri,
@prob,
@sys,
@sft,
@aud,
@comments,
@c4,
@aby,
@adate,
@stat,
@cust,
@est,
@odate,
@cby
);
SELECT TicketId, TicketNumber FROM TICKET
WHERE TicketId = SCOPE_IDENTITY()



