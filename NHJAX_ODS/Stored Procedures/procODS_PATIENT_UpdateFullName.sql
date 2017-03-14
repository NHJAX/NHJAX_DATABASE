

create PROCEDURE [dbo].[procODS_PATIENT_UpdateFullName]
	@pat decimal,
	@name varchar(32)
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		FullName = @name,
		UpdatedDate = GetDate()
	WHERE PatientKey = @pat
END

