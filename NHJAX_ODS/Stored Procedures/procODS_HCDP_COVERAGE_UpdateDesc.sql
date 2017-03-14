
create PROCEDURE [dbo].[procODS_HCDP_COVERAGE_UpdateDesc]
(
	@key numeric(9,3),
	@desc varchar(125)
)
AS
	SET NOCOUNT ON;
	
UPDATE HCDP_COVERAGE
SET HcdpCoverageDesc = @desc,
	UpdatedDate = Getdate()
WHERE HcdpCoverageKey = @key;

