
create PROCEDURE [dbo].[procODS_PATIENT_ORDER_UpdateOrderTypeId]
(
	@id bigint,
	@typ bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ORDER
SET OrderTypeId = @typ,
UpdatedDate = GETDATE()
WHERE (OrderId = @id)


