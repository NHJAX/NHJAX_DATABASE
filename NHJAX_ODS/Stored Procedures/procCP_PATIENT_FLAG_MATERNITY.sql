
CREATE PROCEDURE [dbo].[procCP_PATIENT_FLAG_MATERNITY]

AS
BEGIN	
	SET NOCOUNT ON;
	INSERT INTO PATIENT_FLAG
	(
		PatientId,
		FlagId,
		SourceSystemId
	)
	SELECT  DISTINCT   
		PatientId,
		17 AS FlagId,
		8 AS SourceSystemId
	FROM MATERNITY_PATIENT
	WHERE MaternityStatusId IN (0)
		AND EDC BETWEEN 
		dbo.FirstDayofMonth(DATEADD(MONTH,-2,GETDATE())) 
		AND dbo.LastDayofMonth(DATEADD(MONTH,9,GETDATE()))
		-------LOOKS FOR DEATH ICD-9 CODES
		
		AND PatientId NOT IN
		(
		SELECT PatientId
		FROM PATIENT
		WHERE PatientDeceased = 1
		)
END
