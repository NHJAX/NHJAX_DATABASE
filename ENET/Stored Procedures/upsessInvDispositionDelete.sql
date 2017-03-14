CREATE PROCEDURE [dbo].[upsessInvDispositionDelete]
(
	@tech int
)
AS
DELETE     	
FROM         	sessINV_DISPOSITION
WHERE	CreatedBy = @tech

