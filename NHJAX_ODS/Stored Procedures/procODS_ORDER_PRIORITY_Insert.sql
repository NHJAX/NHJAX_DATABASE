
CREATE PROCEDURE [dbo].[procODS_ORDER_PRIORITY_Insert]
(
	@key numeric(8,3),
	@desc varchar(50)
)
AS
	SET NOCOUNT ON;
	
INSERT INTO ORDER_PRIORITY
(
	OrderPriorityKey,
	OrderPriorityDesc,
	OrderPriorityCode
) 
VALUES
(
	@key,
	@desc,
	@key
);
SELECT SCOPE_IDENTITY();
