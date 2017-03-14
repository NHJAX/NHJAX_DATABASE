CREATE PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_SelectGestationalDiabetesLabResults]
@patientid int = 0
WITH EXEC AS CALLER
AS
DECLARE @HoldTable as TABLE (PatientId int not null, LabResult varchar(19) null, TestName nvarchar(25) null)

INSERT INTO @HoldTable (LabResult,Testname,PatientId)
SELECT Top 1 Result, 'GLU FAST', @patientid FROM NHJAX_ODS.dbo.LAB_RESULT WHERE PatientId = @patientid AND LabTestId = 927 ORDER BY TakenDate 

INSERT INTO @HoldTable (LabResult,Testname,PatientId)
SELECT Top 1 Result, 'GLU 1H POST 50G', @patientid FROM NHJAX_ODS.dbo.LAB_RESULT WHERE PatientId = @patientid AND LabTestId = 926 ORDER BY TakenDate 

INSERT INTO @HoldTable (LabResult,Testname,PatientId)
SELECT Top 1 Result, '1HR GLU', @patientid FROM NHJAX_ODS.dbo.LAB_RESULT WHERE PatientId = @patientid AND LabTestId = 431 ORDER BY TakenDate 

INSERT INTO @HoldTable (LabResult,Testname,PatientId)
SELECT Top 1 Result, '2HR GTT', @patientid FROM NHJAX_ODS.dbo.LAB_RESULT WHERE PatientId = @patientid AND LabTestId = 432 ORDER BY TakenDate 

INSERT INTO @HoldTable (LabResult,Testname,PatientId)
SELECT Top 1 Result, '3HR GLU', @patientid FROM NHJAX_ODS.dbo.LAB_RESULT WHERE PatientId = @patientid AND LabTestId = 433 ORDER BY TakenDate 

SELECT 
 PatientId
,LabResult
,TestName
FROM @HoldTable as result  FOR XML AUTO, ELEMENTS, ROOT('diabetesresults')