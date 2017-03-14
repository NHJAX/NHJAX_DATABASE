
create PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_SelectbyPatient]
(
	@pat bigint
)
AS
	SET NOCOUNT ON;
SELECT
	MaternityPatientId,
	PatientId,
	EDC,	
	MaternityStatusId,
	Notes,
	CreatedDate,
	UpdatedDate,
	CreatedBy,
	UpdatedBy
FROM
	MATERNITY_PATIENT
WHERE PatientId = @pat
