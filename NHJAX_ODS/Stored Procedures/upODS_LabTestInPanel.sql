

CREATE PROCEDURE [dbo].[upODS_LabTestInPanel] AS

Declare @lab bigint
Declare @pan bigint

Declare @labX bigint
Declare @panX bigint

Declare @drow int
Declare @trow int
Declare @irow int
Declare @sdrow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Lab Panel',0,@day;

DECLARE curLabPan CURSOR FOR
SELECT	SINGLE.LabTestid AS LabTestId, 
	PANEL.LabTestid AS LabTestInPanelId
FROM    LAB_TEST SINGLE 
	INNER JOIN vwMDE_LAB_TEST$LAB_TEST_IN_PANEL LBPANEL
	ON SINGLE.LabTestKey = LBPANEL.KEY_LAB_TEST 
	INNER JOIN LAB_TEST PANEL 
	ON LBPANEL.LAB_TEST_IN_PANEL_IEN = PANEL.LabTestKey

OPEN curLabPan
SET @trow = 0
SET @irow = 0
SET @drow = 0
EXEC dbo.upActivityLog 'Fetch Lab Panel',0

FETCH NEXT FROM curLabPan INTO @lab,@pan

if(@@FETCH_STATUS = 0)

BEGIN
BEGIN TRANSACTION
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		Select 	@labX = LabTestId
		FROM NHJAX_ODS.dbo.LAB_TEST_IN_PANEL
		WHERE 	LabTestId = @lab
		AND	LabTestInPanelId = @pan

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.LAB_TEST_IN_PANEL(
				LabTestId,LabTestInPanelId)
				VALUES(@lab,@pan);
				SET @irow = @irow + 1
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM curLabPan INTO @lab,@pan
	END
COMMIT
END

CLOSE curLabPan
DEALLOCATE curLabPan

--Delete any missing records
EXEC dbo.upActivityLog 'Begin Del Lab Panel',0,@day;

DECLARE curDelLabPan CURSOR FOR
SELECT 	LabTestId,
	LabTestInPanelId
	FROM NHJAX_ODS.dbo.LAB_TEST_IN_PANEL


OPEN curDelLabPan
EXEC dbo.upActivityLog 'Fetch Del Lab Panel',0

FETCH NEXT FROM curDelLabPan INTO @lab,@pan

if(@@FETCH_STATUS = 0)

BEGIN
BEGIN TRANSACTION
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		SELECT	@labX = SINGLE.LabTestid,
			@panX = PANEL.LabTestid
			FROM LAB_TEST SINGLE 
			INNER JOIN vwMDE_LAB_TEST$LAB_TEST_IN_PANEL LBPANEL
			ON SINGLE.LabTestKey = LBPANEL.KEY_LAB_TEST 
			INNER JOIN LAB_TEST PANEL 
			ON LBPANEL.LAB_TEST_IN_PANEL_IEN = PANEL.LabTestKey
			WHERE 	SINGLE.LabTestId = @lab
			AND	PANEL.LabTestId = @pan

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				DELETE FROM NHJAX_ODS.dbo.LAB_TEST_IN_PANEL
				WHERE LabTestId = @lab
				AND LabTestInPanelId = @pan;
				SET @drow = @drow + 1
			END
		FETCH NEXT FROM curDelLabPan INTO @lab,@pan
	END
COMMIT
END

CLOSE curDelLabPan
DEALLOCATE curDelLabPan

SET @sdrow = 'Lab Panel Deleted: ' + CAST(@drow AS varchar(50))
SET @sirow = 'Lab Panel Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Lab Panel Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sdrow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Del Lab Panel',0,@day;
EXEC dbo.upActivityLog 'End Lab Panel',0,@day;

