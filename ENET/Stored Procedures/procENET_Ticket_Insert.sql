CREATE PROCEDURE [dbo].[procENET_Ticket_Insert]
(
	@datestr varchar(4),
	@prob int,
	@sys int,
	@impact bit,
	@pacct varchar(50),
	@sft int,
	@aud bigint,
	@loc varchar(50),
	@comments text = '',
	@user int,
	@open datetime,
	@cust varchar(50),
	@cby int = 0,
	@swtch int = 0
)
AS
INSERT INTO TICKET
(
TicketNumber,
ProblemTypeId,
SystemNameId,
PatientImpact,
PlantAccountNum,
SoftwareId,
AudienceId,
TicketLocation,
Comments,
CreatedFor,
OpenDate,
CustomerName,
CreatedBy,
SwitchId
)
VALUES
(
dbo.NewTicketNumber(@datestr),
@prob,
@sys,
@impact,
@pacct,
@sft,
@aud,
@loc,
@comments,
@user,
@open,
@cust,
@cby,
@swtch
);
SELECT TicketId, TicketNumber FROM TICKET
WHERE TicketId = SCOPE_IDENTITY()


