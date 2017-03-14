





CREATE PROCEDURE [dbo].[upCHK_Lab_Resul$Clinical_$Result$Appended_Amended_Rnr] AS

Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)

--Update Indexes
EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: LAB_RESUL$CLINICAL_$RESULT$APPNDED_AMNDED_RNR was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: LAB_RESUL$CLINICAL_$RESULT$APPNDED_AMNDED_RNR had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
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
WHERE TableName = 'LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR'





