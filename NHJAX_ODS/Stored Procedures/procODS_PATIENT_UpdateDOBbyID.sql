

create PROCEDURE [dbo].[procODS_PATIENT_UpdateDOBbyID]
	@pat bigint,
	@dob datetime

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		DOB = @dob,
		UpdatedDate = GetDate()
	WHERE PatientId = @pat
END

