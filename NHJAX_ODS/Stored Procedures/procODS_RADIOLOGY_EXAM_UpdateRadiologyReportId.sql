
create PROCEDURE [dbo].[procODS_RADIOLOGY_EXAM_UpdateRadiologyReportId]
(
	@id bigint,
	@rr bigint
)
AS
	SET NOCOUNT ON;
UPDATE RADIOLOGY_EXAM
SET RadiologyReportId = @rr,
	UpdatedDate = GETDATE()
WHERE (RadiologyExamId = @id)


