
create PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_UpdateDuration]
(
	@id bigint,
	@dur numeric(11,3)
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ENCOUNTER
SET Duration = @dur,
UpdatedDate = GETDATE()
WHERE (PatientEncounterId = @id)


