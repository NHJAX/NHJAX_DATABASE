
create PROCEDURE [dbo].[procODS_HOSPITAL_LOCATION_SelectNONNHJAX]

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
	 SourceSystemId = 13
ORDER BY HOSP.HospitalLocationName
