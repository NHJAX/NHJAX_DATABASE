
CREATE PROCEDURE [dbo].[upODS_DM_CIP_Encounter] AS

Declare @fromDate datetime
Declare @tempDate datetime
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin DM CIP Encounters',0,@day;
SET @tempDate = DATEADD(d,-180,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 

BEGIN
DELETE FROM CIP.dbo.DM_CIP_ENCOUNTER
WHERE AppointmentDateTime >= @fromDate

INSERT INTO CIP.dbo.DM_CIP_ENCOUNTER
(
	HospitalLocationId, 
	PatientEncounterId, 
	AppointmentStatusId, 
	AppointmentDateTime, 
	ProviderId,
	SourceSystemId,
	DmisId,
	AppointmentTypeid,
	AppointmentTypeDesc,
	Duration
)
SELECT DISTINCT		
	LOC.HospitalLocationId, 
	APP.PatientEncounterId, 
	APP.AppointmentStatusId, 
	APP.AppointmentDateTime, 
	APP.ProviderId,
	APP.SourceSystemId,
	MPR.DmisId,
	ISNULL(ATYP.AppointmentTypeId,0) AS AppointmentTypeId,
	ISNULL(ATYP.AppointmentTypeDesc,'UNKNOWN') AS AppointmentTypeDesc,
	ISNULL(APP.Duration,1) AS Duration
FROM         
	HOSPITAL_LOCATION AS LOC 
	INNER JOIN PATIENT_ENCOUNTER AS APP 
	ON APP.HospitalLocationId = LOC.HospitalLocationId 
	INNER JOIN PROVIDER AS PRO 
	ON PRO.ProviderId = APP.ProviderId 
	INNER JOIN MEPRS_CODE AS MPR 
	ON MPR.MeprsCodeId = LOC.MeprsCodeId
	LEFT OUTER JOIN APPOINTMENT_TYPE AS ATYP
	ON APP.AppointmentTypeId = ATYP.AppointmentTypeId
WHERE     (PRO.ProviderFlag = '1')
AND		(LOC.HospitalLocationName NOT LIKE 'QQQ%')
AND		(APP.SourceSystemId < 5)
AND     (APP.AppointmentDateTime >= @fromDate) 
END

EXEC dbo.upActivityLog 'Update DM CIP Encounter CPT',0;
BEGIN
DELETE FROM CIP.dbo.DM_CIP_ENCOUNTER_CPT
WHERE AppointmentDateTime >= @fromDate

INSERT INTO CIP.dbo.DM_CIP_ENCOUNTER_CPT
(
	PatientEncounterId,  
	AppointmentDateTime,
	CptId,
	CptCode,
	CptTypeId,
	CptRvu
)
SELECT 
	ENC.PatientEncounterId, 
	ENC.AppointmentDateTime, 
	CPT.CptId, 
	CPT.CptCode, 
	CPT.CptTypeId, 
	CPT.RVU
FROM
	CPT 
	INNER JOIN PATIENT_PROCEDURE 
	ON CPT.CptId = PATIENT_PROCEDURE.CptId 
	INNER JOIN CIP.dbo.DM_CIP_ENCOUNTER AS ENC
	ON PATIENT_PROCEDURE.PatientEncounterId = ENC.PatientEncounterId
WHERE	(ENC.AppointmentDateTime >= @fromDate) 
END

EXEC dbo.upActivityLog 'Update DM CIP Encounter DIAG',0;
BEGIN
DELETE FROM CIP.dbo.DM_CIP_ENCOUNTER_DIAG
WHERE AppointmentDateTime >= @fromDate

INSERT INTO CIP.dbo.DM_CIP_ENCOUNTER_DIAG
(
	PatientEncounterId,  
	AppointmentDateTime,
	DiagnosisId,
	DiagnosisCode,
	DiagnosisType
) 
	SELECT 
	ENC.PatientEncounterId, 
	ENC.AppointmentDateTime,
	DIAGNOSIS.DiagnosisId, 
	DIAGNOSIS.DiagnosisCode, 
	DIAGNOSIS.DiagnosisType
FROM         
	DIAGNOSIS 
	INNER JOIN ENCOUNTER_DIAGNOSIS 
	ON DIAGNOSIS.DiagnosisId = ENCOUNTER_DIAGNOSIS.DiagnosisId 
	INNER JOIN CIP.dbo.DM_CIP_ENCOUNTER AS ENC 
	ON ENCOUNTER_DIAGNOSIS.PatientEncounterId = ENC.PatientEncounterId
WHERE	(ENC.AppointmentDateTime >= @fromDate) 
END

EXEC dbo.upActivityLog 'Update DM CIP Encounter DTL CODE',0;
BEGIN
DELETE FROM CIP.dbo.DM_CIP_ENCOUNTER_DTL_CODE
WHERE AppointmentDateTime >= @fromDate

INSERT INTO CIP.dbo.DM_CIP_ENCOUNTER_DTL_CODE
(
	PatientEncounterId,  
	AppointmentDateTime,
	AppointmentDetailId,
	AppointmentDetailCode
) 
	SELECT     
		ENC.PatientEncounterId, 
	ENC.AppointmentDateTime, 
	APPOINTMENT_DETAIL_CODE.AppointmentDetailId, 
	APPOINTMENT_DETAIL_CODE.AppointmentDetailCode
FROM
	PATIENT_ENCOUNTER_DETAIL_CODE 
	INNER JOIN APPOINTMENT_DETAIL_CODE 
	ON  PATIENT_ENCOUNTER_DETAIL_CODE.AppointmentDetailId = APPOINTMENT_DETAIL_CODE.AppointmentDetailId 
	INNER JOIN CIP.dbo.DM_CIP_ENCOUNTER AS ENC
	ON PATIENT_ENCOUNTER_DETAIL_CODE.PatientEncounterId = ENC.PatientEncounterId
WHERE	(ENC.AppointmentDateTime >= @fromDate) 
END

EXEC dbo.upActivityLog 'End DM CIP Encounter',0,@day;















