
create PROCEDURE [dbo].[procODS_GEOGRAPHIC_LOCATION_Insert]
(
	@key numeric(9,3),
	@abv varchar(5),
	@desc varchar(50)
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.GEOGRAPHIC_LOCATION
(
	GeographicLocationKey,
	GeographicLocationAbbrev,
	GeographicLocationDesc
) 
VALUES
(
	@key, 
	@abv,
	@desc
);
SELECT SCOPE_IDENTITY();