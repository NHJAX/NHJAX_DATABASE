
CREATE PROCEDURE [dbo].[procODS_DMIS_SelectbyKey]
(
	@key numeric(10,3)
)
AS
	SET NOCOUNT ON;
SELECT     
	DMISId,
	DMISKey,
	DMISCode,
	FacilityName,
	CreatedDate,
	UpdatedDate
FROM DMIS
WHERE (DMISKey = @key)
