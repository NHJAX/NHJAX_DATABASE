
CREATE PROCEDURE dbo.procCIP_DMIS_Select
	
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT 
		DMISId,
		DMISKey, 
		DMISCode, 
		FacilityName,
		CreatedDate,
		UpdatedDate
	FROM DMIS 
	WHERE (DMISCode 
	IN ('0039', '0266', '0275', '0276', '0277', '0337', '0405', '0517')) 
	ORDER BY DMISCode
END
