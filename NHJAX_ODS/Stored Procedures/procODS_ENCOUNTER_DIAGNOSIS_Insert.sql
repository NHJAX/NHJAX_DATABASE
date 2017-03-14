
CREATE PROCEDURE [dbo].[procODS_ENCOUNTER_DIAGNOSIS_Insert]
(
	@enc bigint,
	@diag bigint,
	@pri int,
	@desc varchar(64),
	@ss bigint
)
AS
	SET NOCOUNT ON;
INSERT INTO ENCOUNTER_DIAGNOSIS
	(
		PatientEncounterId,
		DiagnosisId,
		Priority,
		[Description],
		SourceSystemId
	)
VALUES(@enc,@diag,@pri,@desc,@ss)

