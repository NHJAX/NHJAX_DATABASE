
-- ============================================================
-- Author:		Robert E Evans
-- Create date: 7 Oct 2011
-- Description:	Searchs Stored Procedures for a specific string
-- ============================================================
CREATE PROCEDURE [dbo].[FindSPWithText] 
	@InputString nvarchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE	@SearchString as nvarchar(102)

SET @SearchString = '%' + RTRIM(LTRIM(@InputString)) + '%'
	
SELECT ROUTINE_NAME, ROUTINE_DEFINITION 
    FROM INFORMATION_SCHEMA.ROUTINES 
    WHERE ROUTINE_DEFINITION LIKE @SearchString
    AND ROUTINE_TYPE='PROCEDURE'
END


