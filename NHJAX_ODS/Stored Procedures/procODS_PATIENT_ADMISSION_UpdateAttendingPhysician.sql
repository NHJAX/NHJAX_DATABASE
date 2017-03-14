
create PROCEDURE [dbo].[procODS_PATIENT_ADMISSION_UpdateAttendingPhysician]
(
	@adm bigint,
	@phy bigint
)
AS
	SET NOCOUNT ON;
	
UPDATE PATIENT_ADMISSION
SET AttendingPhysicianId = @phy,
	UpdatedDate = Getdate()
WHERE PatientAdmissionId = @adm;

