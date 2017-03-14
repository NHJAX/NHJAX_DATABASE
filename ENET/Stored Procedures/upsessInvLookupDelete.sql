CREATE PROCEDURE [dbo].[upsessInvLookupDelete]
(
	@tech int
)
AS
DELETE     	
FROM         	sessINV_LOOKUP
WHERE	CreatedBy = @tech

