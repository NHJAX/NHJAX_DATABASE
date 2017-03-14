

create PROCEDURE [dbo].[procODS_PATIENT_UpdateDeersPatientIdentifierbyID]
	@pat bigint,
	@deers varchar(50)

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		PatientIdentifier = @deers,
		UpdatedDate = GetDate()
	WHERE PatientId = @pat
END

