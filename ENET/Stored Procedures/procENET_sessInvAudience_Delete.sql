create PROCEDURE [dbo].[procENET_sessInvAudience_Delete]
(
	@tech int
)
AS
DELETE     	
FROM         	sessINV_AUDIENCE
WHERE	CreatedBy = @tech



