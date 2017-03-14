
create PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_UpdateMeprsId]
(
	@id bigint,
	@mep bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ENCOUNTER
SET MeprsCodeId = @mep,
UpdatedDate = GETDATE()
WHERE (PatientEncounterId = @id)


