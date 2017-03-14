-- =============================================
-- Author:		Robert Evans
-- Create date: 31 July 2013
-- Description:	Gets a list for dropdowns of Patient Flags
-- =============================================
CREATE PROCEDURE [dbo].[procODS_Patient_Flags_Lookup]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 0 as idNumber,'All Categories' as FlagDesc, '0000000000' as SortBy
	UNION
	SELECT [FlagId]
		  ,[FlagDesc]
		  ,[FlagDesc]
	FROM [FLAG]
	ORDER BY SortBy

END
