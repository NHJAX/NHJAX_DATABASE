





CREATE PROCEDURE [dbo].[upCHK_Lab_Test$Lab_Work_Element] AS

Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)

--Update Indexes
EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_LAB_TEST$LAB_WORK_ELEMENT

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'LAB_TEST$LAB_WORK_ELEMENT'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.LAB_TEST$LAB_WORK_ELEMENT

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: LAB_TEST$LAB_WORK_ELEMENT was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: LAB_TEST$LAB_WORK_ELEMENT had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
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
WHERE TableName = 'LAB_TEST$LAB_WORK_ELEMENT'





