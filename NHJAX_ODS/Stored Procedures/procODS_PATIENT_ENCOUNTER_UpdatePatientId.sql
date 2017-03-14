
create PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_UpdatePatientId]
(
	@id bigint,
	@pat bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ENCOUNTER
SET PatientId = @pat,
UpdatedDate = GETDATE()
WHERE (PatientEncounterId = @id)


