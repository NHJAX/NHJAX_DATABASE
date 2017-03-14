
CREATE PROCEDURE [dbo].[upODS_CDM_IMMUNIZATION_MANUFACTURER] AS

Declare @desc varchar(50)

Declare @idX bigint

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)

Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin CDM Immunization Manufacturer',3,@day;

DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT
	ImmunizationManufacturer
FROM vwSTG_IMMUNIZATIONS
WHERE ImmunizationManufacturer IS NOT NULL

OPEN cur
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch CDM Immunization Manufacturer',3
FETCH NEXT FROM cur INTO @desc

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@idX = ImmunizationManufacturerId
		FROM NHJAX_ODS.dbo.IMMUNIZATION_MANUFACTURER
		WHERE	ImmunizationManufacturerDesc = @desc
		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN
			
				INSERT INTO NHJAX_ODS.dbo.IMMUNIZATION_MANUFACTURER(
				ImmunizationManufacturerDesc)
				VALUES(@desc);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @desc
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'CDM Immunization Manufacturer Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'CDM Immunization Manufacturer Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,3;
EXEC dbo.upActivityLog @strow,3;
EXEC dbo.upActivityLog 'End CDM Immunization Manufacturer',3,@day;

PRINT @sirow
PRINT @strow