
CREATE PROCEDURE [dbo].[procODS_PATIENT_ADMISSION_Insert]
	@pat bigint,
	@key decimal,
	@adm bigint,
	@dis bigint,
	@phy1 bigint,
	@phy2 bigint,
	@phy3 bigint,
	@dtadm datetime,
	@dtdis datetime,
	@sur varchar(3),
	@enc decimal,
	@ord decimal,
	@ss bigint
AS
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO PATIENT_ADMISSION
		(
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
		DispositionOrder,
		SourceSystemId
		)
		VALUES
		(
		@key,
		@pat,
		@adm,
		@dis,
		@phy1,
		@phy2,
		@phy3,
		@dtadm,
		@dtdis,
		@sur,
		@enc,
		@ord,
		@ss
		)
SELECT SCOPE_IDENTITY();
END

