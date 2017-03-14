
CREATE PROCEDURE [dbo].[procCIP_HOSPITAL_LOCATION_SelectbyDmisId]
(
	@dmis bigint
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
	HOSP.UpdatedDate
FROM
	HOSPITAL_LOCATION AS HOSP 
	INNER JOIN MEPRS_CODE AS MEP
	ON HOSP.MeprsCodeId = MEP.MeprsCodeId 
WHERE 	
	(MEP.DmisId = @dmis)
	AND NOT (MEP.MEPRSCODE LIKE 'A%' 
	OR MEP.MEPRSCODE LIKE 'E%' 
	OR MEP.MEPRSCODE LIKE 'D%' 
	OR MEP.MEPRSCODE LIKE '%5')
	AND HOSP.HospitalLocationName NOT LIKE 'QQQ%'
ORDER BY HOSP.HospitalLocationName;
 /*OR MEP.MEPRSCODE LIKE 'C%'*/
