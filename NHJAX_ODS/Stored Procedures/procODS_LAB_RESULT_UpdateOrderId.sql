
create PROCEDURE [dbo].[procODS_LAB_RESULT_UpdateOrderId]
(
	@id bigint,
	@ord bigint
)
AS
	SET NOCOUNT ON;
UPDATE LAB_RESULT
SET OrderId = @ord,
	UpdatedDate = GETDATE()
WHERE (LabResultId = @id)


