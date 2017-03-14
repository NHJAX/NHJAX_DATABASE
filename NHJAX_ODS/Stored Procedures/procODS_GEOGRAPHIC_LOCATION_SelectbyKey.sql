
create PROCEDURE [dbo].[procODS_GEOGRAPHIC_LOCATION_SelectbyKey]
(
	@key numeric(9,3)
)
AS
	SET NOCOUNT ON;
SELECT     
	GeographicLocationId,
	GeographicLocationKey,
	GeographicLocationAbbrev,
	GeographicLocationDesc,
	CreatedDate,
	UpdatedDate
FROM GEOGRAPHIC_LOCATION
WHERE (GeographicLocationKey = @key)
