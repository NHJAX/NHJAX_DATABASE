
create PROCEDURE [dbo].[procODS_PATIENT_ORDER_UpdateOrderComment]
(
	@id bigint,
	@com varchar(100)
)
AS
	SET NOCOUNT ON;
UPDATE PATIENT_ORDER
SET OrderComment = @com,
UpdatedDate = GETDATE()
WHERE (OrderId = @id)


