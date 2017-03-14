

create PROCEDURE [dbo].[procODS_PATIENT_UpdateZipCodebyID]
	@pat bigint,
	@zip varchar(10)

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		ZipCode = @zip,
		UpdatedDate = GetDate()
	WHERE PatientId = @pat
END

