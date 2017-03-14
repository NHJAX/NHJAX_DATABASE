
CREATE PROCEDURE [dbo].[upODS_LabResultChemistryResult] AS

Declare @res bigint
Declare @lab bigint
Declare @key numeric(13,3)
Declare @sub numeric(26,9)
Declare @test numeric(10,3)
Declare @result varchar(30)

Declare @resX bigint
Declare @labX bigint
Declare @keyX numeric(13,3)
Declare @subX numeric(26,9)
Declare @testX numeric(10,3)
Declare @resultX varchar(30)

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
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

EXEC dbo.upActivityLog 'Begin Lab Result Chemistry ',0,@day;

SET @tempDate = DATEADD(d,-20,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 

DECLARE	curTest CURSOR FAST_FORWARD FOR 
SELECT	RES.LabResultId, 
	LAB.LabTestid, 
	CHEM.KEY_LAB_RESULT, 
	CHEM.KEY_LAB_RESULT$CLINICAL_CHEMISTRY, 
    CHEM.KEY_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT, 
	CHEM.RESULT
FROM    vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT CHEM 
	INNER JOIN LAB_RESULT RES 
	ON CHEM.KEY_LAB_RESULT$CLINICAL_CHEMISTRY = RES.LabResultSubKey 
	AND CHEM.KEY_LAB_RESULT = RES.LabResultKey 
	INNER JOIN LAB_TEST LAB 
	ON CHEM.TEST_IEN = LAB.LabTestKey 
	AND RES.LabTestId = LAB.LabTestid
WHERE   ((RES.EnterDate >= @fromDate)
	OR (RES.CertifyDate >= @fromDate)
	OR (RES.AppendDate >= @fromDate)) 
	AND RES.AccessionTypeId = 1


OPEN curTest
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Lab Result Chemistry',0

FETCH NEXT FROM curTest INTO @res,@lab,@key,@sub,@test,@result

if(@@FETCH_STATUS = 0)

BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
	
		--PRINT @res
		--PRINT @lab
	
		Select @resultX = ChemistryResult
		FROM NHJAX_ODS.dbo.LAB_RESULT_CHEMISTRY_RESULT
		WHERE LabResultId = @res
		AND LabTestId = @lab
		
		SET @exists = @@RowCount
		
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.LAB_RESULT_CHEMISTRY_RESULT(
				LabResultId,
				LabTestId,
				LabResultKey,
				LabResultSubKey,
				LabResultResultKey,
				ChemistryResult)
				VALUES(@res,@lab,@key,@sub,@test,@result);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@result <> @resultX
		OR 	(@result Is Not Null AND @resultX Is Null)
			BEGIN

			SET @today = getdate()
			UPDATE NHJAX_ODS.dbo.LAB_RESULT_CHEMISTRY_RESULT
			SET 	LabResultKey = @res,
				LabResultSubKey = @sub,
				LabResultResultKey = @test,
				ChemistryResult = @result,
				UpdatedDate = @today
			WHERE LabResultId = @res
			AND LabTestId = @lab;

			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		
	COMMIT

	FETCH NEXT FROM curTest INTO @res,@lab,@key,@sub,@test,@result
		
	
	END
END

CLOSE curTest
DEALLOCATE curTest

SET @surow = 'Lab Result Chemistry Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Lab Result Chemistry Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Lab Result Chemistry Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Lab Result Chemistry',0,@day;
