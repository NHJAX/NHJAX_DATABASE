
create PROCEDURE [dbo].[procODS_PRIORITY_Insert]
(
	@desc varchar(30),
	@code varchar(1)
)
AS
	SET NOCOUNT ON;
	
INSERT INTO PRIORITY
(
	PriorityDesc,
	PriorityCode
) 
VALUES
(
	@desc,
	@code
);
SELECT SCOPE_IDENTITY();
