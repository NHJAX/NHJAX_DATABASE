

create PROCEDURE [dbo].[procODS_PATIENT_UpdateCitybyID]
	@pat bigint,
	@city varchar(30)

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		City = @city,
		UpdatedDate = GetDate()
	WHERE PatientId = @pat
END

