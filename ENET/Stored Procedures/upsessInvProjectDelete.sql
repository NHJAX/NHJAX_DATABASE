CREATE PROCEDURE [dbo].[upsessInvProjectDelete]
(
	@tech int
)
AS
DELETE     	
FROM         	sessINV_PROJECT
WHERE	CreatedBy = @tech

