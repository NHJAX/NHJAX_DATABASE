
create PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_UpdatePatientDispositionId]
(
	@id bigint,
	@pd bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ENCOUNTER
SET PatientDispositionId = @pd,
UpdatedDate = GETDATE()
WHERE (PatientEncounterId = @id)


