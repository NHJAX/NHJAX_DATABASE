
CREATE PROCEDURE [dbo].[procODS_HOSPITAL_LOCATION_SelectbyKey]
(
	@key numeric(12,4)
)
AS
	SET NOCOUNT ON;
SELECT 	
	HOSP.HospitalLocationId,
	HOSP.HospitalLocationKey, 
	HOSP.HospitalLocationName,
	HOSP.HospitalLocationDesc,
	HOSP.MeprsCodeId,
	HOSP.CreatedDate,
	HOSP.UpdatedDate,
	HOSP.MedicalCenterDivisionId
FROM
	HOSPITAL_LOCATION AS HOSP 
WHERE 	
	(HOSP.HospitalLocationKey = @key)
