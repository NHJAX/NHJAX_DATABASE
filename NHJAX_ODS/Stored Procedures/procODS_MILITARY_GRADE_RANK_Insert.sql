
CREATE PROCEDURE [dbo].[procODS_MILITARY_GRADE_RANK_Insert]
(
	@key numeric(8,3),
	@abbr varchar(4),
	@cd varchar(4),
	@desc varchar(30),
	@pay varchar(2)
)
AS
	SET NOCOUNT ON;
	
INSERT INTO NHJAX_ODS.dbo.MILITARY_GRADE_RANK
(
	MilitaryGradeRankKey,
	MilitaryGradeRankAbbrev,
	MilitaryGradeRankCode,
	MilitaryGradeRankDesc,
	MilitaryGradeRankPayGrade
) 
VALUES
(
	@key, 
	@abbr,
	@cd,
	@desc,
	@pay
);
SELECT SCOPE_IDENTITY();