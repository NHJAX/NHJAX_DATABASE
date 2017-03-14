create PROCEDURE [dbo].[procENET_sessInvAudience_Select]
(
	@tech int
)
AS
SELECT     	AudienceId 
FROM         	sessINV_AUDIENCE
WHERE	CreatedBy = @tech



