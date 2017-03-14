CREATE PROCEDURE [dbo].[upTicketFeedbackInsert]
(
	@tik int,
	@sat bit,
	@com varchar(1000),
	@cby int,
	@feedid int OUT
)
AS
	BEGIN TRANSACTION
	
	INSERT INTO TICKET_FEEDBACK
	(
	TicketId,
	CustomerSatisfied,
	Comments,
	Createdby
	)
	VALUES
	(
	@tik,
	@sat,
	@com,
	@cby
	);
SET @feedid = SCOPE_IDENTITY();
	COMMIT TRANSACTION
