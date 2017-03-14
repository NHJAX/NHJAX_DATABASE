

create PROCEDURE [dbo].[procODS_PATIENT_UpdateDisplayAge]
	@pat decimal,
	@age varchar(15)

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		DisplayAge = @age,
		UpdatedDate = GetDate()
	WHERE PatientKey = @pat
END

