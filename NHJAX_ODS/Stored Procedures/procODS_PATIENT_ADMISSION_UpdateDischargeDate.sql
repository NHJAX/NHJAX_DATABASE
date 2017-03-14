
create PROCEDURE [dbo].[procODS_PATIENT_ADMISSION_UpdateDischargeDate]
(
	@adm bigint,
	@dt datetime
)
AS
	SET NOCOUNT ON;
	
UPDATE PATIENT_ADMISSION
SET DischargeDate = @dt,
	UpdatedDate = Getdate()
WHERE PatientAdmissionId = @adm;

