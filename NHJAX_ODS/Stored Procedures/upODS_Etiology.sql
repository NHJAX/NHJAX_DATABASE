
CREATE PROCEDURE [dbo].[upODS_Etiology] AS
if exists(SELECT * FROM dbo.sysobjects WHERE name = '#Temp')
BEGIN
DROP TABLE #Temp;
END
Declare @trow int
Declare @urow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @loop int
Declare @exists int
Declare @etkey numeric(12,3)
Declare @etdesc varchar(70)
Declare @etkeyX numeric(12,3)
Declare @etdescX varchar(70)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Etiology',0,@day;
Select Identity(int,1,1) ID,
	KEY_ETIOLOGY_FIELD, 
	NAME
	into #Temp 
	FROM vwMDE_ETIOLOGY_FIELD
SET @loop = @@rowcount
SET @today = getdate()
SET @urow = 0
SET @irow = 0
SET @trow = 1
While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	Select @etkey = KEY_ETIOLOGY_FIELD, 
	@etdesc = NAME
	from #Temp 
	Where ID = @trow
		
	Select @etkeyX = EtiologyKey,  
	@etdescX = EtiologyDesc
	from NHJAX_ODS.dbo.ETIOLOGY 
	Where EtiologyKey = @etkey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.ETIOLOGY(EtiologyKey,
			EtiologyDesc) 
		VALUES(@etkey, 
			@etdesc);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @etdesc <> @etdescX
		OR (@etdesc Is Not Null AND @etdescX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.ETIOLOGY
			SET
			EtiologyDesc = @etdesc,
			UpdatedDate = @today
			WHERE EtiologyKey = @etkey;
			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'Etiology Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Etiology Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Etiology Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Etiology',0,@day;
Drop table #Temp
