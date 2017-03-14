
CREATE PROCEDURE [dbo].[procODS_RADIOLOGY_EXAM_UpdateOrderId]
(
	@id bigint,
	@ord bigint,
	@okey numeric(21,3)
)
AS
	SET NOCOUNT ON;
UPDATE RADIOLOGY_EXAM
SET OrderId = @ord,
	OrderKey = @okey,
	UpdatedDate = GETDATE()
WHERE (RadiologyExamId = @id)


