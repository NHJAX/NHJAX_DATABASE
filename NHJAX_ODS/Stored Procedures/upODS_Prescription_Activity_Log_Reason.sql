


CREATE PROCEDURE [dbo].[upODS_Prescription_Activity_Log_Reason] AS

Declare @key numeric(9,3)
Declare @reason varchar(20)

Declare @keyX numeric(9,3)
Declare @reasonX varchar(20)

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

EXEC dbo.upActivityLog 'Begin Prescription Activity Log Reason',0,@day;

DECLARE	curReason CURSOR FAST_FORWARD FOR 

SELECT		KEY_RX_ACTIVITY_CODE_REASON
		   ,REASON

FROM         vwMDE_RX_ACTIVITY_LOG_REASON

OPEN curReason
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Prescription Activity Log Reason',0
FETCH NEXT FROM curReason INTO @key,@reason

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@keyX = ReasonCodeKey,
			@reasonX = ReasonDesc

		FROM NHJAX_ODS.dbo.PRESCRIPTION_ACTIVITY_LOG_REASON
		WHERE ReasonCodeKey = @key
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PRESCRIPTION_ACTIVITY_LOG_REASON(
				ReasonCodeKey,
				ReasonDesc
				)
				
				VALUES(@key,@reason);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@key <> @keyX
		OR	@reason <> @reasonX
		OR 	(@key Is Not Null AND @keyX Is Null)
		OR 	(@reason Is Not Null AND @reasonX Is Null)
			BEGIN			
			UPDATE NHJAX_ODS.dbo.PRESCRIPTION_ACTIVITY_LOG_REASON
			SET 	ReasonCodeKey = @key,
				ReasonDesc = @reason

			WHERE ReasoncodeKey = @key;
			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curReason INTO @key,@reason
		
	COMMIT	
	END
END

CLOSE curReason
DEALLOCATE curReason

SET @surow = 'Prescription Activity Log Reason Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Prescription Activity Log Reason Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Prescription Activity Log Reason Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Prescription Activity Log Reason',0,@day;


