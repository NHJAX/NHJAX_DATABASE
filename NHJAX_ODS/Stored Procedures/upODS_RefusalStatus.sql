
CREATE PROCEDURE [dbo].[upODS_RefusalStatus] AS
Declare @desc varchar(30)

Declare @descX varchar(30)

Declare @trow int
Declare @irow int

Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Refusal Status',0,@day;
DECLARE curRef CURSOR FAST_FORWARD FOR
SELECT	DISTINCT REFUSAL_STATUS
FROM	vwMDE_MCP_REFERRAL$APPOINTMENT_REFUSALS
WHERE REFUSAL_STATUS IS NOT NULL
OPEN curRef
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch Refusal Status',0
FETCH NEXT FROM curRef INTO @desc
if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@descX = RefusalStatusDesc
		FROM NHJAX_ODS.dbo.REFUSAL_STATUS
		WHERE RefusalStatusDesc = @desc
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.REFUSAL_STATUS(
				RefusalStatusDesc)
				VALUES(@desc);
				SET @irow = @irow + 1
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM curRef INTO @desc
	COMMIT
	END

END
CLOSE curRef
DEALLOCATE curRef

SET @sirow = 'Refusal Status Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Refusal Status Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Refusal Status',0,@day;

