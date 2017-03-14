
create PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_UpdateReleaseDateTime]
(
	@id bigint,
	@rel datetime
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ENCOUNTER
SET ReleaseDateTime = @rel,
UpdatedDate = GETDATE()
WHERE (PatientEncounterId = @id)


