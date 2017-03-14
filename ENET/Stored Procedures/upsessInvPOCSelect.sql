CREATE PROCEDURE [dbo].[upsessInvPOCSelect]
(
	@tech int
)
AS
SELECT     	POCId 
FROM         	sessINV_POC
WHERE	CreatedBy = @tech

