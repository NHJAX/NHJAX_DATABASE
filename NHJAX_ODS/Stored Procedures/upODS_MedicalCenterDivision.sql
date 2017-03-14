
CREATE PROCEDURE [dbo].[upODS_MedicalCenterDivision] AS
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

Declare @ctrkey numeric(8,3)
Declare @ctrdesc varchar(30)

Declare @ctrkeyX numeric(8,3)
Declare @ctrdescX varchar(30)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Medical Center',0,@day;

Select Identity(int,1,1) ID,
	KEY_MEDICAL_CENTER_DIVISION, 
	NAME
	into #Temp 
	FROM vwMDE_MEDICAL_CENTER_DIVISION

SET @loop = @@rowcount
SET @today = getdate()

SET @urow = 0
SET @irow = 0
SET @trow = 1

While @trow <= @loop
BEGIN
	
	Select @ctrkey = KEY_MEDICAL_CENTER_DIVISION, 
	@ctrdesc = NAME 
	from #Temp 
	Where ID = @trow
		
	Select @ctrkeyX = MedicalCenterDivisionKey, 
	@ctrdescX = MedicalCenterDivisionDesc
	from NHJAX_ODS.dbo.MEDICAL_CENTER_DIVISION 
	Where MedicalCenterDivisionKey = @ctrkey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.MEDICAL_CENTER_DIVISION(MedicalCenterDivisionKey,
			MedicalCenterDivisionDesc) 
		VALUES(@ctrkey, 
			@ctrdesc);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @ctrdesc <> @ctrdescX
		OR (@ctrdesc Is Not Null AND @ctrdescX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.MEDICAL_CENTER_DIVISION
			SET MedicalCenterDivisionDesc = @ctrdesc,
			UpdatedDate = @today
			WHERE MedicalCenterDivisionKey = @ctrkey;

			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
END
SET @trow = @trow - 1
SET @surow = 'Medical Center Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Medical Center Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Medical Center Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Medical Center',0,@day;
Drop table #Temp
