
create PROCEDURE [dbo].[procODS_PATIENT_ADMISSION_UpdateAdmissionDate]
(
	@adm bigint,
	@dt datetime
)
AS
	SET NOCOUNT ON;
	
UPDATE PATIENT_ADMISSION
SET AdmissionDate = @dt,
	UpdatedDate = Getdate()
WHERE PatientAdmissionId = @adm;

