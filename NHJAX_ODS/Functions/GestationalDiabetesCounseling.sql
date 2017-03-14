CREATE FUNCTION [dbo].[GestationalDiabetesCounseling]
(@patientid int = 0, @counselingType nvarchar(50) = N'COUNSEL')
RETURNS nvarchar(50)
WITH EXEC AS CALLER
AS
BEGIN

DECLARE @ReturnValue nvarchar(25)

IF @counselingType = 'COUNSEL'
  BEGIN
    SELECT TOP 1 @ReturnValue = CONVERT(NVARCHAR(25),PE.AppointmentDateTime,101) FROM PATIENT_ENCOUNTER as PE
      INNER JOIN ENCOUNTER_DIAGNOSIS AS ED ON ED.PatientEncounterId = PE.PatientEncounterId AND ED.DiagnosisId IN (11529,7627)
    WHERE PE.PatientId =   @patientid  ORDER BY PE.AppointmentDateTime DESC
  END
ELSE
  BEGIN
    SELECT TOP 1 @ReturnValue = CONVERT(NVARCHAR(25),PE.AppointmentDateTime,101) FROM PATIENT_ENCOUNTER as PE
      INNER JOIN ENCOUNTER_DIAGNOSIS AS ED ON ED.PatientEncounterId = PE.PatientEncounterId AND ED.DiagnosisId IN (11529,7089)
    WHERE PE.PatientId =   @patientid    ORDER BY PE.AppointmentDateTime DESC
  END
  
  
RETURN @ReturnValue  
END