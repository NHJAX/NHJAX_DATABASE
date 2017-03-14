
create PROCEDURE [dbo].[procODS_RADIOLOGY_EXAM_UpdateExamStatusId]
(
	@id bigint,
	@stat bigint
)
AS
	SET NOCOUNT ON;
UPDATE RADIOLOGY_EXAM
SET ExamStatusId = @stat,
	UpdatedDate = GETDATE()
WHERE (RadiologyExamId = @id)


