
CREATE PROCEDURE [dbo].[procODS_RADIOLOGY_EXAM_SelectbyKey]
(
	@key numeric(15,3)
)
AS
	SET NOCOUNT ON;
SELECT     
	RadiologyExamId,
	RadiologyExamKey,
	ExamDateTime,
	ExamStatusId,
	ExamNumber,
	PatientId,
	RadiologyId,
	OrderId,
	OrderKey,
	HospitalLocationId,
	ProviderId,
	UnitCost,
	CreatedDate, 
    UpdatedDate, 
    RadiologyReportId, 
    SourceSystemId 
FROM RADIOLOGY_EXAM
WHERE (RadiologyExamKey = @key)

