CREATE PROCEDURE [dbo].[upTicketFeedbackFollowupInsert]
(
	@fbk int,
	@usr int,
	@stat int,
	@com varchar(2000),
	@cby int,
	@uby int
)
AS
	BEGIN TRANSACTION
	
	INSERT INTO TICKET_FEEDBACK_FOLLOW_UP
	(
	TicketFeedbackId,
	AssignedTo,
	StatusId,
	Comments,
	Createdby,
	UpdatedBy
	)
	VALUES
	(
	@fbk,
	@usr,
	@stat,
	@com,
	@cby,
	@uby
	);

	COMMIT TRANSACTION
