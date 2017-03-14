
CREATE PROCEDURE [dbo].[upODS_LabResultBacteriologyAppended] AS

Declare @tst bigint
Declare @apd datetime

Declare @tstX bigint
Declare @apdX datetime

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)

Declare @fromDate datetime
Declare @tempDate datetime
Declare @today datetime
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Bacteriology Appnded',0,@day;

SET @tempDate = DATEADD(d,-30,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 

DECLARE curApd CURSOR FOR
SELECT	TST.LabResultBacteriologyTestId, 
	AMD.APPENDED_AMENDED_RNR_DATE_TIME
FROM    LAB_RESULT_BACTERIOLOGY_TEST TST 
	INNER JOIN vwMDE_LAB_RESUL$BACTERIOL$TEST$APPENDED_AMENDED_RNR AMD 
	ON TST.LabResultTestKey = AMD.KEY_LAB_RESULT$BACTERIOLOGY$TEST 
	AND TST.LabResultSubKey = AMD.KEY_LAB_RESULT$BACTERIOLOGY 
	AND TST.LabResultKey = AMD.KEY_LAB_RESULT
WHERE AMD.APPENDED_AMENDED_RNR_DATE_TIME >= @fromDate

OPEN curApd
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch Bacteriology Appnded',0

FETCH NEXT FROM curApd INTO @tst,@apd

if(@@FETCH_STATUS = 0)

BEGIN
BEGIN TRANSACTION
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		Select 	@tstX = LabResultBacteriologyTestId
		FROM 	NHJAX_ODS.dbo.LAB_RESULT_BACTERIOLOGY_APPENDED
		WHERE 	LabResultBacteriologyTestId = @tst
		AND	AppendDate = @apd

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.LAB_RESULT_BACTERIOLOGY_APPENDED(
				LabResultBacteriologyTestId,AppendDate)
				VALUES(@tst,@apd);
				SET @irow = @irow + 1
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM curApd INTO @tst,@apd
	END
COMMIT
END

CLOSE curApd
DEALLOCATE curApd

SET @sirow = 'Bacteriology Appnded Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Bacteriology Appnded Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

EXEC dbo.upActivityLog 'End Bacteriology Appnded',0,@day;
