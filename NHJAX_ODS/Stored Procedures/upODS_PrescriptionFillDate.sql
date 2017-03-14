





CREATE PROCEDURE [dbo].[upODS_PrescriptionFillDate] AS

Declare @key numeric(8,3)
Declare @pred bigint
Declare @fill datetime
Declare @act bigint
Declare @disp datetime
Declare @sup numeric(10,3)
Declare @pre bigint
Declare @log bigint
Declare @lbl datetime

Declare @keyX numeric(8,3)
Declare @predX bigint
Declare @fillX datetime
Declare @actX bigint
Declare @dispX datetime
Declare @supX numeric(10,3)
Declare @preX bigint
Declare @logX bigint
Declare @lblX datetime

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

EXEC dbo.upActivityLog 'Begin Prescription Fill',0,@day;

SET @tempDate = DATEADD(d,-100,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate);

DECLARE	curPreFill CURSOR FAST_FORWARD FOR 
SELECT
	vwMDE_PRESCRIPTION$FILL_DATES.KEY_PRESCRIPTION$FILL_DATES, 
	PRESCRIPTION_DRUG.PrescriptionDrugId, 
	vwMDE_PRESCRIPTION$FILL_DATES.FILL_DATES, 
    ISNULL(PRE_ACT.PrescriptionActionId, 0) AS PrescriptionActionId, 
	vwMDE_PRESCRIPTION$FILL_DATES.DISPENSED_DATE,
	PRE.DaysSupply,
	PRE.PrescriptionId,
	vwMDE_PRESCRIPTION$FILL_DATES.LOGGED_BY_IEN,
	vwMDE_PRESCRIPTION$FILL_DATES.LABEL_PRINT_DATE_TIME
FROM PRESCRIPTION AS PRE 
	INNER JOIN vwMDE_PRESCRIPTION$FILL_DATES 
	ON PRE.PrescriptionKey = vwMDE_PRESCRIPTION$FILL_DATES.KEY_PRESCRIPTION 
	INNER JOIN PRESCRIPTION_ACTION AS PRE_ACT 
	ON vwMDE_PRESCRIPTION$FILL_DATES.ACTION_ = PRE_ACT.PrescriptionActionDesc 
	INNER JOIN PRESCRIPTION_DRUG 
	ON PRE.DrugId = PRESCRIPTION_DRUG.DrugId 
	AND PRE.PrescriptionId = PRESCRIPTION_DRUG.PrescriptionId
WHERE     (vwMDE_PRESCRIPTION$FILL_DATES.FILL_DATES >= @fromDate)

OPEN curPreFill
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Prescription Fill',0
FETCH NEXT FROM curPreFill INTO @key,@pred,@fill,@act,@disp,@sup,@pre,@log,@lbl

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@keyX = PrescriptionFillDateKey,
			@predX = PrescriptionDrugId,
			@fillX = FillDate,
			@actX = PrescriptionActionId,
			@dispX = DispensedDate,
			@supX = DaysSupply,
			@preX = PrescriptionId,
			@logX = LoggedBy,
			@lblX = LabelPrintDateTime
		FROM NHJAX_ODS.dbo.PRESCRIPTION_FILL_DATE
		WHERE PrescriptionFillDateKey = @key
		AND PrescriptionDrugId = @pred
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PRESCRIPTION_FILL_DATE(
				PrescriptionFillDateKey,
				PrescriptionDrugId,
				FillDate,
				PrescriptionActionId,
				DispensedDate,
				DaysSupply,
				PrescriptionId,
				LoggedBy,
				LabelPrintDateTime)
				VALUES(@key,@pred,@fill,@act,@disp,@sup,@pre,@log,@lbl);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@fill <> @fillX
		OR	@act <> @actX
		OR	@disp <> @dispX
		OR	@sup <> @supX
		OR	@pre <> @preX
		OR 	(@fill Is Not Null AND @fillX Is Null)
		OR 	(@act Is Not Null AND @actX Is Null)
		OR 	(@disp Is Not Null AND @dispX Is Null)
		OR	(@sup Is Not Null AND @supX Is Null)
		OR	(@pre Is Not Null AND @preX Is Null)
			BEGIN
			SET @today = getdate()
			UPDATE NHJAX_ODS.dbo.PRESCRIPTION_FILL_DATE
			SET 	FillDate = @fill,
				PrescriptionActionId = @act,
				DispensedDate = @disp,
				DaysSupply = @sup,
				PrescriptionId = @pre,
				UpdatedDate = @today
			WHERE PrescriptionFillDateKey = @key
			AND PrescriptionDrugId = @pred;
			SET @urow = @urow + 1
			END
			
			IF @log <> @logX
				OR (@log Is Not Null AND @logX Is Null)
				BEGIN
					UPDATE PRESCRIPTION_FILL_DATE
					SET LoggedBy = @log,
						UpdatedDate = GETDATE()
					WHERE PrescriptionFillDateKey = @key
					AND PrescriptionDrugId = @pred;
				END
				
			IF @lbl <> @lblX
				OR (@lbl Is Not Null AND @lblX Is Null)
				BEGIN
					UPDATE PRESCRIPTION_FILL_DATE
					SET LabelPrintDateTime = @log,
						UpdatedDate = GETDATE()
					WHERE PrescriptionFillDateKey = @key
					AND PrescriptionDrugId = @pred;
				END
			
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curPreFill INTO @key,@pred,@fill,@act,@disp,
			@sup,@pre,@log,@lbl
		
	COMMIT	
	END
END

CLOSE curPreFill
DEALLOCATE curPreFill
SET @surow = 'Prescription Fill Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Prescription Fill Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Prescription Fill Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Prescription Fill',0,@day;





