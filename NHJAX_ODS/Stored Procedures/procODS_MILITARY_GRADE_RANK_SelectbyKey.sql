
create PROCEDURE [dbo].[procODS_MILITARY_GRADE_RANK_SelectbyKey]
(
	@key numeric(10,3)
)
AS
	SET NOCOUNT ON;
SELECT 	
	MilitaryGradeRankId,
	MilitaryGradeRankKey, 
	MilitaryGradeRankDesc,
	MilitaryGradeRankCode,
	MilitaryGradeRankAbbrev,
	MilitaryGradeRankPayGrade,
	CreatedDate,
	UpdatedDate
FROM
	MILITARY_GRADE_RANK
WHERE 	
	(MilitaryGradeRankKey = @key)
