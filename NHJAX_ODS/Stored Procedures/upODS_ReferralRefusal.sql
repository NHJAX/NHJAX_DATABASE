
CREATE PROCEDURE [dbo].[upODS_ReferralRefusal] AS

Declare @key numeric(7,3)
Declare @ref bigint
Declare @stat bigint
Declare @rea bigint
Declare @date datetime

Declare @keyX numeric(7,3)
Declare @refX bigint
Declare @statX bigint
Declare @reaX bigint
Declare @dateX datetime

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)

Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Referral Refusal',0,@day;

DECLARE curRef CURSOR FAST_FORWARD FOR
SELECT	REF_REF.KEY_MCP_REFERRAL$APPOINTMENT_REFUSALS, 
	REF.ReferralId, 
	ISNULL(STAT.RefusalStatusId, 0) AS refusalstatusid, 
    ISNULL(REAS.RefusalReasonId, 15) AS RefusalReasonId,
	REF_REF.DATE_TIME
FROM    vwMDE_MCP_REFERRAL$APPOINTMENT_REFUSALS REF_REF 
	INNER JOIN REFERRAL REF 
	ON REF_REF.KEY_MCP_REFERRAL = REF.ReferralKey 
	LEFT OUTER JOIN REFUSAL_REASON REAS 
	ON REF_REF.REFUSAL_REASON_IEN = REAS.RefusalReasonKey 
	LEFT OUTER JOIN REFUSAL_STATUS STAT 
	ON REF_REF.REFUSAL_STATUS = STAT.RefusalStatusDesc

OPEN curRef
SET @trow = 0
SET @irow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch Referral Refusal',0

FETCH NEXT FROM curRef INTO @key,@ref,@stat,@rea,@date
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@statX = RefusalStatusId,
			@reaX = RefusalReasonId,
			@dateX = RefusalDateTime
		FROM NHJAX_ODS.dbo.REFERRAL_REFUSAL
		WHERE ReferralRefusalKey = @key
		AND ReferralId = @ref
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.REFERRAL_REFUSAL(
				ReferralId,
				ReferralRefusalKey,
				RefusalStatusId,
				RefusalReasonId,
				RefusalDateTime)
				VALUES(@ref,@key,@stat,@rea,@date);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@stat <> @statX
		OR	@rea <> @reaX
		OR	@date <> @dateX
		OR 	(@stat Is Not Null AND @statX Is Null)
		OR	(@rea Is Not Null AND @reaX Is Null)
		OR	(@date Is Not Null AND @dateX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.REFERRAL_REFUSAL
			SET 	RefusalStatusId = @stat,
				RefusalReasonId = @rea,
				RefusalDateTime = @date,
				UpdatedDate = getdate()
			WHERE ReferralRefusalKey = @key
			AND ReferralId = @ref;
			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curRef INTO @key,@ref,@stat,@rea,@date
	COMMIT
	END
END
CLOSE curRef
DEALLOCATE curRef
SET @surow = 'Referral Refusal Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Referral Refusal Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Referral Refusal Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Referral Refusal',0,@day;
