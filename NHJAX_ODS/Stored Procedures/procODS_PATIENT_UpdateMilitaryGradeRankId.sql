

create PROCEDURE [dbo].[procODS_PATIENT_UpdateMilitaryGradeRankId]
	@pat decimal,
	@rnk bigint

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		MilitaryGradeRankId = @rnk,
		UpdatedDate = GetDate()
	WHERE PatientKey = @pat
END

