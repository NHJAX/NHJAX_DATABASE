
create PROCEDURE [dbo].[procODS_PATIENT_ORDER_UpdateOrderDateTime]
(
	@id bigint,
	@dt datetime
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ORDER
SET OrderDateTime = @dt,
UpdatedDate = GETDATE()
WHERE (OrderId = @id)


