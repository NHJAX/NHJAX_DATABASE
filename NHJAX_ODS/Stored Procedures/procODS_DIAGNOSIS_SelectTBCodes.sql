
create PROCEDURE [dbo].[procODS_DIAGNOSIS_SelectTBCodes]

AS
	SET NOCOUNT ON;
SELECT
	DiagnosisId, 
	DiagnosisKey, 
	DiagnosisCode, 
	DiagnosisDesc, 
	DiagnosisName, 
	DiagnosisType, 
	RelativeWeight, 
	CreatedDate, 
	UpdatedDate
FROM DIAGNOSIS
WHERE DiagnosisId IN (7116, 12218, 7487, 14480, 7876)

