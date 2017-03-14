
CREATE PROCEDURE [dbo].[upODS_ReferralReviewStatus] AS

Declare @ref bigint
Declare @rev bigint
Declare @dt datetime
Declare @key numeric(8,3)
Declare @com varchar(4000)

Declare @refX bigint
Declare @revX bigint
Declare @dtX datetime
Declare @keyX numeric(8,3)
Declare @comX varchar(4000)

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @fromDate datetime
Declare @tempDate datetime
Declare @today datetime
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Referral Review Status',0,@day;

SET @tempDate = DATEADD(d,-1000,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 

DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT
	REF.ReferralId, 
	STAT.ReviewStatusId, 
	REV.REVIEW_DATE_TIME, 
	REV.KEY_MCP_REFERRAL$APPOINTMENT_REQUEST_REVIEW, 
	CAST(REV.REVIEW_COMMENT AS varchar(4000))
FROM REFERRAL AS REF 
	INNER JOIN vwMDE_MCP_REFERRAL$APPOINTMENT_REQUEST_REVIEW AS REV 
	ON REF.ReferralKey = REV.KEY_MCP_REFERRAL 
	INNER JOIN REVIEW_STATUS AS STAT 
	ON REV.APPOINTMENT_REQUEST_STATUS_IEN = STAT.ReviewStatusKey 


OPEN cur
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch Referral Review Status',0

FETCH NEXT FROM cur INTO @ref,@rev,@dt,@key,@com

if(@@FETCH_STATUS = 0)

BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@refX = ReferralId,
			@revX = ReviewStatusId,
			@keyX = ReferralReviewStatusKey
		FROM NHJAX_ODS.dbo.REFERRAL_REVIEW_STATUS
		WHERE ReferralId = @ref
		AND ReviewStatusId = @rev
		AND ReferralReviewStatusKey = @key
		
		SET @exists = @@RowCount
		
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.REFERRAL_REVIEW_STATUS(
				ReferralId,
				ReviewStatusId,
				ReferralReviewDate,
				ReferralReviewStatusKey,
				ReviewComment)
				VALUES(@ref,@rev,@dt,@key,@com);
				SET @irow = @irow + 1
			END
		
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @ref,@rev,@dt,@key,@com
		
	COMMIT
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'Referral Review Status Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Referral Review Status Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Referral Review Status',0,@day;
