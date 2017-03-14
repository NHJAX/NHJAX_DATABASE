

CREATE PROCEDURE [dbo].[procETL_AHFS_CLASSIFICATION] AS

--Update Indexes
BEGIN TRY
Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)


EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_DRUG

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'DRUG'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.DRUG

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: DRUG was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: DRUG had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
	END

IF DataLength(@Msg) > 0
	BEGIN
	--PRINT @Msg
	EXEC upActivityLog @Msg, 99995
	EXEC upSendMail @Sub='MDE/SQL Server Warning - ODS', @msg=@Msg	
	END

--UPDATE ACTIVITY_COUNT
UPDATE ACTIVITY_COUNT
SET ActivityCount = @new,
UpdatedDate = getdate()
WHERE TableName = 'DRUG'
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: CHK Drug'
END CATCH

--AHFS Classification
BEGIN TRY
Declare @num varchar(53)
Declare @ahfs varchar(110)
Declare @numX varchar(53)
Declare @ahfsX varchar(110)

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
EXEC dbo.upActivityLog 'Begin AHFS Classification',0

DECLARE cur CURSOR FAST_FORWARD FOR
	SELECT DISTINCT 
		AHFS_NUMBER, 
		AHFS_CLASSIFICATION
	FROM vwMDE_DRUG
	WHERE (AHFS_CLASSIFICATION IS NOT NULL)
	ORDER BY AHFS_CLASSIFICATION
	
OPEN cur
SET @trow = 0
SET @irow = 0
FETCH NEXT FROM cur INTO @num, @ahfs
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		SELECT @numX = AHFSNumber,
			   @ahfsX = AHFSClassificationDesc
		FROM AHFS_CLASSIFICATION
		WHERE AHFSClassificationDesc = @ahfs

			SET @exists = @@RowCount
			If @exists = 0
				BEGIN
					INSERT INTO AHFS_CLASSIFICATION
					(
						AHFSNumber,
						AHFSClassificationDesc
					)
					VALUES(@num,@ahfs);
					SET @irow = @irow + 1
				END
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @num, @ahfs
	COMMIT	
	END
	
END
CLOSE cur
DEALLOCATE cur
SET @sirow = 'AHFS Classification Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'AHFS Classification Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

EXEC dbo.upActivityLog 'End AHFS Classification',0
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL AHFSClassification'
END CATCH
