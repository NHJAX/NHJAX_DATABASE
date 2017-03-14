

create PROCEDURE [dbo].[procODS_PATIENT_UpdateSponsorSSNbyID]
	@pat bigint,
	@spon varchar(15)
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		SponsorSSN = @spon,
		UpdatedDate = GetDate()
	WHERE PatientId = @pat
END

