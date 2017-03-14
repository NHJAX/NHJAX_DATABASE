
create PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_UpdateAppointmentTypeId]
(
	@id bigint,
	@atyp bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ENCOUNTER
SET AppointmentTypeId = @atyp,
UpdatedDate = GETDATE()
WHERE (PatientEncounterId = @id)


