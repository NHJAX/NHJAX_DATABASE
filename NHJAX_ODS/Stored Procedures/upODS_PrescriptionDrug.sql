






CREATE PROCEDURE [dbo].[upODS_PrescriptionDrug] AS
Declare @pre bigint
Declare @drug bigint

Declare @preX bigint
Declare @drugX bigint

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

EXEC dbo.upActivityLog 'Begin Prescription Drug',0,@day;

SET @tempDate = DATEADD(d,-30,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 

DECLARE	curPrescription CURSOR FAST_FORWARD FOR 
SELECT DISTINCT	PrescriptionId,
		DrugId
FROM    PRESCRIPTION
WHERE  	(LastFillDate >= @fromDate)
AND DrugId IS NOT NULL

OPEN curPrescription
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch Prescription Drug',0
FETCH NEXT FROM curPrescription INTO @pre,@drug

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@drugX = DrugId
		FROM NHJAX_ODS.dbo.PRESCRIPTION_DRUG
		WHERE PrescriptionId = @pre
		AND DrugId = @drug
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PRESCRIPTION_DRUG(
				PrescriptionId,
				DrugId)
				VALUES(@pre,@drug);
				SET @irow = @irow + 1
			END
		
		SET @trow = @trow + 1
		FETCH NEXT FROM curPrescription INTO @pre,@drug
		
	COMMIT	
	END
END

CLOSE curPrescription
DEALLOCATE curPrescription

SET @sirow = 'Prescription Drug Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Prescription Drug Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Prescription Drug',0,@day;






