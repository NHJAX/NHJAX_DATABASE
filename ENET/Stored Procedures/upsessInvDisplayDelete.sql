CREATE PROCEDURE [dbo].[upsessInvDisplayDelete]
(
	@tech int
)
AS
DELETE     	
FROM         	sessINV_DISPLAY
WHERE	CreatedBy = @tech
