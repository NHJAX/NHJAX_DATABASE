CREATE PROCEDURE [dbo].[upTicketFeedbackFollowupSelect]
(
	@feed int
)

AS

SELECT     	FU.TicketFeedbackFollowUpId, 
		FU.Comments, 
		FU.AssignedTo, 
		TECH.UFName, 
		TECH.ULName, 
		TECH.UMName, 
		FU.StatusId, 
                      	TICKET_STATUS.StatusDesc, 
		FU.TicketFeedbackId, 
		FU.CreatedDate, 
		FU.UpdatedDate
FROM         	TICKET_FEEDBACK_FOLLOW_UP FU 
		INNER JOIN TICKET_STATUS 
		ON FU.StatusId = TICKET_STATUS.StatusId 
		LEFT OUTER JOIN TECHNICIAN TECH 
		ON FU.AssignedTo = TECH.UserId
WHERE	FU.TicketFeedbackId = @feed
