
create PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_UpdateProviderId]
(
	@id bigint,
	@pro bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ENCOUNTER
SET ProviderId = @pro,
UpdatedDate = GETDATE()
WHERE (PatientEncounterId = @id)


