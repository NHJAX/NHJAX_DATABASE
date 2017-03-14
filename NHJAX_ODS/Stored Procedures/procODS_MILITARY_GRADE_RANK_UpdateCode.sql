
create PROCEDURE [dbo].[procODS_MILITARY_GRADE_RANK_UpdateCode]
(
	@key numeric(10,3),
	@code varchar(4)
)
AS
	SET NOCOUNT ON;
	
UPDATE MILITARY_GRADE_RANK
SET MilitaryGradeRankCode = @code,
	UpdatedDate = Getdate()
WHERE MilitaryGradeRankKey = @key;

