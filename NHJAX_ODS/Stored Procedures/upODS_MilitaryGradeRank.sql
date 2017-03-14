
CREATE PROCEDURE [dbo].[upODS_MilitaryGradeRank] AS
if exists(SELECT * FROM dbo.sysobjects WHERE name = '#Temp')
BEGIN
DROP TABLE #Temp;
END
Declare @trow int
Declare @urow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @loop int
Declare @exists int
Declare @gradekey varchar(15)
Declare @gradedesc varchar(30)
Declare @gradecode varchar(4)
Declare @gradeabbv varchar(4)
Declare @grade varchar(2)
Declare @gradekeyX varchar(15)
Declare @gradedescX varchar(30)
Declare @gradecodeX varchar(4)
Declare @gradeabbvX varchar(4)
Declare @gradeX varchar(2)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Military Grade Rank',0,@day;
Select Identity(int,1,1) ID,
	KEY_MILITARY_GRADE_RANK, 
	NAME, 
	CODE,
	ABBREVIATION,
	PAYGRADE
	into #Temp 
	FROM vwMDE_MILITARY_GRADE_RANK
SET @loop = @@rowcount
SET @today = getdate()
SET @urow = 0
SET @irow = 0
SET @trow = 1
While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	
	Select @gradekey = KEY_MILITARY_GRADE_RANK, 
	@gradedesc = NAME, 
	@gradecode = CODE,
	@gradeabbv = ABBREVIATION,
	@grade	= PAYGRADE
	from #Temp 
	Where ID = @trow
		
	Select @gradekeyX = MilitaryGradeRankKey, 
	@gradedescX = MilitaryGradeRankDesc, 
	@gradecodeX = MilitaryGradeRankCode,
	@gradeabbvX = MilitaryGradeRankAbbrev,
	@gradeX = MilitaryGradeRankPayGrade
	from NHJAX_ODS.dbo.MILITARY_GRADE_RANK 
	Where MilitaryGradeRankKey = @gradekey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.MILITARY_GRADE_RANK(MilitaryGradeRankKey,
			MilitaryGradeRankDesc, 
			MilitaryGradeRankCode,
			MilitaryGradeRankAbbrev,
			MilitaryGradeRankPayGrade) 
		VALUES(@gradekey, 
			@gradedesc, 
			@gradecode,
			@gradeabbv,
			@grade);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @gradedesc <> @gradedescX
		OR @gradecode <> @gradecodeX
		OR @gradeabbv <> @gradeabbvX
		OR @grade <> @gradeX
		OR (@gradedesc Is Not Null AND @gradedescX Is Null)
		OR (@gradecode Is Not Null AND @gradecodeX Is Null)
		OR (@gradeabbv Is Not Null AND @gradeabbvX Is Null)
		OR (@grade Is Not Null AND @gradeX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.MILITARY_GRADE_RANK
			SET MilitaryGradeRankDesc = @gradedesc,
			MilitaryGradeRankCode = @gradecode,
			MilitaryGradeRankAbbrev = @gradeabbv,
			MilitaryGradeRankPayGrade = @grade,
			UpdatedDate = @today
			WHERE MilitaryGradeRankKey = @gradekey;
			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'Military Grade Rank Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Military Grade Rank Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Military Grade Rank Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Military Grade Rank',0,@day;
Drop table #Temp
