
create PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_UpdateReasonForAppointment]
(
	@id bigint,
	@rea varchar(80)
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ENCOUNTER
SET ReasonForAppointment = @rea,
UpdatedDate = GETDATE()
WHERE (PatientEncounterId = @id)


