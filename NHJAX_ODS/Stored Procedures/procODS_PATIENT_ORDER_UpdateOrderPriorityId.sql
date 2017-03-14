
create PROCEDURE [dbo].[procODS_PATIENT_ORDER_UpdateOrderPriorityId]
(
	@id bigint,
	@pri bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ORDER
SET OrderPriorityId = @pri,
UpdatedDate = GETDATE()
WHERE (OrderId = @id)


