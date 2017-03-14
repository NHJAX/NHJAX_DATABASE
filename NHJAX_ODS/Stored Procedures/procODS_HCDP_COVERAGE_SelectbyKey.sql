
create PROCEDURE [dbo].[procODS_HCDP_COVERAGE_SelectbyKey]
(
	@key numeric(9,3)
)
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
WHERE 	
	(HcdpCoverageKey = @key)
