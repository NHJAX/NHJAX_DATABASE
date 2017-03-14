
CREATE PROCEDURE [dbo].[upODS_LabResultAntibiotic] AS

Declare @org bigint
Declare @susc bigint
Declare @inter bigint
Declare @sens varchar(10)
Declare @anti numeric(9,3)

Declare @orgX bigint
Declare @suscX bigint
Declare @interX bigint
Declare @sensX varchar(10)
Declare @antiX numeric(9,3)

Declare @trow int
Declare @irow int

Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Lab Result Antibiotic',0,@day;

DECLARE curAnti CURSOR FAST_FORWARD FOR
SELECT	ORG.LabResultOrganismId, 
	SUSC.AntibioticSusceptibilityId, 
	INTER.LabInterpretationId, 
	ANTI.SENSITIVITY, 
        ANTI.KEY_LAB_RESUL$BACTERIOL$TEST$ORGANISM$ANTIBIOTIC2
FROM    LAB_RESULT_ORGANISM ORG 
	INNER JOIN vwMDE_LAB_RESUL$BACTERIOL$TEST$ORGANISM$ANTIBIOTIC2 ANTI 
	ON ORG.LabResultOrganismKey = ANTI.KEY_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM 
	AND ORG.LabResultTestKey = ANTI.KEY_LAB_RESULT$BACTERIOLOGY$TEST 
	AND ORG.LabResultSubKey = ANTI.KEY_LAB_RESULT$BACTERIOLOGY 
	AND ORG.LabResultKey = ANTI.KEY_LAB_RESULT 
	INNER JOIN ANTIBIOTIC_SUSCEPTIBILITY SUSC 
	ON ANTI.ANTIBIOTIC_IEN = SUSC.AntibioticSusceptibilityKey 
	INNER JOIN LAB_INTERPRETATION INTER 
	ON ANTI.INTERPRETATION_IEN = INTER.LabInterpretationKey

OPEN curAnti
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch Lab Result Antibiotic',0

FETCH NEXT FROM curAnti INTO @org,@susc,@inter,@sens,@anti
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@orgX = LabResultOrganismId
		FROM NHJAX_ODS.dbo.LAB_RESULT_ANTIBIOTIC
		WHERE LabResultOrganismId = @org
		AND AntibioticSusceptibilityId = @susc
		AND LabInterpretationId = @inter;
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.LAB_RESULT_ANTIBIOTIC(
				LabResultOrganismId,
				AntibioticSusceptibilityId,
				LabInterpretationId,
				Sensitivity,
				LabResultAntibioticKey)
				VALUES(@org,@susc,@inter,@sens,@anti);
				SET @irow = @irow + 1
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM curAnti INTO @org,@susc,@inter,@sens,@anti
	COMMIT	
	END
END
CLOSE curAnti
DEALLOCATE curAnti

SET @sirow = 'Lab Result Antibiotic Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Lab Result Antibiotic Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Lab Result Antibiotic',0,@day;
