

create PROCEDURE [dbo].[procODS_PATIENT_UpdateFamilyMemberPrefixId]
	@pat decimal,
	@fmp bigint

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		FamilyMemberPrefixId = @fmp,
		UpdatedDate = GetDate()
	WHERE PatientKey = @pat
END

