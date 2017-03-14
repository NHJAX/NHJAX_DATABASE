

create PROCEDURE [dbo].[procODS_RADIOLOGY_SelectbyKey]
	@key decimal
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT 
		RadiologyId,
		RadiologyKey,
		RadiologyDesc,
		UpdatedDate
	FROM RADIOLOGY
	WHERE RadiologyKey = @key
END


