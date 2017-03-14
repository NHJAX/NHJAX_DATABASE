
CREATE PROCEDURE [dbo].[upODS_LabTestPanel] AS

Declare @lab decimal
Declare @desc varchar(30)
Declare @panel bigint
Declare @unit numeric(15,2)
Declare @cnt bigint

Declare @labX decimal
Declare @descX varchar(30)
Declare @panelX bigint
Declare @unitX numeric(15,2)

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

EXEC dbo.upActivityLog 'Begin Lab Test(2)',0,@day;

SET @today = getdate()

DECLARE curLab CURSOR FAST_FORWARD FOR
SELECT DISTINCT 
	LAB.KEY_LAB_TEST,
	LAB.NAME, 
	TYPE.LabTestTypeId, 
	SUM(ISNULL(LT2.UnitCost, 0)) AS UnitCost, 
	COUNT(LT1.LabTestid) AS CountofPanel
FROM    LAB_TEST LT1 
	INNER JOIN vwMDE_LAB_TEST LAB 
	INNER JOIN LAB_TEST_TYPE TYPE 
	ON LAB.SINGLE_PANEL = TYPE.LabTestTypeDesc 
	ON LT1.LabTestKey = LAB.KEY_LAB_TEST 
	INNER JOIN LAB_TEST_IN_PANEL LABPAN 
	ON LT1.LabTestid = LABPAN.LabTestId 
	INNER JOIN LAB_TEST LT2 
	ON LABPAN.LabTestInPanelId = LT2.LabTestid
GROUP BY 
	LAB.NAME, 
	TYPE.LabTestTypeId, 
	LAB.KEY_LAB_TEST
HAVING  (TYPE.LabTestTypeId = 1)

OPEN curLab
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Lab Test(2)',0

FETCH NEXT FROM curLab INTO @lab,@desc,@panel,@unit,@cnt

if(@@FETCH_STATUS = 0)

BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@labX = LabTestKey,
			@descX = LabTestDesc,
			@panelX = LabTestTypeId,
			@unitX = UnitCost
		FROM NHJAX_ODS.dbo.LAB_TEST
		WHERE LabTestKey = @lab

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.LAB_TEST(
				LabTestKey,
				LabTestDesc,
				LabTestTypeId,
				UnitCost)
				VALUES(@lab,@desc,@panel,@unit);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@desc <> @descX
		OR 	@panel <> @panelX
		OR	@unit <> @unitX
		OR 	(@desc Is Not Null AND @descX Is Null)
		OR	(@panel Is Not Null AND @panelX Is Null)
		OR	(@unit Is Not Null AND @unitX Is Null)

			BEGIN
			UPDATE NHJAX_ODS.dbo.LAB_TEST
			SET 	LabTestDesc = @desc,
				LabTestTypeId = @panel,
				UnitCost = @unit,
				UpdatedDate = @today
			WHERE LabTestKey = @lab;

			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curLab INTO @lab,@desc,@panel,@unit,@cnt
	COMMIT
	END

END


CLOSE curLab
DEALLOCATE curLab

SET @surow = 'Lab Test Updated(2): ' + CAST(@urow AS varchar(50))
SET @sirow = 'Lab Test Inserted(2): ' + CAST(@irow AS varchar(50))
SET @strow = 'Lab Test Total(2): ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Lab Test(2)',0,@day;
