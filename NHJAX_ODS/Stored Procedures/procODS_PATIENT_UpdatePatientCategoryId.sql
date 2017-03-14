

create PROCEDURE [dbo].[procODS_PATIENT_UpdatePatientCategoryId]
	@pat decimal,
	@cat bigint

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		PatientCategoryId = @cat,
		UpdatedDate = GetDate()
	WHERE PatientKey = @pat
END

