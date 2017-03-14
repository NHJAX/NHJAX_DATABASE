CREATE PROCEDURE [dbo].[upsessInvDisplaySelect]
(
	@tech int
)
AS
SELECT     	DisplayColumnId 
FROM         	sessINV_DISPLAY
WHERE	CreatedBy = @tech
