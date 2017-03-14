
create PROCEDURE [dbo].[procODS_PATIENT_ADMISSION_UpdateAdmissionType]
(
	@adm bigint,
	@typ bigint
)
AS
	SET NOCOUNT ON;
	
UPDATE PATIENT_ADMISSION
SET AdmissionTypeId = @typ,
	UpdatedDate = Getdate()
WHERE PatientAdmissionId = @adm;

