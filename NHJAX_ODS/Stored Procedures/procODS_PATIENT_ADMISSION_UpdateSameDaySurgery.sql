
create PROCEDURE [dbo].[procODS_PATIENT_ADMISSION_UpdateSameDaySurgery]
(
	@adm bigint,
	@sur varchar(3)
)
AS
	SET NOCOUNT ON;
	
UPDATE PATIENT_ADMISSION
SET SameDaySurgery = @sur,
	UpdatedDate = Getdate()
WHERE PatientAdmissionId = @adm;

