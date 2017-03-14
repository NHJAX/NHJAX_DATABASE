






CREATE PROCEDURE [dbo].[upCHK_PDTS_Profile_Collection_F$Accepted_Response_Detail] AS

Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)

--Update Indexes
EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
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
WHERE TableName = 'PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL'






