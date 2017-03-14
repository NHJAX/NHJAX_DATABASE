
CREATE PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_CleanDuplicate20120413]
(
	@pa numeric(14,3)
)
AS

DECLARE @good bigint
DECLARE @bad bigint
DECLARE @ref bigint

SET @bad = 0

SELECT @good = PatientEncounterId
FROM PATIENT_ENCOUNTER
WHERE PatientAppointmentKey = @pa
AND EncounterKey > 0

SELECT @bad = PatientEncounterId
FROM PATIENT_ENCOUNTER
WHERE PatientAppointmentKey = @pa
AND EncounterKey = 0

SELECT @ref = ReferralId
FROM PATIENT_ENCOUNTER
WHERE PatientAppointmentKey = @pa
AND EncounterKey = 0

--PRINT @good
--PRINT @bad
--PRINT @ref

UPDATE PATIENT_ENCOUNTER
SET ReferralId = @ref
WHERE PatientEncounterId = @good

DELETE FROM PATIENT_PROCEDURE
WHERE PatientEncounterId = @bad

UPDATE PATIENT_ORDER
SET PatientEncounterId = @good
WHERE PatientEncounterId = @bad

DELETE FROM ENCOUNTER_DIAGNOSIS
WHERE PatientEncounterId = @bad

DELETE FROM PATIENT_ENCOUNTER_DETAIL_CODE
WHERE PatientEncounterId = @bad

UPDATE APPOINTMENT_AUDIT_TRAIL
SET PatientEncounterId = @good
WHERE PatientEncounterId = @bad

IF (@bad > 0)
BEGIN
DELETE FROM PATIENT_ENCOUNTER
WHERE PatientEncounterId = @bad
END










