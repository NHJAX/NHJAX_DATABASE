

create PROCEDURE [dbo].[procODS_PATIENT_UpdateHomePhonebyID]
	@pat bigint,
	@ph varchar(10)

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		Phone = @ph,
		UpdatedDate = GetDate()
	WHERE PatientId = @pat
END

