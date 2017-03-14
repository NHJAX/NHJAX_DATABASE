
create PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_UpdateEncounterKey]
(
	@id bigint,
	@enc numeric(13,3)
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ENCOUNTER
SET EncounterKey = @enc,
UpdatedDate = GETDATE()
WHERE (PatientEncounterId = @id)


