


CREATE PROCEDURE [dbo].[upODS_Diagnosis_Select]
(
	@typ int
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT DiagnosisId,DiagnosisCode,DiagnosisDesc
	FROM DIAGNOSIS
	WHERE DiagnosisType = @typ 
		and DiagnosisId <> 0 
		and DataLength(DiagnosisDesc) > 0
	ORDER BY DiagnosisDesc
END


