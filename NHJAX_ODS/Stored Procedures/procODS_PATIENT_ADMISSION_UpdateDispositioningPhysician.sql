
create PROCEDURE [dbo].[procODS_PATIENT_ADMISSION_UpdateDispositioningPhysician]
(
	@adm bigint,
	@phy bigint
)
AS
	SET NOCOUNT ON;
	
UPDATE PATIENT_ADMISSION
SET DispositioningPhysicianId = @phy,
	UpdatedDate = Getdate()
WHERE PatientAdmissionId = @adm;

