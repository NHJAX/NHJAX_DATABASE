






CREATE PROCEDURE [dbo].[upODS_PDTSPrescriptionFillDate] AS

Declare @pred bigint
Declare @fill datetime
Declare @sup numeric(10,3)
Declare @pre bigint

Declare @predX bigint
Declare @fillX datetime
Declare @supX numeric(10,3)
Declare @preX bigint

Declare @fromDate datetime
Declare @tempDate datetime
Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)

Declare @today datetime
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin PDTS Prescription Fill',0,@day;

SET @tempDate = DATEADD(d,-30,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate);

DECLARE	curPreFill CURSOR FAST_FORWARD FOR 
SELECT DISTINCT 
	PRESCRIPTION_DRUG.PrescriptionDrugId, 
	vwPDTSCombinedInfo_Fill.ACCEPTED_DATE_FILLED, 
	vwPDTSCombinedInfo_Fill.ACCEPTED_DAYS_SUPPLY,
	PRESCRIPTION.PrescriptionId
FROM PRESCRIPTION_DRUG 
	INNER JOIN PRESCRIPTION 
	ON PRESCRIPTION_DRUG.PrescriptionId = PRESCRIPTION.PrescriptionId 
	RIGHT OUTER JOIN vwPDTSCombinedInfo_Fill
	INNER JOIN DRUG 
	ON vwPDTSCombinedInfo_Fill.AcceptedNDCNumber = DRUG.NDCNumber 
	ON PRESCRIPTION_DRUG.DrugId = DRUG.DrugId 
	AND PRESCRIPTION.PharmacyId = vwPDTSCombinedInfo_Fill.PharmacyId 
	AND PRESCRIPTION.PatientId = vwPDTSCombinedInfo_Fill.PatientId 
	AND PRESCRIPTION.RXNumber = vwPDTSCombinedInfo_Fill.AcceptedPrescriptionNumber
WHERE (DRUG.DrugDesc NOT LIKE 'XX%')
AND   (vwPDTSCombinedInfo_Fill.ACCEPTED_DATE_FILLED >= @fromDate)

OPEN curPreFill
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch PDTS Prescription Fill',0
FETCH NEXT FROM curPreFill INTO @pred,@fill,@sup,@pre

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@predX = PrescriptionDrugId,
			@fillX = FillDate,
			@supX = DaysSupply,
			@preX = PrescriptionId
		FROM NHJAX_ODS.dbo.PRESCRIPTION_FILL_DATE
		WHERE PrescriptionDrugId = @pred
		AND FillDate = @fill
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PRESCRIPTION_FILL_DATE(
				PrescriptionDrugId,
				FillDate,
				DaysSupply,
				PrescriptionId)
				VALUES(@pred,@fill,@sup,@pre);
				SET @irow = @irow + 1
			END

		
		SET @trow = @trow + 1
		FETCH NEXT FROM curPreFill INTO @pred,@fill,@sup,@pre
		
	COMMIT	
	END
END

CLOSE curPreFill
DEALLOCATE curPreFill
SET @surow = 'PDTS Prescription Fill Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'PDTS Prescription Fill Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PDTS Prescription Fill Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PDTS Prescription Fill',0,@day;






