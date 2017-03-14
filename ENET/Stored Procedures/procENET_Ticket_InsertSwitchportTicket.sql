create PROCEDURE [dbo].[procENET_Ticket_InsertSwitchportTicket]
(
	@datestr varchar(4),
	@prob int,
	@sys int,
	@sft int,
	@aud bigint,
	@comments text,
	@c4 int,
	@aby int,
	@adate datetime,
	@stat int,
	@cdate datetime,
	@cby int,
	@cust varchar(50),
	@odate datetime,
	@swtch int
	
)
AS
INSERT INTO TICKET
(
TicketNumber,
ProblemTypeId,
SystemNameId,
SoftwareId,
AudienceId,
Comments,
CreatedFor,
AssignedBy,
AssignedDate,
StatusId,
ClosedDate,
ClosedBy,
CustomerName,
OpenDate,
CreatedBy,
SwitchId
)
VALUES
(
dbo.NewTicketNumber(@datestr),
@prob,
@sys,
@sft,
@aud,
@comments,
@c4,
@aby,
@adate,
@stat,
@cdate,
@cby,
@cust,
@odate,
@cby,
@swtch
);
SELECT TicketId, TicketNumber FROM TICKET
WHERE TicketId = SCOPE_IDENTITY()


