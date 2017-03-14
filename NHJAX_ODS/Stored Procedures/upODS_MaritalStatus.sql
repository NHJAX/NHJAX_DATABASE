
CREATE PROCEDURE [dbo].[upODS_MaritalStatus] AS
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

Declare @markey decimal
Declare @mardesc varchar(30)
Declare @marabbr varchar(5)

Declare @markeyX decimal
Declare @mardescX varchar(30)
Declare @marabbrX varchar(5)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Marital Status',0,@day;

Select Identity(int,1,1) ID,
	KEY_MARITAL_STATUS, 
	NAME, 
	ABBREVIATION
	into #Temp 
	FROM vwMDE_MARITAL_STATUS
SET @loop = @@rowcount
SET @today = getdate()

SET @urow = 0
SET @irow = 0
SET @trow = 1

While @trow <= @loop
BEGIN
	
	Select @markey = KEY_MARITAL_STATUS, 
	@mardesc = NAME, 
	@marabbr = ABBREVIATION
	from #Temp 
	Where ID = @trow
		
	Select @markeyX = MaritalStatusKey, 
	@mardescX = MaritalStatusDesc, 
	@marabbrX = MaritalStatusAbbr
	from NHJAX_ODS.dbo.MARITAL_STATUS 
	Where MaritalStatusKey = @markey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.MARITAL_STATUS(MaritalStatusKey,
			MaritalStatusDesc, 
			MaritalStatusAbbr) 
		VALUES(@markey, 
			@mardesc, 
			@marabbr);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @mardesc <> @mardescX
		OR @marabbr <> @marabbrX
		OR (@mardesc Is Not Null AND @mardescX Is Null)
		OR (@marabbr Is Not Null AND @marabbrX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.MARITAL_STATUS
			SET MaritalStatusDesc = @mardesc,
			MaritalStatusAbbr = @marabbr,
			UpdatedDate = @today
			WHERE MaritalStatusKey = @markey;

			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
END
SET @trow = @trow - 1
SET @surow = 'Marital Status Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Marital Status Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Marital Status Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Marital Status',0,@day;
Drop table #Temp
