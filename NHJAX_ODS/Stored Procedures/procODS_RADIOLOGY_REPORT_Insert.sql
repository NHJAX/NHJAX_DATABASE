
CREATE PROCEDURE [dbo].[procODS_RADIOLOGY_REPORT_Insert]
(
	@key decimal(13,3),
	@cdate datetime,
	@pat bigint,
	@cat bigint,
	@edate datetime,
	@ss bigint
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.RADIOLOGY_REPORT
(
	RadiologyReportKey, 
	CreatedDateTime, 
	PatientId, 
	ResultCategoryId, 
	ExamDateTime, 
	SourceSystemId
) 
VALUES
(
	@key,
	@cdate,
	@pat,
	@cat,
	@edate,
	@ss
);
SELECT SCOPE_IDENTITY();