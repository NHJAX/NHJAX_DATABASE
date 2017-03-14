
CREATE PROCEDURE [dbo].[procETL_ACCESS_TO_CARE]  AS

--Update Indexes
Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)

--Update Indexes
BEGIN TRY
EXEC [NHJAX-cache].STAGING.dbo.upCreateIndexes_ACCESS_TO_CARE_CATEGORY

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'ACCESS_TO_CARE_CATEGORY'
SELECT @New = Count(*) FROM [NHJAX-cache].STAGING.dbo.ACCESS_TO_CARE_CATEGORY

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: ACCESS_TO_CARE_CATEGORY was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: ACCESS_TO_CARE_CATEGORY had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
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
WHERE TableName = 'ACCESS_TO_CARE_CATEGORY'
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE, @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: CHK AccessToCare'
END CATCH

--ETL Access To Care
BEGIN TRY
Declare @atc bigint
Declare @key numeric(7,3)
Declare @desc varchar(30)
Declare @std numeric(10,3)

Declare @atcX bigint
Declare @keyX numeric(7,3)
Declare @descX varchar(30)
Declare @stdX numeric(10,3)

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @exists int

EXEC dbo.upActivityLog 'Begin Atc',0;

SET @today = getdate()
DECLARE curAtc CURSOR FAST_FORWARD FOR
SELECT	KEY_ACCESS_TO_CARE_CATEGORY, 
	NAME, 
	STANDARD
FROM    vwMDE_ACCESS_TO_CARE_CATEGORY
ORDER BY KEY_ACCESS_TO_CARE_CATEGORY

OPEN curAtc
SET @trow = 0
SET @irow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch Atc',0

FETCH NEXT FROM curAtc INTO @key,@desc,@std
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@keyX = AccessToCareKey,
			@descX = AccessToCareDesc,
			@stdX = AccessToCareStandard
		FROM NHJAX_ODS.dbo.ACCESS_TO_CARE
		WHERE AccessToCareKey = @key
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.ACCESS_TO_CARE(
				AccessToCareKey,
				AccessToCareDesc,
				AccessToCareStandard)
				VALUES(@key,@desc,@std);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@desc <> @descX
		OR	@std <> @stdX
		OR 	(@desc Is Not Null AND @descX Is Null)
		OR	(@std Is Not Null AND @stdX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.ACCESS_TO_CARE
			SET 	AccessToCareDesc = @desc,
				AccessToCareStandard = @std,
				UpdatedDate = @today
			WHERE AccessToCareKey = @key;
			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curAtc INTO @key,@desc,@std
	COMMIT
	END
END
CLOSE curAtc
DEALLOCATE curAtc
SET @surow = 'Atc Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Atc Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Atc Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Atc',0;
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL AccessToCare'
END CATCH
