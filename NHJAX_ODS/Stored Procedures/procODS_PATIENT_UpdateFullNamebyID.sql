

create PROCEDURE [dbo].[procODS_PATIENT_UpdateFullNamebyID]
	@pat bigint,
	@name varchar(32)
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		FullName = @name,
		UpdatedDate = GetDate()
	WHERE PatientId = @pat
END

