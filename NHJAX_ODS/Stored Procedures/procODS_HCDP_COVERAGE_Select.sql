
create PROCEDURE [dbo].[procODS_HCDP_COVERAGE_Select]

AS
	SET NOCOUNT ON;
SELECT 	
	HcdpCoverageId,
	HcdpCoverageKey, 
	HcdpCoverageCode,
	HcdpCoverageDesc,
	CreatedDate,
	UpdatedDate
FROM
	HCDP_COVERAGE

