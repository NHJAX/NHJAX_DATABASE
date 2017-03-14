

CREATE PROCEDURE [dbo].[upODS_Meprs] AS
if exists(SELECT * FROM dbo.sysobjects WHERE name = '#Temp')
BEGIN
DROP TABLE #Temp;
END

Declare @meprskey numeric(10,3)
Declare @meprscode varchar(4)
Declare @desc varchar(50)
Declare @dmis bigint

Declare @meprskeyX numeric(10,3)
Declare @meprscodeX varchar(4)
Declare @descX varchar(50)
Declare @dmisX bigint

Declare @trow int
Declare @urow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @loop int
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Meprs',0,@day;

Select Identity(int,1,1) ID,
	M.KEY_MEPRS_CODES, 
	M.CODE, 
	M.DESCRIPTION,
	D.DMISId
	into #Temp 
	FROM DMIS D 
	INNER JOIN vwMDE_MEPRS_CODES M 
	ON D.DMISKey = M.DMIS_ID_IEN
SET @loop = @@rowcount
SET @today = getdate()
SET @urow = 0
SET @irow = 0
SET @trow = 1
While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	Select @meprskey = KEY_MEPRS_CODES, 
	@meprscode = CODE, 
	@desc = DESCRIPTION,
	@dmis = DmisId
	from #Temp 
	Where ID = @trow
		
	Select @meprskeyX = MeprsCodeKey, 
	@meprscodeX = MeprsCode, 
	@descX = MeprsCodeDesc,
	@dmisX = DmisId
	from NHJAX_ODS.dbo.MEPRS_CODE 
	Where MeprsCodeKey = @meprskey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.MEPRS_CODE(MeprsCodeKey,
			MeprsCode, 
			MeprsCodeDesc,
			DmisId) 
		VALUES(@meprskey, 
			@meprscode, 
			@desc,
			@dmis);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @meprscode <> @meprscodeX
		OR @desc <> @descX
		OR @dmis <> @dmisX
		OR (@meprscode Is Not Null AND @meprscodeX Is Null)
		OR (@desc Is Not Null AND @descX Is Null)
		OR (@dmis Is Not Null AND @dmisX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.MEPRS_CODE
			SET MeprsCode = @meprscode,
			MeprsCodeDesc = @desc,
			DmisId = @dmis,
			UpdatedDate = @today
			WHERE MeprsCodeKey = @meprskey;
			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'MEPRS Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'MEPRS Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'MEPRS Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Meprs',0,@day;
Drop table #Temp

