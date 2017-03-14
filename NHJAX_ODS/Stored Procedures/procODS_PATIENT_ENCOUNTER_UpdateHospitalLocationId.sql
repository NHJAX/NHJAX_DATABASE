
create PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_UpdateHospitalLocationId]
(
	@id bigint,
	@loc bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ENCOUNTER
SET HospitalLocationId = @loc,
UpdatedDate = GETDATE()
WHERE (PatientEncounterId = @id)


