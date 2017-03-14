
CREATE PROCEDURE [dbo].[procODS_HOSPITAL_LOCATION_SelectbyName]
(
	@name varchar(31)
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
	(HOSP.HospitalLocationName = @name)
