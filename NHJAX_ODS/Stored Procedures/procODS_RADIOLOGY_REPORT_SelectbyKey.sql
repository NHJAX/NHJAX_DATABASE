
CREATE PROCEDURE [dbo].[procODS_RADIOLOGY_REPORT_SelectbyKey]
(
	@key numeric(13,3)
)
AS
	SET NOCOUNT ON;
SELECT     
	RadiologyReportId, 
	RadiologyReportKey,
	CreatedDateTime, 
	PatientId, 
	ResultCategoryId, 
	ExamDateTime, 
	CreatedDate, 
    UpdatedDate, 
    SourceSystemId 
FROM RADIOLOGY_REPORT
WHERE (RadiologyReportKey = @key)

