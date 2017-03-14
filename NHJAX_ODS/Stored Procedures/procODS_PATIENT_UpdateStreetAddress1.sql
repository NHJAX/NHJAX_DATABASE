

create PROCEDURE [dbo].[procODS_PATIENT_UpdateStreetAddress1]
	@pat decimal,
	@add1 varchar(38)

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		StreetAddress1 = @add1,
		UpdatedDate = GetDate()
	WHERE PatientKey = @pat
END

