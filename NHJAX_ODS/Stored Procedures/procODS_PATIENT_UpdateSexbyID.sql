

create PROCEDURE [dbo].[procODS_PATIENT_UpdateSexbyID]
	@pat bigint,
	@sex varchar(30)

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		Sex = @sex,
		UpdatedDate = GetDate()
	WHERE PatientId = @pat
END

