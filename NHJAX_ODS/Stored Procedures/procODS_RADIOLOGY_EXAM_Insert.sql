
CREATE PROCEDURE [dbo].[procODS_RADIOLOGY_EXAM_Insert]
(
	@key decimal(15,3),
	@edate datetime,
	@stat bigint,
	@num varchar(8),
	@pat bigint,
	@rad bigint,
	@ord bigint,
	@okey numeric(21,3),
	@loc bigint,
	@pro bigint,
	@rr bigint,
	@ss bigint
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.RADIOLOGY_EXAM
(
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
	RadiologyReportId, 
	SourceSystemId
) 
VALUES
(
	@key,
	@edate,
	@stat,
	@num,
	@pat,
	@rad,
	@ord,
	@okey,
	@loc,
	@pro,
	@rr,
	@ss
);
SELECT SCOPE_IDENTITY();