
CREATE PROCEDURE [dbo].[procETL_CPT] AS

--Update Indexes: Cpt
BEGIN TRY
Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(2000)

EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_CPT_HCPCS

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'CPT_HCPCS'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.CPT_HCPCS

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: CPT_HCPCS was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: CPT_HCPCS had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
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
WHERE TableName = 'CPT_HCPCS'
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: CHK CptHcpcs'
END CATCH

BEGIN TRY
--Update Indexes: ICD Operation Procedure
EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_ICD_OPERATION_PROCEDURE

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'ICD_OPERATION_PROCEDURE'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.ICD_OPERATION_PROCEDURE

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: ICD_OPERATION_PROCEDURE was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: ICD_OPERATION_PROCEDURE had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
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
WHERE TableName = 'ICD_OPERATION_PROCEDURE'
END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: CPT: CHK ICD Operation Procedure'
END CATCH

BEGIN TRY
Declare @cpt bigint
Declare @code varchar(30)
Declare @desc varchar(30)
Declare @type bigint
Declare @rvu money
Declare @cmac numeric(15,2)

Declare @cptX bigint
Declare @codeX varchar(30)
Declare @descX varchar(30)
Declare @typeX bigint
Declare @rvuX money
Declare @cmacX numeric(15,2)

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @exists int

EXEC dbo.upActivityLog 'Begin Cpt',0;

SET @today = getdate()

DECLARE curCpt CURSOR FAST_FORWARD FOR
SELECT  CPT.KEY_CPT_HCPCS, 
	CPT.CODE, 
	CPT.DESCRIPTION,
	CASE 
		WHEN CPT.CODE BETWEEN 99211 AND 99499
			THEN 2
		ELSE 0
	END 
	AS CptTypeId, 
	ISNULL(RVU.RVU, 0) AS RVU,
	0 AS CMACUnit
FROM   vwMDE_CPT_HCPCS CPT  
	LEFT OUTER JOIN vwMDE_RVU RVU ON CPT.CODE = RVU.CPT_CODE
WHERE   (IsNumeric(CPT.CODE) = 1) 
		
UNION SELECT
	CPT.KEY_CPT_HCPCS, 
	CPT.CODE, 
	CPT.DESCRIPTION, 
	0 AS CptTypeId, 
	ISNULL(RVU.RVU, 0) AS RVU, 
	0 AS CMACUnit
FROM   vwMDE_CPT_HCPCS CPT  
	LEFT OUTER JOIN vwMDE_RVU RVU ON CPT.CODE = RVU.CPT_CODE
WHERE   (IsNumeric(CPT.CODE) = 0) 
		
UNION
SELECT 
	KEY_ICD_OPERATION_PROCEDURE,
	CODE_NUMBER,
	DESCRIPTION,
	1 AS CptTypeId,
	0 AS RVU,
	0 AS CMACUnit
FROM 	vwMDE_ICD_OPERATION_PROCEDURE

OPEN curCpt
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Cpt',0

FETCH NEXT FROM curCpt INTO @cpt,@code,@desc,@type,@rvu,@cmac

if(@@FETCH_STATUS = 0)

BEGIN
BEGIN TRANSACTION
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		Select 	@cptX = CptHcpcsKey,
			@codeX = CptCode,
			@descX = CptDesc,
			@typeX = CptTypeId,
			@rvuX = RVU,
			@cmacX = CMACUnit
		FROM CPT
		WHERE CptHcpcsKey = @cpt
		AND CptTypeId = @type

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO CPT(
				CptHcpcsKey,
				CptCode,
				CptDesc,
				CptTypeid,
				RVU,
				CMACUnit)
				VALUES(@cpt,@code,@desc,@type,@rvu,@cmac);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@desc <> @descX
		OR	@code <> @codeX
		OR	@rvu <> @rvuX
		OR	@cmac <> @cmacX
		OR 	(@desc Is Not Null AND @descX Is Null)
		OR	(@code Is Not Null AND @codeX Is Null)
		OR	(@rvu Is Not Null AND @rvuX Is Null)
		OR	(@cmac Is Not Null AND @cmacX Is Null)
			BEGIN
			UPDATE CPT
			SET 	CptCode = @code,
				CptDesc = @desc,
				CptTypeId = @type,
				RVU = @rvu,
				CMACUnit = @cmac,
				UpdatedDate = @today
			WHERE CptHcpcsKey = @cpt
			AND CptTypeId = @type;

			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curCpt INTO @cpt,@code,@desc,@type,@rvu,@cmac
	END
COMMIT
END


CLOSE curCpt
DEALLOCATE curCpt

SET @surow = 'Cpt Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Cpt Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Cpt Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Cpt',0;

END TRY
BEGIN CATCH
	EXEC dbo.upActivityLog ERROR_MESSAGE , @@ERROR
	EXEC upSendMail @Sub='SQL Server Error', @Msg = 'ERROR: ETL CPT'
END CATCH