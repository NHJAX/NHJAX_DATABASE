
CREATE PROCEDURE [dbo].[upODS_StatusModifier] AS

Declare @status varchar(30)
Declare @statusX varchar(30)

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Status Modifier',0,@day

DECLARE curStat CURSOR FAST_FORWARD FOR
	SELECT DISTINCT STATUS_MODIFIER
	FROM vwMDE_APPOINTMENT_AUDIT_TRAIL 
	WHERE STATUS_MODIFIER IS NOT NULL
OPEN curStat
SET @trow = 0
SET @irow = 0
FETCH NEXT FROM curStat INTO @status
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		SELECT @statusX = StatusModifierDesc FROM NHJAX_ODS.dbo.STATUS_MODIFIER
			WHERE StatusModifierDesc = @status

			SET @exists = @@RowCount
			If @exists = 0
				BEGIN
					INSERT INTO NHJAX_ODS.dbo.STATUS_MODIFIER(StatusModifierDesc)
					VALUES(@status);
					SET @irow = @irow + 1
				END
		SET @trow = @trow + 1
		FETCH NEXT FROM curStat INTO @status
	COMMIT	
	END
	
END
CLOSE curStat
DEALLOCATE curStat
SET @sirow = 'Status Modifier Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Status Modifier Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

EXEC dbo.upActivityLog 'End Status Modifier',0,@day
