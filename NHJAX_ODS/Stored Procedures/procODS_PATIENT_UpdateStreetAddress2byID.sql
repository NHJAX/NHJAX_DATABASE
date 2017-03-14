

create PROCEDURE [dbo].[procODS_PATIENT_UpdateStreetAddress2byID]
	@pat bigint,
	@add2 varchar(36)

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		StreetAddress2 = @add2,
		UpdatedDate = GetDate()
	WHERE PatientId = @pat
END

