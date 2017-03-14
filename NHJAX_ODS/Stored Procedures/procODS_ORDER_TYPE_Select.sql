
CREATE PROCEDURE [dbo].[procODS_ORDER_TYPE_Select]
(
	@key numeric(8,3)
)
AS
	SET NOCOUNT ON;
	
SELECT OrderTypeId,
	OrderTypeKey,
	OrderTypeDesc
FROM ORDER_TYPE
WHERE OrderTypeKey = @key;

