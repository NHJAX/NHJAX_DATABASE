
CREATE PROCEDURE [dbo].[upODS_ProviderClass] AS
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
Declare @classkey decimal
Declare @classdesc varchar(34)
Declare @classabbv varchar(5)
Declare @classkeyX decimal
Declare @classdescX varchar(34)
Declare @classabbvX varchar(5)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Provider Class',0,@day;
Select Identity(int,1,1) ID,
	KEY_PROVIDER_CLASS, 
	NAME, 
	ABBREV__TITLE
	into #Temp 
	FROM vwMDE_PROVIDER_CLASS
SET @loop = @@rowcount
SET @today = getdate()
SET @urow = 0
SET @irow = 0
SET @trow = 1
While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	Select @classkey = KEY_PROVIDER_CLASS, 
	@classdesc = NAME, 
	@classabbv = ABBREV__TITLE
	from #Temp 
	Where ID = @trow
		
	Select @classkeyX = ProviderClassKey, 
	@classdescX = ProviderClassDesc, 
	@classabbvX = ProviderClassAbbrev
	from NHJAX_ODS.dbo.PROVIDER_CLASS 
	Where ProviderClassKey = @classkey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.PROVIDER_CLASS(ProviderClassKey,
			ProviderClassDesc, 
			ProviderClassAbbrev) 
		VALUES(@classkey, 
			@classdesc, 
			@classabbv);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @classdesc <> @classdescX
		OR @classabbv <> @classabbvX
		OR (@classdesc Is Not Null AND @classdescX Is Null)
		OR (@classabbv Is Not Null AND @classabbvX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.PROVIDER_CLASS
			SET ProviderClassDesc = @classdesc,
			ProviderClassAbbrev = @classabbv,
			UpdatedDate = @today
			WHERE ProviderClassKey = @classkey;
			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'Provider Class Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Provider Class Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Provider Class Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Provider Class',0,@day;
Drop table #Temp
