
create PROCEDURE [dbo].[procODS_PATIENT_ADMISSION_UpdateEncounter]
(
	@adm bigint,
	@enc numeric(13,3)
)
AS
	SET NOCOUNT ON;
	
UPDATE PATIENT_ADMISSION
SET EncounterKey = @enc,
	UpdatedDate = Getdate()
WHERE PatientAdmissionId = @adm;

