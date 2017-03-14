
create PROCEDURE [dbo].[procODS_MILITARY_GRADE_RANK_UpdateAbbrev]
(
	@key numeric(10,3),
	@abv varchar(4)
)
AS
	SET NOCOUNT ON;
	
UPDATE MILITARY_GRADE_RANK
SET MilitaryGradeRankAbbrev = @abv,
	UpdatedDate = Getdate()
WHERE MilitaryGradeRankKey = @key;

