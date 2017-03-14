
CREATE PROCEDURE [dbo].[upODS_PrescriptionAction] AS

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

EXEC dbo.upActivityLog 'Begin Presc Action',0,@day;

DECLARE curAction CURSOR FAST_FORWARD FOR
SELECT DISTINCT ACTION_
FROM	vwMDE_PRESCRIPTION$FILL_DATES
WHERE ACTION_ IS NOT NULL
ORDER BY ACTION_

OPEN curAction
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Presc Action',0
FETCH NEXT FROM curAction INTO @desc
if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@descX = PrescriptionActionDesc
		FROM NHJAX_ODS.dbo.PRESCRIPTION_ACTION
		WHERE PrescriptionActionDesc = @desc
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PRESCRIPTION_ACTION(
				PrescriptionActionDesc)
				VALUES(@desc);
				SET @irow = @irow + 1
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM curAction INTO @desc
	COMMIT
	END

END
CLOSE curAction
DEALLOCATE curAction
SET @surow = 'Presc Action Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Presc Action Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Presc Action Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Presc Action',0,@day;
