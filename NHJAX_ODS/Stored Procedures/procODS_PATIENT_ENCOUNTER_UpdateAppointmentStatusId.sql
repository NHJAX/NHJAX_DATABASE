
create PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_UpdateAppointmentStatusId]
(
	@id bigint,
	@astt bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ENCOUNTER
SET AppointmentStatusId = @astt,
UpdatedDate = GETDATE()
WHERE (PatientEncounterId = @id)


