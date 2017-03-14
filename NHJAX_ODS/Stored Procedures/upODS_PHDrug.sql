

CREATE PROCEDURE [dbo].[upODS_PHDrug] AS
Declare @desc varchar(30)
Declare @descX varchar(30)
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

EXEC dbo.upActivityLog 'Begin PH Drug',0,@day;

DECLARE curPHDrug CURSOR FAST_FORWARD FOR
SELECT	CtrlDrugName AS DrugDesc
FROM	vwSTG_POP_HEALTH_ASTHMA
WHERE	(CtrlDrugName IS NOT NULL)
UNION
SELECT	Steroid AS DrugDesc
FROM	vwSTG_POP_HEALTH_ASTHMA AS POP_HEALTH_ASTHMA_1
WHERE	(Steroid IS NOT NULL)
UNION
SELECT [Last Prescription Name] AS DrugDesc
FROM vwSTG_POP_HEALTH_ANTIDEPRESSANT
WHERE [Last Prescription Name] IS NOT NULL

OPEN curPHDrug
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch PH Drug',0
FETCH NEXT FROM curPHDrug INTO @desc
if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@descX = DrugDesc
		FROM NHJAX_ODS.dbo.DRUG
		WHERE DrugDesc = @desc
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.DRUG(
				DrugDesc, SourceSystemId)
				VALUES(@desc,6);
				SET @irow = @irow + 1
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM curPHDrug INTO @desc
	COMMIT
	END

END
CLOSE curPHDrug
DEALLOCATE curPHDrug
SET @surow = 'PH Drug Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'PH Drug Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Drug Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PH Drug',0,@day;

