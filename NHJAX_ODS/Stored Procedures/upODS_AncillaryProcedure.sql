
CREATE PROCEDURE [dbo].[upODS_AncillaryProcedure] AS

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

Declare @apkey numeric(10,3)
Declare @apname varchar(30)

Declare @apkeyX numeric(10,3)
Declare @apnameX varchar(30)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Ancillary Procedure',0,@day;

Select Identity(int,1,1) ID,
	AP.KEY_ANCILLARY_PROCEDURE, 
	AP.NAME
	into #Temp 
	FROM vwMDE_ANCILLARY_PROCEDURE AP
	ORDER BY AP.NAME

SET @loop = @@rowcount
SET @today = getdate()

SET @urow = 0
SET @irow = 0
SET @trow = 1

While @trow <= @loop
BEGIN
	
	Select @apkey = KEY_ANCILLARY_PROCEDURE, 
	@apname = NAME
	from #Temp 
	Where ID = @trow

	Select @apkeyX = AncillaryProcedureKey, 
	@apnameX = AncillaryProcedureDesc
	from NHJAX_ODS.dbo.ANCILLARY_PROCEDURE 
	Where AncillaryProcedureKey = @apkey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.ANCILLARY_PROCEDURE(AncillaryProcedureKey,
			AncillaryProcedureDesc) 
		VALUES(@apkey, 
			@apname);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		
		If @apname <> @apnameX
		OR (@apname Is Not Null AND @apnameX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.ANCILLARY_PROCEDURE
			SET AncillaryProcedureDesc = @apname,
			UpdatedDate = @today
			WHERE AncillaryProcedureKey = @apkey;

			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
END
SET @trow = @trow - 1
SET @surow = 'Ancillary Procedure Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Ancillary Procedure Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Ancillary Procedure Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Ancillary Procedure',0,@day;
Drop table #Temp
