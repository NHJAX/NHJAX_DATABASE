CREATE PROCEDURE [dbo].[upTicketFeedbackFollowupUpdate]
(
	@fbk int,
	@usr int,
	@stat int,
	@com varchar(2000),
	@uby int
)
AS
	BEGIN TRANSACTION
	
	UPDATE TICKET_FEEDBACK_FOLLOW_UP
	SET
		AssignedTo = @usr,
		StatusId = @stat,
		Comments = @com,
		UpdatedBy = @uby,
		UpdatedDate = getdate()
	WHERE 
		TicketFeedbackId = @fbk;
	
	COMMIT TRANSACTION
