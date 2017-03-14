CREATE PROCEDURE [dbo].[upENet_TicketInsert]
(
	@datestr varchar(4),
	@prob int,
	@sys int,
	@impact bit,
	@pacct varchar(50),
	@sft int,
	@dept int,
	@loc varchar(50),
	@comments text,
	@user int,
	@open datetime,
	@cust varchar(50)
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
DepartmentId,
TicketLocation,
Comments,
CreatedFor,
OpenDate,
CustomerName
)
VALUES
(
dbo.NewTicketNumber(@datestr),
@prob,
@sys,
@impact,
@pacct,
@sft,
@dept,
@loc,
@comments,
@user,
@open,
@cust
);
SELECT TicketId, TicketNumber FROM TICKET
WHERE TicketId = SCOPE_IDENTITY()
