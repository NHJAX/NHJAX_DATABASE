CREATE PROCEDURE [dbo].[upSessionDisplayListSelect]
AS
SELECT     	SessionDisplayListId,
		SessionDisplayListDesc,
		IsNotDisplayed
FROM         	SESSION_DISPLAY_LIST
WHERE 	IsNotDisplayed = 0

