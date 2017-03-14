
create PROCEDURE [dbo].[procODS_ORDER_STATUS_Insert]
(
	@desc varchar(50)
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.ORDER_STATUS
(
	OrderStatusDesc
) 
VALUES
(
	@desc
);
SELECT SCOPE_IDENTITY();
