

create PROCEDURE [dbo].[procODS_PATIENT_UpdatePatientCategoryIdbyID]
	@pat bigint,
	@cat bigint

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		PatientCategoryId = @cat,
		UpdatedDate = GetDate()
	WHERE PatientId = @pat
END

