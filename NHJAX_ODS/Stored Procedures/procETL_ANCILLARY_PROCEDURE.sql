
CREATE PROCEDURE [dbo].[procETL_ANCILLARY_PROCEDURE] AS

--Update Indexes
BEGIN TRY
Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)

--EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_ANCILLARY_PROCEDURE

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'ANCILLARY_PROCEDURE'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.ANCILLARY_PROCEDURE

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: ANCILLARY_PROCEDURE was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: ANCILLARY_PROCEDURE had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
	END

IF LEN(@Msg) > 0
	BEGIN
	--PRINT @Msg
	EXEC upActivityLog @Msg, 99995
	EXEC upSendMail @Sub='MDE/SQL Server Warning - ODS', @msg=@Msg	
	END

--UPDATE ACTIVITY_COUNT
UPDATE ACTIVITY_COUNT
SET ActivityCount = @new,
UpdatedDate = getdate()
WHERE TableName = 'ANCILLARY_PROCEDURE'
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: CHK AncillaryProcedure'
END CATCH

--Ancillary Procedure
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

Declare @apkey numeric(10,3)
Declare @apname varchar(30)

Declare @apkeyX numeric(10,3)
Declare @apnameX varchar(30)

EXEC dbo.upActivityLog 'Begin Ancillary Procedure',0;

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
	from ANCILLARY_PROCEDURE 
	Where AncillaryProcedureKey = @apkey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO ANCILLARY_PROCEDURE(AncillaryProcedureKey,
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
			UPDATE ANCILLARY_PROCEDURE
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
EXEC dbo.upActivityLog 'End Ancillary Procedure',0;
Drop table #Temp
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL AncillaryProcedure'
END CATCH
