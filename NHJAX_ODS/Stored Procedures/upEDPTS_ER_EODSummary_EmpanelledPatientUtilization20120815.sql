
create PROCEDURE [dbo].[upEDPTS_ER_EODSummary_EmpanelledPatientUtilization20120815]
(
	@Date		smalldatetime
)
WITH RECOMPILE 
AS
SELECT COUNT(DISTINCT PAT.PatientId) AS EmpanelledPatients, 
	(SELECT COUNT(DISTINCT EOD.PatientId)
	FROM [nhjax-sql2].EDPTS.dbo.ER_EOD_Summary EOD 
	INNER JOIN
	PATIENT AS PAT
	ON EOD.PatientId = PAT.PatientKey
	INNER JOIN
	PRIMARY_CARE_MANAGER PCM 
	ON PAT.PatientId = PCM.PatientId
	INNER JOIN PROVIDER PRO 
	ON PCM.ProviderId = PRO.ProviderId
	LEFT OUTER JOIN HOSPITAL_LOCATION LOC 
	ON PRO.LocationId = LOC.HospitalLocationId
	WHERE LOC.HospitalLocationId = HOSP.HospitalLocationId 
	AND Month(EOD.CheckIn)=Month(@Date) 
	AND Year(EOD.CheckIn)=Year(@Date)) AS ERVisits,
HOSP.HospitalLocationName AS Clinic
FROM PATIENT PAT
INNER JOIN PRIMARY_CARE_MANAGER PCM
ON PAT.PatientId = PCM.PatientId
INNER JOIN PROVIDER PRO 
ON PCM.ProviderId = PRO.ProviderId
LEFT OUTER JOIN HOSPITAL_LOCATION HOSP 
ON PRO.LocationId = HOSP.HospitalLocationId
WHERE HOSP.HospitalLocationName IN (
	'PEDIATRICS', 
	'FAMILY PRACTICE CLINIC', 
	'PRIMARY CARE GROUP CLINIC',
	'MAYPORT BRANCH CLINIC', 
	'KINGS BAY') 
	OR HOSP.HospitalLocationName LIKE 'MAY%' 
	OR HOSP.HospitalLocationName LIKE 'KB%' 
	OR HOSP.HospitalLocationName LIKE 'JAX%'
GROUP BY HOSP.HospitalLocationName,HOSP.HospitalLocationId
ORDER BY Clinic
