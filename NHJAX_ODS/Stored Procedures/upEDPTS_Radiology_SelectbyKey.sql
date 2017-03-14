

CREATE PROCEDURE [dbo].[upEDPTS_Radiology_SelectbyKey]
	@rad decimal
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT RadiologyKey,
	RadiologyDesc,
	UpdatedDate
	FROM RADIOLOGY
	WHERE RadiologyKey = @rad
END


