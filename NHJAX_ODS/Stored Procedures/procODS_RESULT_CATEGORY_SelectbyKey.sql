
CREATE PROCEDURE [dbo].[procODS_RESULT_CATEGORY_SelectbyKey]
(
	@key bigint
)
AS
	SET NOCOUNT ON;
	
SELECT ResultCategoryId,
	ResultCategoryKey,
	ResultCategoryDesc, 
	DiagnosticCode
FROM RESULT_CATEGORY
WHERE ResultCategoryKey = @key;

