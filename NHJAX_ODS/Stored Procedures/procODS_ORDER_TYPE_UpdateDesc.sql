
create PROCEDURE [dbo].[procODS_ORDER_TYPE_UpdateDesc]
(
	@key numeric(8,3),
	@desc varchar(4)
)
AS
	SET NOCOUNT ON;
	
UPDATE ORDER_TYPE
SET OrderTypeDesc = @desc,
	UpdatedDate = Getdate()
WHERE OrderTypeKey = @key;

