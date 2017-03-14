

create PROCEDURE [dbo].[procODS_PATIENT_UpdateDmisId]
	@pat decimal,
	@dmis bigint

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		DMISId = @dmis,
		UpdatedDate = GetDate()
	WHERE PatientKey = @pat
END

