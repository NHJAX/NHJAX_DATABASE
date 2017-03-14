

create PROCEDURE [dbo].[procODS_PATIENT_UpdateCity]
	@pat decimal,
	@city varchar(30)

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		City = @city,
		UpdatedDate = GetDate()
	WHERE PatientKey = @pat
END

