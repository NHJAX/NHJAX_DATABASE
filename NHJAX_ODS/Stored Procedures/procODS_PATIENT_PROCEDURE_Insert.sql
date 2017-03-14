
create PROCEDURE [dbo].[procODS_PATIENT_PROCEDURE_Insert]
(
	@key numeric(8,3),
	@cpt bigint,
	@enc bigint,
	@typ bigint,
	@pri numeric(10,3),
	@pdate datetime,
	@sur bigint,
	@ane bigint,
	@desc varchar(100),
	@rvu money,
	@ss bigint
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.PATIENT_PROCEDURE
(
	ProcedureKey,
	CptId, 
	PatientEncounterId,
	ProcedureTypeId,
	DiagnosisPriorities,
	ProcedureDateTime,
	SurgeonId,
	AnesthetistId,
	ProcedureDesc,
	RVU,
	SourceSystemId
) 
VALUES
(
	@key,
	@cpt,
	@enc,
	@typ,
	@pri,
	@pdate,
	@sur,
	@ane,
	@desc,
	@rvu,
	@ss
);
SELECT SCOPE_IDENTITY();