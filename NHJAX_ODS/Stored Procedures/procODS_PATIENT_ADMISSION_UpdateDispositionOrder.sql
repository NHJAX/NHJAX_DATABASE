
CREATE PROCEDURE [dbo].[procODS_PATIENT_ADMISSION_UpdateDispositionOrder]
(
	@adm bigint,
	@ord numeric(21,3)
)
AS
	SET NOCOUNT ON;
	
UPDATE PATIENT_ADMISSION
SET DispositionOrder = @ord,
	UpdatedDate = Getdate()
WHERE PatientAdmissionId = @adm;

