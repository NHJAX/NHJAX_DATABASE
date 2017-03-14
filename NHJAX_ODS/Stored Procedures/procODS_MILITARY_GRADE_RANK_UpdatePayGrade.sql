
create PROCEDURE [dbo].[procODS_MILITARY_GRADE_RANK_UpdatePayGrade]
(
	@key numeric(10,3),
	@pg varchar(2)
)
AS
	SET NOCOUNT ON;
	
UPDATE MILITARY_GRADE_RANK
SET MilitaryGradeRankPayGrade = @pg,
	UpdatedDate = Getdate()
WHERE MilitaryGradeRankKey = @key;

