
CREATE PROCEDURE [dbo].[upODS_FamilyMemberPrefix] AS
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

Declare @fmpkey decimal
Declare @fmpnbr decimal
Declare @fmpcode varchar(30)
Declare @fmpdesc varchar(50)

Declare @fmpkeyX decimal
Declare @fmpnbrX decimal
Declare @fmpcodeX varchar(30)
Declare @fmpdescX varchar(50)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin FMP',0,@day;
Select Identity(int,1,1) ID,
	KEY_FAMILY_MEMBER_PREFIX, 
	NUMBER_, 
	FMP,
	DESCRIPTION
	into #Temp 
	FROM vwMDE_FAMILY_MEMBER_PREFIX
SET @loop = @@rowcount
SET @today = getdate()
SET @urow = 0
SET @irow = 0
SET @trow = 1
While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	Select @fmpkey = KEY_FAMILY_MEMBER_PREFIX, 
	@fmpnbr = NUMBER_, 
	@fmpcode = FMP,
	@fmpdesc = DESCRIPTION
	from #Temp 
	Where ID = @trow
		
	Select @fmpkeyX = FamilyMemberPrefixKey, 
	@fmpnbrX = FamilyMemberPrefixNumber, 
	@fmpcodeX = FamilyMemberPrefixCode,
	@fmpdescX = FamilyMemberPrefixDesc
	from NHJAX_ODS.dbo.FAMILY_MEMBER_PREFIX 
	Where FamilyMemberPrefixKey = @fmpkey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.FAMILY_MEMBER_PREFIX(FamilyMemberPrefixKey,
			FamilyMemberPrefixNumber, 
			FamilyMemberPrefixCode,
			FamilyMemberPrefixDesc) 
		VALUES(@fmpkey, 
			@fmpnbr, 
			@fmpcode,
			@fmpdesc);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @fmpnbr <> @fmpnbrX
		OR @fmpcode <> @fmpcodeX
		OR @fmpdesc <> @fmpdescX
		OR (@fmpnbr Is Not Null AND @fmpnbrX Is Null)
		OR (@fmpcode Is Not Null AND @fmpcodeX Is Null)
		OR (@fmpdesc Is Not Null AND @fmpdescX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.FAMILY_MEMBER_PREFIX
			SET FamilyMemberPrefixNumber = @fmpnbr,
			FamilyMemberPrefixCode = @fmpcode,
			FamilyMemberPrefixDesc = @fmpdesc,
			UpdatedDate = @today
			WHERE FamilyMemberPrefixKey = @fmpkey;
			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'FMP Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'FMP Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'FMP Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End FMP',0,@day;
Drop table #Temp
