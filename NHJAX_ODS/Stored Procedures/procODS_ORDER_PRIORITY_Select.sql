
create PROCEDURE [dbo].[procODS_ORDER_PRIORITY_Select]
(
	@key numeric(8,3)
)
AS
	SET NOCOUNT ON;
	
SELECT OrderPriorityId,
	OrderPriorityKey,
	OrderPriorityDesc
FROM ORDER_PRIORITY
WHERE OrderPriorityKey = @key;

