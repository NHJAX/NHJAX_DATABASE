
CREATE PROCEDURE [dbo].[procETL_ALTERNATE_CARE_VALUE] AS
BEGIN TRY
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

Declare @acvkey decimal
Declare @acvcode varchar(30)
Declare @acvdesc varchar(40)

Declare @acvkeyX decimal
Declare @acvcodeX varchar(30)
Declare @acvdescX varchar(40)

EXEC dbo.upActivityLog 'Begin ACV',0;

Select Identity(int,1,1) ID,
	KEY_MCP_ALTERNATE_CARE_VALUE, 
	CODE,
	DESCRIPTION
	into #Temp 
	FROM vwMDE_MCP_ALTERNATE_CARE_VALUE
SET @loop = @@rowcount
SET @today = getdate()

SET @urow = 0
SET @irow = 0
SET @trow = 1

While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	
	Select @acvkey = KEY_MCP_ALTERNATE_CARE_VALUE, 
	@acvcode = CODE,
	@acvdesc = DESCRIPTION
	from #Temp 
	Where ID = @trow
		
	Select @acvkeyX = AlternateCareValueKey,
	@acvcodeX = AlternateCareValueCode,  
	@acvdescX = AlternateCareValueDesc
	from ALTERNATE_CARE_VALUE 
	Where AlternateCareValueKey = @acvkey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO ALTERNATE_CARE_VALUE(AlternateCareValueKey,
			AlternateCareValueCode,
			AlternateCareValueDesc) 
		VALUES(@acvkey,
			@acvcode, 
			@acvdesc);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @acvcode <> @acvcodeX
		OR @acvdesc <> @acvdescX
		OR (@acvcode Is Not Null AND @acvcodeX Is Null)
		OR (@acvdesc Is Not Null AND @acvdescX Is Null)
			BEGIN
			UPDATE ALTERNATE_CARE_VALUE
			SET
			AlternateCareValueCode = @acvcode,
			AlternateCareValueDesc = @acvdesc,
			UpdatedDate = @today
			WHERE AlternateCareValueKey = @acvkey;

			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'ACV Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'ACV Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'ACV Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End ACV',0;
Drop table #Temp

END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL AlternateCareValue'
END CATCH