
create PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_UpdateEREntryNumber]
(
	@id bigint,
	@etr varchar(30)
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ENCOUNTER
SET EREntryNumber = @etr,
UpdatedDate = GETDATE()
WHERE (PatientEncounterId = @id)


