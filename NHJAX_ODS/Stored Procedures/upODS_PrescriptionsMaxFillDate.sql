

CREATE PROCEDURE [dbo].[upODS_PrescriptionsMaxFillDate] AS
Declare @pre decimal
Declare @supply numeric(10,3)
Declare @fill datetime

Declare @preX decimal
Declare @supplyX numeric(10,3)
Declare @fillX datetime

Declare @urow int
Declare @trow int
Declare @surow varchar(50)
Declare @strow varchar(50)
Declare @fromDate datetime
Declare @tempDate datetime

SET @tempDate = DATEADD(d,-60,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Prescription/Fill Date',0,@day;

DECLARE	curPrescription CURSOR FAST_FORWARD FOR 
SELECT DISTINCT  
	MAX.PrescriptionId, 
	MAX.MaxFillDate, 
	FILL.DaysSupply
FROM         
	PRESCRIPTION_FILL_DATE AS FILL 
	INNER JOIN vwODS_MaxFillDatebyPrescriptionId AS MAX 
	ON FILL.PrescriptionId = MAX.PrescriptionId 
	AND FILL.FillDate = MAX.MaxFillDate
WHERE MAX.MaxFillDate >= @fromDate

OPEN curPrescription
SET @trow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Prescription/Fill Date',0
FETCH NEXT FROM curPrescription INTO @pre,@fill,@supply

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@preX = PrescriptionId,
			@supplyX = DaysSupply,
			@fillX = LastFillDate
		FROM NHJAX_ODS.dbo.PRESCRIPTION
		WHERE PrescriptionId = @pre
		
		IF	@supply <> @supplyX
		OR	@fill <> @fillX
		OR 	(@supply Is Not Null AND @supplyX Is Null)
		OR 	(@fill Is Not Null AND @fillX Is Null)
			BEGIN
			
			UPDATE NHJAX_ODS.dbo.PRESCRIPTION
			SET 	
				DaysSupply = @supply,
				LastFillDate = @fill,
				UpdatedDate = getdate()
			WHERE PrescriptionId = @pre;
			SET @urow = @urow + 1
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM curPrescription INTO @pre,@fill,@supply
		
	COMMIT	
	END
END

CLOSE curPrescription
DEALLOCATE curPrescription

SET @surow = 'Prescription/Fill Date Updated: ' + CAST(@urow AS varchar(50))
SET @strow = 'Prescription/Fill Date Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Prescription/Fill Date',0,@day;

