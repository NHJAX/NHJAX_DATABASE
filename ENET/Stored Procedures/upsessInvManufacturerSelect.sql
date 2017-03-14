CREATE PROCEDURE [dbo].[upsessInvManufacturerSelect]
(
	@tech int
)
AS
SELECT     	ManufacturerId 
FROM         	sessINV_MANUFACTURER 
WHERE	CreatedBy = @tech

