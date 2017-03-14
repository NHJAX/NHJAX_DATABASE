create PROCEDURE [dbo].[upsessInvBaseDelete]
(
	@tech int
)
AS
DELETE     	
FROM         	sessINV_BASE
WHERE	CreatedBy = @tech

