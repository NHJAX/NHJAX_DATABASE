
create PROCEDURE [dbo].[procODS_PATIENT_DISPOSITION_Select]
(
	@key numeric(10,3)
)
AS
	SET NOCOUNT ON;
	
SELECT PatientDispositionId,
	PatientDispositionKey,
	PatientDispositionDesc,
	PatientDispositionCode
FROM PATIENT_DISPOSITION
WHERE PatientDispositionKey = @key;

