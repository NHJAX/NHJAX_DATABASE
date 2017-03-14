CREATE FUNCTION [dbo].[PatientsGestationalDiabetesResultsStr]
(@patientid int = 0)
RETURNS nvarchar(MAX)
WITH EXEC AS CALLER
AS
BEGIN
DECLARE @LabResult nvarchar(MAX)
DECLARE @ReturnValue as nvarchar(max)
SET @LabResult = ''
SET @ReturnValue = '<table>'

SELECT Top 1 @LabResult = '<tr><td>50MG</td><td>' + Result + '<br/></td></tr>' 
FROM NHJAX_ODS.dbo.LAB_RESULT 
WHERE PatientId = @patientid 
AND LabTestId = 926 
AND TakenDate >= DATEADD(yy,-1,getdate())
ORDER BY TakenDate DESC

SET @ReturnValue = @ReturnValue + @LabResult
SET @LabResult = ''

SELECT Top 1 @LabResult = '<tr><td>FAST</td><td>' + Result + '<br/></td></tr>'
FROM NHJAX_ODS.dbo.LAB_RESULT 
WHERE PatientId = @patientid 
AND LabTestId = 927 
AND TakenDate >= DATEADD(yy,-1,getdate())
ORDER BY TakenDate DESC

SET @ReturnValue = @ReturnValue + @LabResult
SET @LabResult = ''

SELECT Top 1 @LabResult = '<tr><td>1HR</td><td>' + Result + '<br/></td></tr>'
FROM NHJAX_ODS.dbo.LAB_RESULT 
WHERE PatientId = @patientid 
AND LabTestId = 431 
AND TakenDate >= DATEADD(yy,-1,getdate())
ORDER BY TakenDate DESC

SET @ReturnValue = @ReturnValue + @LabResult
SET @LabResult = ''

SELECT Top 1 @LabResult = '<tr><td>2HR</td><td>' + Result + '<br/></td></tr>'
FROM NHJAX_ODS.dbo.LAB_RESULT 
WHERE PatientId = @patientid 
AND LabTestId = 432 
AND TakenDate >= DATEADD(yy,-1,getdate())
ORDER BY TakenDate DESC

SET @ReturnValue = @ReturnValue + @LabResult
SET @LabResult = ''

SELECT Top 1 @LabResult = '<tr><td>3HR</td><td>' + Result + '<br/></td></tr>'
FROM NHJAX_ODS.dbo.LAB_RESULT 
WHERE PatientId = @patientid 
AND LabTestId = 433 
AND TakenDate >= DATEADD(yy,-1,getdate())
ORDER BY TakenDate DESC

SET @ReturnValue = @ReturnValue + @LabResult + '</table>'


Return @ReturnValue
END