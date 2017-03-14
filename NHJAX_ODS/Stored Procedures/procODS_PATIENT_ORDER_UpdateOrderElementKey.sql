
create PROCEDURE [dbo].[procODS_PATIENT_ORDER_UpdateOrderElementKey]
(
	@id bigint,
	@elm numeric(21,3)
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ORDER
SET OrderElementKey = @elm,
UpdatedDate = GETDATE()
WHERE (OrderId = @id)


