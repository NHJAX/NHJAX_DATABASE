
create PROCEDURE [dbo].[procODS_RADIOLOGY_EXAM_UpdateRadiologyId]
(
	@id bigint,
	@rad bigint
)
AS
	SET NOCOUNT ON;
UPDATE RADIOLOGY_EXAM
SET RadiologyId = @rad,
	UpdatedDate = GETDATE()
WHERE (RadiologyExamId = @id)


