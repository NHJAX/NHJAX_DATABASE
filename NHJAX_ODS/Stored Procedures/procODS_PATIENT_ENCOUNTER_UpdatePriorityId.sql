
create PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_UpdatePriorityId]
(
	@id bigint,
	@pri bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ENCOUNTER
SET PriorityId = @pri,
UpdatedDate = GETDATE()
WHERE (PatientEncounterId = @id)


