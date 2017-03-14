
CREATE PROCEDURE [dbo].[procODS_ARRIVAL_CATEGORY_Select]
(
	@desc varchar(30)
)
AS
	SET NOCOUNT ON;
	
SELECT ArrivalCategoryId,
	ArrivalCategoryDesc,
	ArrivalCategoryCode
FROM ARRIVAL_CATEGORY
WHERE ArrivalCategoryDesc = @desc
OR ArrivalCategoryCode = @desc;

