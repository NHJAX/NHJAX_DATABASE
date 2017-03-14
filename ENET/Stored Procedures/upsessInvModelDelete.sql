CREATE PROCEDURE [dbo].[upsessInvModelDelete]
(
	@tech int
)
AS
DELETE     	
FROM         	sessINV_MODEL
WHERE	CreatedBy = @tech

