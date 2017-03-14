
CREATE PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_SelectbyPatientAppointmentKey]
(
	@key numeric(14,3)
)
AS
	SET NOCOUNT ON;
SELECT     
	PatientEncounterId,
	PatientId,
	EncounterKey,
	AppointmentDateTime,
	HospitalLocationId,
	ProviderId,
	Duration,
	AppointmentStatusId,
	ReasonForAppointment,
	ArrivalCategoryId,
	PatientDispositionId,
	ReleaseDateTime,
	PriorityId,
	ReleaseConditionId,
	AppointmentTypeId,
	DMISId,
	MeprsCodeId,
	EREntryNumber
FROM PATIENT_ENCOUNTER
WHERE (PatientAppointmentKey = @key)
	
