
create PROCEDURE [dbo].[procODS_HCDP_COVERAGE_SelectbyCode]
(
	@cd varchar(3)
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
	(HcdpCoverageCode = @cd)
