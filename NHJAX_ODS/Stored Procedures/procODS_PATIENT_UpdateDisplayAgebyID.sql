

create PROCEDURE [dbo].[procODS_PATIENT_UpdateDisplayAgebyID]
	@pat bigint,
	@age varchar(15)

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		DisplayAge = @age,
		UpdatedDate = GetDate()
	WHERE PatientId = @pat
END

