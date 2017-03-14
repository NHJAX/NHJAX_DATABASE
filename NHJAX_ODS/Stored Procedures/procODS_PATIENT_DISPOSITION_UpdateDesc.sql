
create PROCEDURE [dbo].[procODS_PATIENT_DISPOSITION_UpdateDesc]
(
	@key numeric(8,3),
	@desc varchar(30)
)
AS
	SET NOCOUNT ON;
	
UPDATE PATIENT_DISPOSITION
SET PatientDispositionDesc = @desc,
	UpdatedDate = Getdate()
WHERE PatientDispositionKey = @key;

