CREATE FUNCTION [dbo].[PatientsGestationalDiabetesResults]
(@patientid int = 0)
RETURNS xml
WITH EXEC AS CALLER
AS
BEGIN
DECLARE @HoldTable as TABLE (PatientId int not null, LabResult varchar(19) null, TestName nvarchar(25) null, PatEval int not null)

DECLARE @ReturnValue as xml

INSERT INTO @HoldTable (LabResult,Testname,PatientId,PatEval)
SELECT Top 1 Result, '50MG', @patientid, 0 
FROM NHJAX_ODS.dbo.LAB_RESULT 
WHERE PatientId = @patientid 
AND LabTestId = 926 
AND TakenDate >= DATEADD(yy,-1,getdate())
ORDER BY TakenDate DESC

INSERT INTO @HoldTable (LabResult,Testname,PatientId,PatEval)
SELECT Top 1 Result, 'FAST', @patientid, 0 
FROM NHJAX_ODS.dbo.LAB_RESULT 
WHERE PatientId = @patientid 
AND LabTestId = 927 
AND TakenDate >= DATEADD(yy,-1,getdate())
ORDER BY TakenDate DESC

INSERT INTO @HoldTable (LabResult,Testname,PatientId,PatEval)
SELECT Top 1 Result, '1HR', @patientid, 0
FROM NHJAX_ODS.dbo.LAB_RESULT 
WHERE PatientId = @patientid 
AND LabTestId = 431 
AND TakenDate >= DATEADD(yy,-1,getdate())
ORDER BY TakenDate DESC

INSERT INTO @HoldTable (LabResult,Testname,PatientId,PatEval)
SELECT Top 1 Result, '2HR', @patientid, 0 
FROM NHJAX_ODS.dbo.LAB_RESULT 
WHERE PatientId = @patientid 
AND LabTestId = 432 
AND TakenDate >= DATEADD(yy,-1,getdate())
ORDER BY TakenDate DESC

INSERT INTO @HoldTable (LabResult,Testname,PatientId,PatEval)
SELECT Top 1 Result, '3HR', @patientid, 0 
FROM NHJAX_ODS.dbo.LAB_RESULT 
WHERE PatientId = @patientid 
AND LabTestId = 433 
AND TakenDate >= DATEADD(yy,-1,getdate())
ORDER BY TakenDate DESC

IF EXISTS (SELECT DISTINCT PE.[PatientId]
    			  FROM [CLINICAL_PORTAL].[dbo].[vwODS_ENCOUNTER_DIAGNOSIS] as ED
    				INNER JOIN [CLINICAL_PORTAL].[dbo].[vwODS_PATIENT_ENCOUNTER] as PE
    				ON PE.[PatientEncounterId] = ED.[PatientEncounterId] 
    				AND PE.PatientId = @patientid
    				AND DiagnosisId IN (9114,9115,9116,9117,11529)
    				)
  BEGIN
    UPDATE @HoldTable SET PatEval = 3 
  END

SET @ReturnValue = (
SELECT * FROM @HoldTable as result FOR XML AUTO, ELEMENTS, ROOT('results')
)

Return @ReturnValue
END