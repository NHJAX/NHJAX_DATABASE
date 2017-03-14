

create PROCEDURE [dbo].[procODS_PATIENT_UpdateSex]
	@pat decimal,
	@sex varchar(30)

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		Sex = @sex,
		UpdatedDate = GetDate()
	WHERE PatientKey = @pat
END

