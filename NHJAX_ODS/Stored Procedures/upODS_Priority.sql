
CREATE PROCEDURE [dbo].[upODS_Priority] AS

Declare @desc varchar(30)
Declare @descX varchar(30)
Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Priority',0,@day;
DECLARE curPri CURSOR FAST_FORWARD FOR
SELECT	DISTINCT PRIORITY
FROM	vwMDE_PATIENT_APPOINTMENT
WHERE PRIORITY IS NOT NULL
OPEN curPri
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Priority',0
FETCH NEXT FROM curPri INTO @desc
if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@descX = PriorityDesc
		FROM NHJAX_ODS.dbo.PRIORITY
		WHERE PriorityDesc = @desc
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PRIORITY(
				PriorityDesc)
				VALUES(@desc);
				SET @irow = @irow + 1
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM curPri INTO @desc
	COMMIT
	END

END
CLOSE curPri
DEALLOCATE curPri
SET @surow = 'Priority Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Priority Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Priority Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Rad Type',0,@day;
