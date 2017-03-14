

create PROCEDURE [dbo].[procODS_PATIENT_UpdateHomePhone]
	@pat decimal,
	@ph varchar(10)

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		Phone = @ph,
		UpdatedDate = GetDate()
	WHERE PatientKey = @pat
END

