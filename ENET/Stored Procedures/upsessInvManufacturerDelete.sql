CREATE PROCEDURE [dbo].[upsessInvManufacturerDelete]
(
	@tech int
)
AS
DELETE     	
FROM         	sessINV_MANUFACTURER
WHERE	CreatedBy = @tech

