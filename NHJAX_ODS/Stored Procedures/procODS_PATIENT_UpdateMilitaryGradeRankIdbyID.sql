

create PROCEDURE [dbo].[procODS_PATIENT_UpdateMilitaryGradeRankIdbyID]
	@pat bigint,
	@rnk bigint

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		MilitaryGradeRankId = @rnk,
		UpdatedDate = GetDate()
	WHERE PatientId = @pat
END

