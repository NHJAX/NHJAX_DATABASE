

create PROCEDURE [dbo].[procODS_PATIENT_UpdateDeersPatientIdentifier]
	@pat decimal,
	@deers varchar(50)

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		PatientIdentifier = @deers,
		UpdatedDate = GetDate()
	WHERE PatientKey = @pat
END

