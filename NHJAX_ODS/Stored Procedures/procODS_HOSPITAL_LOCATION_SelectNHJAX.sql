
CREATE PROCEDURE [dbo].[procODS_HOSPITAL_LOCATION_SelectNHJAX]

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
	INNER JOIN MEPRS_CODE AS MEP
	ON HOSP.MeprsCodeId = MEP.MeprsCodeId
WHERE 	
	(MEP.DmisId IN(1664,1740,1527,1698,1665,1659,1811))
	AND (HOSP.HospitalLocationName NOT LIKE 'ZZ%')
	AND (HOSP.HospitalLocationId NOT IN (2087,1742,522,523,1934))
ORDER BY HOSP.HospitalLocationName
