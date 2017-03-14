
create PROCEDURE [dbo].[procODS_ORDER_STATUS_Select]
(
	@desc varchar(50)
)
AS
	SET NOCOUNT ON;
	
SELECT OrderStatusId,
	OrderStatusDesc
FROM ORDER_STATUS
WHERE OrderStatusDesc = @desc;

