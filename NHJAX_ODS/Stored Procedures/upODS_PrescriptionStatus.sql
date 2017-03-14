
CREATE PROCEDURE [dbo].[upODS_PrescriptionStatus] AS
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

EXEC dbo.upActivityLog 'Begin Prescription Status',0,@day

DECLARE curPreStat CURSOR FAST_FORWARD FOR
	SELECT DISTINCT STATUS
	FROM vwMDE_PRESCRIPTION
OPEN curPreStat
SET @trow = 0
SET @irow = 0
FETCH NEXT FROM curPreStat INTO @status
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		SELECT @statusX = PreStatusDesc FROM NHJAX_ODS.dbo.PRESCRIPTION_STATUS
			WHERE PreStatusDesc = @status

			SET @exists = @@RowCount
			If @exists = 0
				BEGIN
					INSERT INTO NHJAX_ODS.dbo.PRESCRIPTION_STATUS(PreStatusDesc)
					VALUES(@status);
					SET @irow = @irow + 1
				END
		SET @trow = @trow + 1
		FETCH NEXT FROM curPreStat INTO @status
	COMMIT	
	END
	
END
CLOSE curPreStat
DEALLOCATE curPreStat
SET @sirow = 'Prescrip Status Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Prescrip Status Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

EXEC dbo.upActivityLog 'End Prescription Status',0,@day
