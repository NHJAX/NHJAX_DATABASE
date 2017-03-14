

create PROCEDURE [dbo].[procODS_PATIENT_UpdateZipCode]
	@pat decimal,
	@zip varchar(10)

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		ZipCode = @zip,
		UpdatedDate = GetDate()
	WHERE PatientKey = @pat
END

