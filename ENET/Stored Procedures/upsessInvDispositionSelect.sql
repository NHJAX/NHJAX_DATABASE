CREATE PROCEDURE [dbo].[upsessInvDispositionSelect]
(
	@tech int
)
AS
SELECT     	DispositionId 
FROM         	sessINV_DISPOSITION
WHERE	CreatedBy = @tech

