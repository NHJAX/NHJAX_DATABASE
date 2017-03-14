
create PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_UpdateReleaseConditionId]
(
	@id bigint,
	@rc bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ENCOUNTER
SET ReleaseConditionId = @rc,
UpdatedDate = GETDATE()
WHERE (PatientEncounterId = @id)


