
CREATE PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_InsertReferral]
(
	@enc numeric(13,3),
	@pat bigint,
	@dt datetime,
	@pro bigint,
	@stat bigint,
	@rea varchar(80),
	@src bigint,
	@dmis bigint,
	@key varchar(50),
	@etr varchar(30) = ''
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.PATIENT_ENCOUNTER
(
	EncounterKey, 
	PatientId,
	AppointmentDateTime,
	ProviderId,
	AppointmentStatusId,
	ReasonForAppointment,
	SourceSystemId,
	DMISId,
	SourceSystemKey,
	EREntryNumber
) 
VALUES
(
	@enc,
	@pat,
	@dt,
	@pro,
	@stat,
	@rea,
	@src,
	@dmis,
	@key,
	@etr
);
SELECT SCOPE_IDENTITY();