
create PROCEDURE [dbo].[procODS_PATIENT_ADMISSION_UpdateDischargeType]
(
	@adm bigint,
	@typ bigint
)
AS
	SET NOCOUNT ON;
	
UPDATE PATIENT_ADMISSION
SET DischargeTypeId = @typ,
	UpdatedDate = Getdate()
WHERE PatientAdmissionId = @adm;

