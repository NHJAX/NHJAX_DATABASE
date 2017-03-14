
CREATE PROCEDURE [dbo].[procODS_MILITARY_GRADE_RANK_SelectbyCode]
(
	@cd varchar(4)
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
	(MilitaryGradeRankCode = @cd)
