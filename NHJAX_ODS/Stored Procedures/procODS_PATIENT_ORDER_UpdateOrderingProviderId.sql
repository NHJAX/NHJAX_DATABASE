
create PROCEDURE [dbo].[procODS_PATIENT_ORDER_UpdateOrderingProviderId]
(
	@id bigint,
	@pro bigint
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ORDER
SET OrderingProviderId = @pro,
UpdatedDate = GETDATE()
WHERE (OrderId = @id)


