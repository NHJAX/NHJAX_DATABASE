CREATE FUNCTION [dbo].[IsGestationalDiabeticAbnormal]
(@patientid int)
RETURNS bit
WITH EXEC AS CALLER
AS
BEGIN
DECLARE @sLabResult nvarchar(255)
DECLARE @AbnormalCount int
DECLARE @50MG_Is_Abnormal bit
DECLARE @50MG_Is_Over_200 bit
DECLARE @ReturnValue bit
SET @AbnormalCount = 0
SET @50MG_Is_Abnormal = 0
SET @50MG_Is_Over_200 = 0



	  --*********************************************************************************************  
	  --*********************************                 FAST ABNORMAL RESULT >95
	  --*********************************************************************************************  
	  SET @sLabResult = '0'
	  SELECT Top 1 @sLabResult = Result 
	  FROM NHJAX_ODS.dbo.LAB_RESULT 
	  WHERE PatientId = @patientid 
	  AND LabTestId = 927 
	  AND TakenDate >= DATEADD(yy,-1,getdate())
	  ORDER BY TakenDate DESC

	  IF RTRIM(@sLabResult) = 'NT' SET @sLabResult = '0'
	  IF RTRIM(@sLabResult) = 'ND' SET @sLabResult = '0'
	  IF dbo.Is_numeric(@sLabResult) = 0 SET @sLabResult = '0'
	  IF (CONVERT(money,ISNULL(@sLabResult,0))>95) 
		BEGIN
		  SET @AbnormalCount = @AbnormalCount + 1 
		END
	  --*********************************************************************************************  
	  --*********************************                 50MG ABNORMAL RESULT >130
	  --*********************************************************************************************  
	  SET @sLabResult = '0'
	  SELECT Top 1 @sLabResult = Result 
	  FROM NHJAX_ODS.dbo.LAB_RESULT 
	  WHERE PatientId = @patientid 
	  AND LabTestId = 926 
	  AND TakenDate >= DATEADD(yy,-1,getdate())
	  ORDER BY TakenDate DESC
	  IF RTRIM(@sLabResult) = 'NT' SET @sLabResult = '0'
	  IF RTRIM(@sLabResult) = 'ND' SET @sLabResult = '0'
	  IF dbo.Is_numeric(@sLabResult) = 0 SET @sLabResult = '0'
	  IF (CONVERT(money,ISNULL(@sLabResult,0))>130) 
		BEGIN
		  SET @50MG_Is_Abnormal = 1
		  IF (CONVERT(money,ISNULL(@sLabResult,0))>200)
			BEGIN
			  SET @50MG_Is_Over_200 = 1
			END
		END
	  SET @sLabResult = '0'
	  --*********************************************************************************************  
	  --*********************************                 1HR  ABNORMAL RESULT >180
	  --*********************************************************************************************  
	  SELECT Top 1 @sLabResult = Result 
	  FROM NHJAX_ODS.dbo.LAB_RESULT 
	  WHERE PatientId = @patientid 
	  AND LabTestId = 431 
	  AND TakenDate >= DATEADD(yy,-1,getdate())
	  ORDER BY TakenDate DESC
	  IF RTRIM(@sLabResult) = 'NT' SET @sLabResult = '0'
	  IF RTRIM(@sLabResult) = 'ND' SET @sLabResult = '0'
	  IF dbo.Is_numeric(@sLabResult) = 0 SET @sLabResult = '0'
	  IF (CONVERT(money,ISNULL(@sLabResult,0))>180) 
		BEGIN
		  SET @AbnormalCount = @AbnormalCount + 1 
		END
	  SET @sLabResult = '0'
	  --*********************************************************************************************  
	  --*********************************                 2HR  ABNORMAL RESULT >155
	  --*********************************************************************************************  
	  SELECT Top 1 @sLabResult = Result 
	  FROM NHJAX_ODS.dbo.LAB_RESULT 
	  WHERE PatientId = @patientid 
	  AND LabTestId = 432 
	  AND TakenDate >= DATEADD(yy,-1,getdate())
	  ORDER BY TakenDate DESC
	  IF RTRIM(@sLabResult) = 'NT' SET @sLabResult = '0'
	  IF RTRIM(@sLabResult) = 'ND' SET @sLabResult = '0'
	  IF dbo.Is_numeric(@sLabResult) = 0 SET @sLabResult = '0'
	  IF (CONVERT(money,ISNULL(@sLabResult,0))>155) 
		BEGIN
		  SET @AbnormalCount = @AbnormalCount + 1 
		END
	  SET @sLabResult = '0'
	  --*********************************************************************************************  
	  --*********************************                 3HR  ABNORMAL RESULT >140
	  --*********************************************************************************************  
	  SELECT Top 1 @sLabResult = Result 
	  FROM NHJAX_ODS.dbo.LAB_RESULT 
	  WHERE PatientId = @patientid 
	  AND LabTestId = 433 
	  AND TakenDate >= DATEADD(yy,-1,getdate())
	  ORDER BY TakenDate DESC
	  IF RTRIM(@sLabResult) = 'NT' SET @sLabResult = '0'
	  IF RTRIM(@sLabResult) = 'ND' SET @sLabResult = '0'
	  IF dbo.Is_numeric(@sLabResult) = 0 SET @sLabResult = '0'
	  IF (CONVERT(money,ISNULL(@sLabResult,0))>140) 
		BEGIN
		  SET @AbnormalCount = @AbnormalCount + 1 
		END
	  --*********************************************************************************************  
	  --*********************************************************************************************  
	  --*********************************************************************************************  

	IF @50MG_Is_Abnormal = 1 AND @AbnormalCount > 1
	  BEGIN
		SET @ReturnValue = 1  
	  END
	ELSE
	  BEGIN
		IF @50MG_Is_Over_200 = 1
		  BEGIN
			SET @ReturnValue = 1
		  END
		ELSE
		  BEGIN
			SET @ReturnValue = 0  
		  END
	  END

IF @@ERROR < 0
	BEGIN
		SET @ReturnValue = 0
	END
--IF EXISTS (SELECT DISTINCT PE.[PatientId]
--    			  FROM [CLINICAL_PORTAL].[dbo].[vwODS_ENCOUNTER_DIAGNOSIS] as ED
--    				INNER JOIN [CLINICAL_PORTAL].[dbo].[vwODS_PATIENT_ENCOUNTER] as PE
--    				ON PE.[PatientEncounterId] = ED.[PatientEncounterId] 
--    				AND PE.PatientId = @patientid
--    				AND DiagnosisId IN (9114,9115,9116,9117,11529)
--    				)
--  BEGIN
--    SET @ReturnValue = 1 
--  END

RETURN @ReturnValue
END