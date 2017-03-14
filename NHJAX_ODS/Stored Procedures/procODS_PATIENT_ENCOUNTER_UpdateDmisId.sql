
create PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_UpdateDmisId]
(
	@id bigint,
	@dmis bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ENCOUNTER
SET DmisId = @dmis,
UpdatedDate = GETDATE()
WHERE (PatientEncounterId = @id)


