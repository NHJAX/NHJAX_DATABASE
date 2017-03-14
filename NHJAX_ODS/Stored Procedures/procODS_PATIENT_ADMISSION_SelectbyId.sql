
create PROCEDURE [dbo].[procODS_PATIENT_ADMISSION_SelectbyId]
(
	@adm bigint
)
AS
	SET NOCOUNT ON;
	SELECT     
		PatientAdmissionId, 
		PatientAdmissionKey, 
		PatientId, 
		AdmissionTypeId, 
		DischargeTypeId, 
		AdmittingPhysicianId, 
		AttendingPhysicianId, 
		DispositioningPhysicianId, 
		AdmissionDate, 
		DischargeDate, 
		SameDaySurgery, 
		EncounterKey, 
		DispositionOrder
	FROM PATIENT_ADMISSION
	WHERE (PatientAdmissionId = @adm)
