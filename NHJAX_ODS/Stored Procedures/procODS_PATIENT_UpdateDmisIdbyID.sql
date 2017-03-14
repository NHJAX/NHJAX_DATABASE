

create PROCEDURE [dbo].[procODS_PATIENT_UpdateDmisIdbyID]
	@pat bigint,
	@dmis bigint

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		DMISId = @dmis,
		UpdatedDate = GetDate()
	WHERE PatientId = @pat
END

