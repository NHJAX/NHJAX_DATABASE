

CREATE PROCEDURE [dbo].[upODS_Pharmacy] AS

Declare @phar varchar(30)
Declare @pharX varchar(30)

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Pharmacy',0,@day

DECLARE curPhar CURSOR FAST_FORWARD FOR
	SELECT DISTINCT ACCEPTED_PHARMACY_NAME
	FROM vwMDE_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL AS PDTSDTL
	WHERE (ACCEPTED_PHARMACY_NAME IS NOT NULL)
	ORDER BY ACCEPTED_PHARMACY_NAME
OPEN curPhar
SET @trow = 0
SET @irow = 0
FETCH NEXT FROM curPhar INTO @phar
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		SELECT @pharX = PharmacyDesc FROM NHJAX_ODS.dbo.PHARMACY
			WHERE PharmacyDesc = @phar

			SET @exists = @@RowCount
			If @exists = 0
				BEGIN
					INSERT INTO NHJAX_ODS.dbo.PHARMACY(PharmacyDesc)
					VALUES(@phar);
					SET @irow = @irow + 1
				END
		SET @trow = @trow + 1
		FETCH NEXT FROM curPhar INTO @phar
	COMMIT	
	END
	
END
CLOSE curPhar
DEALLOCATE curPhar
SET @sirow = 'Pharmacy Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Pharmacy Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

EXEC dbo.upActivityLog 'End Pharmacy',0,@day

