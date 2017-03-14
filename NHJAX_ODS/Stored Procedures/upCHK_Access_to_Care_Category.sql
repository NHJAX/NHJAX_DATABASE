



CREATE PROCEDURE [dbo].[upCHK_Access_to_Care_Category] AS

Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)

--Update Indexes
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





