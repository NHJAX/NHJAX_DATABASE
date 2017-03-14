
create PROCEDURE [dbo].[procODS_PATIENT_ORDER_UpdateOrderStatusId]
(
	@id bigint,
	@stat bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ORDER
SET OrderStatusId = @stat,
UpdatedDate = GETDATE()
WHERE (OrderId = @id)


