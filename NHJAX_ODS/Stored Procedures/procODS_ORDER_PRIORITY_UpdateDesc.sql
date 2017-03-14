
CREATE PROCEDURE [dbo].[procODS_ORDER_PRIORITY_UpdateDesc]
(
	@key numeric(8,3),
	@desc varchar(30)
)
AS
	SET NOCOUNT ON;
	
UPDATE ORDER_PRIORITY
SET OrderPriorityDesc = @desc,
	UpdatedDate = Getdate()
WHERE OrderPriorityKey = @key;

