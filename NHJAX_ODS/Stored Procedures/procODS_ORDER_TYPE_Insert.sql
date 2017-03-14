
create PROCEDURE [dbo].[procODS_ORDER_TYPE_Insert]
(
	@key numeric(8,3),
	@desc varchar(50)
)
AS
	SET NOCOUNT ON;
	
INSERT INTO ORDER_TYPE
(
	OrderTypeKey,
	OrderTypeDesc
) 
VALUES
(
	@key,
	@desc
);
SELECT SCOPE_IDENTITY();
