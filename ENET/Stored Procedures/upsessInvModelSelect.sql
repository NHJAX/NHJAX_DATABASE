CREATE PROCEDURE [dbo].[upsessInvModelSelect]
(
	@tech int
)
AS
SELECT     	ModelId 
FROM         	sessINV_MODEL
WHERE	CreatedBy = @tech

