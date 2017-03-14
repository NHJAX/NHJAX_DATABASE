

create PROCEDURE [dbo].[procODS_PATIENT_UpdateFamilyMemberPrefixIdbyID]
	@pat bigint,
	@fmp bigint

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		FamilyMemberPrefixId = @fmp,
		UpdatedDate = GetDate()
	WHERE PatientId = @pat
END

