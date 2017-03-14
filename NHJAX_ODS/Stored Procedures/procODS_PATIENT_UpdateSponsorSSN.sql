

create PROCEDURE [dbo].[procODS_PATIENT_UpdateSponsorSSN]
	@pat decimal,
	@spon varchar(15)
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		SponsorSSN = @spon,
		UpdatedDate = GetDate()
	WHERE PatientKey = @pat
END

