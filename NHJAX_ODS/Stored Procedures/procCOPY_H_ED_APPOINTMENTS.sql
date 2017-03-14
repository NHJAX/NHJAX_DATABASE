
CREATE PROCEDURE [dbo].[procCOPY_H_ED_APPOINTMENTS]

AS

TRUNCATE TABLE ODS_COPY.dbo.H_ED_APPOINTMENTS

DECLARE @sdate datetime
DECLARE @edate datetime

SET @sdate = dbo.StartOfDay('2014-01-01')
SET @edate = dbo.EndOfDay(GETDATE())

INSERT INTO ODS_COPY.dbo.H_ED_APPOINTMENTS
(
	PatientId,
	FMP_SSN,
	PatientIdentifier,
	AppointmentKey,
	AppointmentDateTime,
	ProviderName,
	HCPSpecialty,
	SourceSystem,
	AppointmentType,
	AppointmentStatus,
	ClinicName,
	BookedDateTime,
	ReasonForAppointment,
	ReferralKey,
	AppointmentComment,
	CancelDateTime,
	CanceldPersonName,
	Duration,
	CancelReason
)
SELECT 
	PATIENT.PatientId,
	FMP.FamilyMemberPrefixCode + '/' + PATIENT.SponsorSSN,
	PATIENT.PatientIdentifier,
	ENC.PatientAppointmentKey,
	ENC.AppointmentDateTime,
	PROVIDER.ProviderName,
	PSPEC.ProviderSpecialtyDesc,
	SS.DisplayName,
	ATYP.AppointmentTypeDesc,
	STAT.AppointmentStatusDesc,
	LOC.HospitalLocationName,
	ENC.DateAppointmentMade,
	ENC.ReasonForAppointment,
	REF.ReferralKey,
	ENC.AppointmentComment,
	ENC.CancellationDateTime,
	USR.CHCSUserName,
	ENC.Duration,
	CAN.PatientCancelledReasonDesc
FROM PATIENT_ENCOUNTER AS ENC
INNER JOIN PATIENT
ON ENC.PatientId = PATIENT.PatientId
INNER JOIN FAMILY_MEMBER_PREFIX AS FMP
ON PATIENT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId
LEFT OUTER JOIN PROVIDER
ON PROVIDER.ProviderId = ENC.ProviderId 
LEFT OUTER JOIN SPECIALTY AS SPEC
ON PROVIDER.ProviderId = SPEC.ProviderId
LEFT OUTER JOIN PROVIDER_SPECIALTY AS PSPEC
ON SPEC.ProviderSpecialtyId = PSPEC.ProviderSpecialtyId
INNER JOIN SOURCE_SYSTEM AS SS
ON ENC.SourceSystemId = SS.SourceSystemId
INNER JOIN APPOINTMENT_TYPE AS ATYP
ON ENC.AppointmentTypeId = ATYP.AppointmentTypeId
INNER JOIN APPOINTMENT_STATUS AS STAT
ON ENC.AppointmentStatusId = STAT.AppointmentStatusId
LEFT JOIN HOSPITAL_LOCATION AS LOC
ON ENC.HospitalLocationId = LOC.HospitalLocationId
LEFT OUTER JOIN REFERRAL AS REF
ON ENC.ReferralId = REF.ReferralId
LEFT OUTER JOIN PATIENT_CANCELLED_REASON AS CAN
ON ENC.PatientCancelledReasonId = CAN.PatientCancelledReasonId
LEFT OUTER JOIN CHCS_USER AS USR
ON ENC.CancelledBy = USR.CHCSUserId
WHERE ENC.PatientId IN (SELECT PatientId FROM ODS_COPY.dbo.B_ED_PATIENT)
AND ENC.AppointmentDateTime BETWEEN '2013-12-24' AND GETDATE()

DECLARE @enc bigint
DECLARE @app numeric(14,3)
DECLARE @diag varchar(1000)
DECLARE @dia varchar(250)
DECLARE @diagX varchar(1000)
DECLARE @diaX varchar(250)

DECLARE cur1 CURSOR FAST_FORWARD FOR
SELECT   DISTINCT  
	ENC.PatientEncounterId,
	APP.AppointmentKey
FROM ODS_COPY.dbo.H_ED_APPOINTMENTS  AS APP
INNER JOIN NHJAX_ODS.dbo.PATIENT_ENCOUNTER AS ENC
ON APP.AppointmentKey = ENC.PatientAppointmentKey
where APP.AppointmentKey > 0

OPEN cur1

FETCH NEXT FROM cur1 INTO @enc,@app

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
			DECLARE cur2 CURSOR FAST_FORWARD FOR
			SELECT 
			EDIAG.[DESCRIPTION],DIAG.DiagnosisKey
			FROM NHJAX_ODS.dbo.ENCOUNTER_DIAGNOSIS AS EDIAG
			INNER JOIN NHJAX_ODS.dbo.DIAGNOSIS AS DIAG
			ON EDIAG.DiagnosisId = DIAG.DiagnosisId
			WHERE PatientEncounterId= @enc
			
			OPEN cur2

			FETCH NEXT FROM cur2 INTO @dia, @diaX
					
			WHILE(@@FETCH_STATUS = 0)
			BEGIN
				SET @diag = @diag + ' | ' + @dia
				SET @diagX = @diagX + ' | ' + @diaX
			
			FETCH NEXT FROM cur2 INTO @dia, @diaX
			
			END
			CLOSE cur2
			DEALLOCATE cur2
			
			
			UPDATE ODS_COPY.dbo.H_ED_APPOINTMENTS
			SET 
			ICD9Codes = @diag
			WHERE AppointmentKey = @app;
			
			UPDATE ODS_COPY.dbo.H_ED_APPOINTMENTS
			SET 
			ICD9Keys = @diagX
			WHERE AppointmentKey = @app;
			
			SET @diag = ''
			SET @dia = ''
			SET @diaX = ''
			SET @diagX = ''
	FETCH NEXT FROM cur1 INTO @enc,@app
	
	COMMIT	
	END
END
CLOSE cur1
DEALLOCATE cur1