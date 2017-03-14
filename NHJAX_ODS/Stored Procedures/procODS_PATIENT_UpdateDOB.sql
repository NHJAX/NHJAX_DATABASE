

create PROCEDURE [dbo].[procODS_PATIENT_UpdateDOB]
	@pat decimal,
	@dob datetime

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		DOB = @dob,
		UpdatedDate = GetDate()
	WHERE PatientKey = @pat
END

