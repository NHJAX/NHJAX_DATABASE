
CREATE PROCEDURE [dbo].[upEDPTS_Result_Category_SelectbyKey]
	@res decimal
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT ResultCategoryId,
	ResultCategoryKey,
	DiagnosticCode 
	FROM RESULT_CATEGORY  
	WHERE (ResultCategoryKey = @res)
END

