create PROCEDURE [dbo].[upsessInvBaseSelect]
(
	@tech int
)
AS
SELECT     	BaseId 
FROM         	sessINV_BASE
WHERE	CreatedBy = @tech

