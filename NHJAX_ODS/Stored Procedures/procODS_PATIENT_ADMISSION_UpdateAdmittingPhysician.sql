
create PROCEDURE [dbo].[procODS_PATIENT_ADMISSION_UpdateAdmittingPhysician]
(
	@adm bigint,
	@phy bigint
)
AS
	SET NOCOUNT ON;
	
UPDATE PATIENT_ADMISSION
SET AdmittingPhysicianId = @phy,
	UpdatedDate = Getdate()
WHERE PatientAdmissionId = @adm;

