
CREATE PROCEDURE [dbo].[upODS_Dmis] AS
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
Declare @dmiskey decimal
Declare @dmiscode varchar(30)
Declare @fac varchar(50)
Declare @dmiskeyX decimal
Declare @dmiscodeX varchar(30)
Declare @facX varchar(50)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Dmis',0,@day;
Select Identity(int,1,1) ID,
	KEY_DMIS_ID_CODES, 
	DMIS_ID, 
	FACILITY_NAME 
	into #Temp 
	FROM vwMDE_DMIS_ID_CODES
SET @loop = @@rowcount
SET @today = getdate()
SET @urow = 0
SET @irow = 0
SET @trow = 1
While @trow <= @loop
BEGIN
BEGIN TRANSACTION

	Select @dmiskey = KEY_DMIS_ID_CODES, 
	@dmiscode = DMIS_ID, 
	@fac = FACILITY_NAME
	from #Temp 
	Where ID = @trow
		
	Select @dmiskeyX = DMISKey, 
	@dmiscodeX = DMISCode, 
	@facX = FacilityName
	from NHJAX_ODS.dbo.DMIS 
	Where DMISKey = @dmiskey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.DMIS(DMISKey,
			DMISCode, 
			FacilityName) 
		VALUES(@dmiskey, 
			@dmiscode, 
			@fac);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @dmiscode <> @dmiscodeX
		OR @fac <> @facX
		OR (@dmiscode Is Not Null AND @dmiscodeX Is Null)
		OR (@fac Is Not Null AND @facX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.DMIS
			SET DMISCode = @dmiscode,
			FacilityName = @fac,
			UpdatedDate = @today
			WHERE DMISKey = @dmiskey;
			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'DMIS Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'DMIS Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'DMIS Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End DMIS',0,@day;
Drop table #Temp
