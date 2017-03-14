
CREATE PROCEDURE [dbo].[procODS_ARRIVAL_CATEGORY_Insert]
(
	@desc varchar(30),
	@code varchar(1)
)
AS
	SET NOCOUNT ON;
	
INSERT INTO ARRIVAL_CATEGORY
(
	ArrivalCategoryDesc,
	ArrivalCategoryCode
) 
VALUES
(
	@desc,
	@code
);
SELECT SCOPE_IDENTITY();
