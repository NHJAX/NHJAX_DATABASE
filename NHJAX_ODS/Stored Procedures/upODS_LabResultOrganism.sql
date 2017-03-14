
CREATE PROCEDURE [dbo].[upODS_LabResultOrganism] AS

Declare @test bigint
Declare @eti bigint
Declare @res numeric(13,3)
Declare @bac numeric(26,9)
Declare @test2 numeric(10,3)
Declare @org numeric(12,3)

Declare @testX bigint
Declare @etiX bigint
Declare @resX numeric(13,3)
Declare @bacX numeric(26,9)
Declare @test2X numeric(10,3)
Declare @orgX numeric(12,3)

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

EXEC dbo.upActivityLog 'Begin Lab Result Organism',0,@day;

DECLARE curOrg CURSOR FAST_FORWARD FOR
SELECT	TEST.LabResultBacteriologyTestId, 
	ETIOLOGY.EtiologyId, 
	ORG.KEY_LAB_RESULT, 
	ORG.KEY_LAB_RESULT$BACTERIOLOGY, 
        ORG.KEY_LAB_RESULT$BACTERIOLOGY$TEST, 
	ORG.KEY_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM
FROM    LAB_RESULT_BACTERIOLOGY_TEST TEST 
	INNER JOIN vwMDE_LAB_RESULT$BACTERIOLOGY$TEST$ORGANISM ORG 
	ON TEST.LabResultSubKey = ORG.KEY_LAB_RESULT$BACTERIOLOGY 
	AND TEST.LabResultTestKey = ORG.KEY_LAB_RESULT$BACTERIOLOGY$TEST 
	AND TEST.LabResultKey = ORG.KEY_LAB_RESULT 
	INNER JOIN ETIOLOGY 
	ON ORG.ORGANISM_IEN = ETIOLOGY.EtiologyKey

OPEN curOrg
SET @trow = 0
SET @irow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch Lab Result Organism',0

FETCH NEXT FROM curOrg INTO @test,@eti,@res,@bac,@test2,@org
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@testX = LabResultBacteriologyTestId
		FROM NHJAX_ODS.dbo.LAB_RESULT_ORGANISM
		WHERE LabResultBacteriologyTestId = @test
		AND EtiologyId = @eti;
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.LAB_RESULT_ORGANISM(
				LabResultBacteriologyTestId,
				EtiologyId,
				LabResultKey,
				LabResultSubKey,
				LabResultTestKey,
				LabResultOrganismKey)
				VALUES(@test,@eti,@res,@bac,@test2,@org);
				SET @irow = @irow + 1
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM curOrg INTO @test,@eti,@res,@bac,@test2,@org
	COMMIT	
	END
END
CLOSE curOrg
DEALLOCATE curOrg

SET @sirow = 'Lab Result Organism Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Lab Result Organism Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Lab Result Organism',0,@day;
