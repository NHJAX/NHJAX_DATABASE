
create PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_UpdateArrivalCategoryId]
(
	@id bigint,
	@ac bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ENCOUNTER
SET ArrivalCategoryId = @ac,
UpdatedDate = GETDATE()
WHERE (PatientEncounterId = @id)


