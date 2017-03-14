
CREATE PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_SelectbyKey]
(
	@key numeric(13,3)
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
WHERE (EncounterKey = @key)
	
