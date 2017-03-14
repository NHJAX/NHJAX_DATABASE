
CREATE PROCEDURE [dbo].[procODS_MATERNITY_TEAM_Select]

AS
	SET NOCOUNT ON;
SELECT 	
	MaternityTeamId,
	MaternityTeamDesc,
	CreatedDate,
	Inactive
FROM
	MATERNITY_TEAM
WHERE Inactive = 0
AND MaternityTeamId > 0
ORDER BY MaternityTeamDesc
