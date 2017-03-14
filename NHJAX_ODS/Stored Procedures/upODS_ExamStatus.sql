
CREATE PROCEDURE [dbo].[upODS_ExamStatus] AS

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

Declare @examkey numeric(8,3)
Declare @examdesc varchar(30)

Declare @examkeyX numeric(8,3)
Declare @examdescX varchar(30)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Exam Status',0,@day;

Select Identity(int,1,1) ID,
	KEY_EXAMINATION_STATUS, 
	STATUS
	into #Temp 
	FROM vwMDE_EXAMINATION_STATUS
SET @loop = @@rowcount

SET @urow = 0
SET @irow = 0
SET @trow = 1

While @trow <= @loop
BEGIN
	
	Select @examkey = KEY_EXAMINATION_STATUS, 
	@examdesc = STATUS
	from #Temp 
	Where ID = @trow
		
	Select @examkeyX = ExamStatusKey, 
	@examdescX = ExamStatusDesc 
	from NHJAX_ODS.dbo.EXAM_STATUS 
	Where ExamStatusKey = @examkey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.EXAM_STATUS(ExamStatusKey,
			ExamStatusDesc) 
		VALUES(@examkey, 
			@examdesc);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		SET @today = getdate()
		If @examdesc <> @examdescX
		OR (@examdesc Is Not Null AND @examdescX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.EXAM_STATUS
			SET ExamStatusDesc = @examdesc,
			UpdatedDate = @today
			WHERE ExamStatusKey = @examkey;

			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
END
SET @trow = @trow - 1
SET @surow = 'Exam Status Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Exam Status Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Exam Status Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Exam Status',0,@day;
Drop table #Temp
