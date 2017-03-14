
create PROCEDURE [dbo].[procODS_PATIENT_PROCEDURE_SelectbyEncounter]
(
	@enc bigint
)
AS
	SET NOCOUNT ON;
SELECT     
	ProcedureId,
	ProcedureKey,
	CptId,
	PatientEncounterId,
	ProcedureTypeId,
	DiagnosisPriorities,
	ProcedureDateTime,
	SurgeonId,
	AnesthetistId,
	ProcedureDesc,
	CreatedDate,
	UpdatedDate,
	RVU,
	SourceSystemId
FROM PATIENT_PROCEDURE
WHERE (PatientEncounterId = @enc)
