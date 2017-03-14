
create PROCEDURE [dbo].[procODS_MILITARY_GRADE_RANK_UpdateDesc]
(
	@key numeric(10,3),
	@desc varchar(30)
)
AS
	SET NOCOUNT ON;
	
UPDATE MILITARY_GRADE_RANK
SET MilitaryGradeRankDesc = @desc,
	UpdatedDate = Getdate()
WHERE MilitaryGradeRankKey = @key;

