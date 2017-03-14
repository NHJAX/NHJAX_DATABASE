
CREATE PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_InsertODS2]
(
	@pat bigint,
	@pa numeric(14,3),
	@enc numeric(13,3),
	@dt datetime,
	@loc bigint,
	@pro bigint,
	@dur numeric(11,3),
	@stat bigint,
	@rea varchar(80),
	@ac bigint,
	@pd bigint,
	@rel datetime,
	@pri bigint,
	@rc bigint,
	@atyp bigint,
	@src bigint,
	@dmis bigint,
	@mep bigint,
	@key varchar(50),
	@etr varchar(30) = ''
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.PATIENT_ENCOUNTER
(
	PatientId,
	PatientAppointmentKey,
	EncounterKey,
	AppointmentDateTime,
	HospitalLocationId,
	ProviderId,
	Duration,
	AppointmentStatusId,
	ReasonForAppointment,
	ArrivalCategoryId,
	PatientDispositionId,
	ReleaseDateTime,
	PriorityId,
	ReleaseConditionId,
	AppointmentTypeId,
	SourceSystemId,
	DMISId,
	MeprsCodeId,
	SourceSystemKey,
	EREntryNumber
) 
VALUES
(
	@pat,
	@pa,
	@enc,
	@dt,
	@loc,
	@pro,
	@dur,
	@stat,
	@rea,
	@ac,
	@pd,
	@rel,
	@pri,
	@rc,
	@atyp,
	@src,
	@dmis,
	@mep,
	@key,
	@etr
);
SELECT SCOPE_IDENTITY();