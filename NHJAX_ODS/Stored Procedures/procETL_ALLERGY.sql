

CREATE PROCEDURE [dbo].[procETL_ALLERGY] AS

--Update Indexes: Allergies Definitions
BEGIN TRY
Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)

EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_ALLERGIES_DEFINITIONS

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'ALLERGIES_DEFINITIONS'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.ALLERGIES_DEFINITIONS

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: ALLERGIES_DEFINITIONS was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: ALLERGIES_DEFINITIONS had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
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
WHERE TableName = 'ALLERGIES_DEFINITIONS'
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: CHK AllergiesDefinitions'
END CATCH

--Update Indexes: Allergies Selections
BEGIN TRY
EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_ALLERGIES_SELECTIONS

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'ALLERGIES_SELECTIONS'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.ALLERGIES_SELECTIONS

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: ALLERGIES_SELECTIONS was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: ALLERGIES_SELECTIONS had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
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
WHERE TableName = 'ALLERGIES_SELECTIONS'
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: CHK AllergiesSelections'
END CATCH

--Allergies
BEGIN TRY
Declare @alrgy numeric(16,3)
Declare @name varchar(31)
Declare @desc varchar(32)
Declare @com varchar(30)

Declare @alrgyX numeric(16,3)
Declare @nameX varchar(31)
Declare @descX varchar(32)
Declare @comX varchar(30)

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @exists int

EXEC dbo.upActivityLog 'Begin Allergy',0;

SET @today = getdate()
DECLARE curAlrgy CURSOR FAST_FORWARD FOR
SELECT	A_S.KEY_ALLERGIES_SELECTIONS, 
		A_D.ALLERGY_NAME_GNN, 
		A_S.BN_GNN, 
        		A_S.COMMENT_
FROM    	vwMDE_ALLERGIES_DEFINITIONS A_D
		INNER JOIN vwMDE_ALLERGIES_SELECTIONS A_S
		ON A_D.KEY_ALLERGIES_DEFINITIONS = A_S.ALLERGY_DEFINITIONS_IEN

OPEN curAlrgy
SET @trow = 0
SET @irow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch Allergy',0

FETCH NEXT FROM curAlrgy INTO @alrgy,@name,@desc,@com
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@alrgyX = AllergySelectionKey,
			@nameX = AllergyName,
			@descX = AllergyDesc,
			@comX = Comments
		FROM ALLERGY
		WHERE AllergySelectionKey = @alrgy
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO ALLERGY(
				AllergySelectionKey,
				AllergyName,
				AllergyDesc,
				Comments)
				VALUES(@alrgy,@name,@desc,@com);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@name <> @nameX
		OR	@desc <> @descX
		OR	@com <> @comX
		OR 	(@name Is Not Null AND @nameX Is Null)
		OR	(@desc Is Not Null AND @descX Is Null)
		OR	(@com Is Not Null AND @comX Is Null)
			BEGIN
			UPDATE ALLERGY
			SET 	AllergyName = @name,
				AllergyDesc = @desc,
				Comments = @com,
				UpdatedDate = @today
			WHERE AllergySelectionKey = @alrgy;
			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curAlrgy INTO @alrgy,@name,@desc,@com
	COMMIT
	END
END
CLOSE curAlrgy
DEALLOCATE curAlrgy
SET @surow = 'Allergy Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Allergy Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Allergy Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Allergy',0;
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL Allergy'
END CATCH
