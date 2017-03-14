
create PROCEDURE [dbo].[procODS_PATIENT_ADMISSION_Select]
(
	@pat bigint,
	@key numeric(10,3)
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
	WHERE (PatientAdmissionKey = @key)
	AND PatientId = @pat
