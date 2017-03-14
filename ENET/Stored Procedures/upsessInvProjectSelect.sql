CREATE PROCEDURE [dbo].[upsessInvProjectSelect]
(
	@tech int
)
AS
SELECT     	ProjectId 
FROM         	sessINV_PROJECT
WHERE	CreatedBy = @tech

