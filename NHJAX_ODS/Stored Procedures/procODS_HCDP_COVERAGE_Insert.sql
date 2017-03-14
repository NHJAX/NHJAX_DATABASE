
create PROCEDURE [dbo].[procODS_HCDP_COVERAGE_Insert]
(
	@key numeric(9,3),
	@cd varchar(3),
	@desc varchar(125)
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.HCDP_COVERAGE
(
	HcdpCoverageKey,
	HcdpCoverageCode,
	HcdpCoverageDesc
) 
VALUES
(
	@key, 
	@cd,
	@desc
);
SELECT SCOPE_IDENTITY();