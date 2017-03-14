CREATE PROCEDURE [dbo].[upsessInvPOCDelete]
(
	@tech int
)
AS
DELETE     	
FROM         	sessINV_POC
WHERE	CreatedBy = @tech

