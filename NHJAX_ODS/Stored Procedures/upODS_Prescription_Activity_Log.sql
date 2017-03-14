


CREATE PROCEDURE [dbo].[upODS_Prescription_Activity_Log] AS
Declare @pre numeric(14,3)
Declare @rx bigint
Declare @date datetime
Declare @cmts varchar(100)
--Declare @logged bigint
DECLARE @rem varchar(100)
Declare @site bigint
Declare @assoc numeric(8,3)
Declare @reason int
Declare @pro bigint

Declare @preX numeric(14,3)
Declare @rxX bigint
Declare @dateX datetime
Declare @cmtsX varchar(100)
--Declare @loggedX bigint
DECLARE @remX varchar(100)
Declare @siteX bigint
Declare @assocX numeric(8,3)
Declare @reasonX int
Declare @proX bigint

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @fromDate datetime
Declare @tempDate datetime
Declare @today datetime
Declare @exists int
Declare @start datetime
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

--truncate table NHJAX_ODS.dbo.PRESCRIPTION_ACTIVITY_LOG

EXEC dbo.upActivityLog 'Begin Prescription Activity Log',0,@day;

SET @tempDate = DATEADD(yy,-20,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 

SET @start = dateadd(dd,-10,getdate())

DECLARE	curLog CURSOR FAST_FORWARD FOR 

SELECT distinct		 ALOG.KEY_PRESCRIPTION$ACTIVITY_LOG
					 ,PRE.PrescriptionId
					 ,ALOG.ACTIVITY_LOG
					 ,ISNULL(ALOG.USER_COMMENTS, '') AS USER_COMMENTS
					-- ,CHCS_USER.CHCSUserId
					 ,ISNULL(ALOG.REMARKS,'') AS REMARKS
					 ,ALOG.PHARMACY_SITE_IEN
					 ,ALOG.ASSOCIATED_FILL_NUMBER
					 ,REASON.PrescriptionReasonId
					 ,PRE.ProviderId

FROM				  vwMDE_PRESCRIPTION_ACTIVITY_LOG ALOG INNER JOIN
                      PRESCRIPTION PRE ON ALOG.KEY_PRESCRIPTION = PRE.PrescriptionKey INNER JOIN
                      PRESCRIPTION_ACTIVITY_LOG_REASON REASON ON 
                      ALOG.REASON_CODE_IEN = REASON.ReasonCodeKey

where				  alog.Activity_Log >= @start

OPEN curLog
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Prescription Activity Log',0
FETCH NEXT FROM curLog INTO @pre,@rx,@date,@cmts,@rem,@site,@assoc,@reason,@pro

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@preX = PrescriptionActivityLogKey
				,@rxX = PrescriptionId
				,@dateX = ActivityLogDate
				,@cmtsX =UserComments
				--,@logged = LoggedBy
				,@remX = Remarks
				,@siteX = PharmacySiteId
				,@assocX = AssociatedFillNumber
				,@reasonX = ReasonCodeId
				,@proX = AuthorizingProviderId

		FROM NHJAX_ODS.dbo.PRESCRIPTION_ACTIVITY_LOG
		WHERE PrescriptionId = @rx
		and		PrescriptionActivityLogKey = @pre
		--and		Usercomments  =@cmts
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PRESCRIPTION_ACTIVITY_LOG(
				PrescriptionActivityLogKey,
				PrescriptionId,
				ActivityLogDate,
				UserComments,
				--LoggedBy,
				Remarks,
				PharmacySiteId,
				AssociatedFillNumber,
				ReasonCodeId,
				AuthorizingProviderId
				)
				VALUES(@pre,@rx,@date,@cmts,@rem,@site,@assoc,@reason,@pro);
				SET @irow = @irow + 1
			END
--		ELSE
--		BEGIN
--		IF	
----			@pre <> @preX
----		OR	@rx <> @rxX
----		OR	@date <> @dateX
----			@cmts <> @cmtsX
--		--OR	@logged <> @loggedX
--		OR  @rem <> @remX
--		OR	@site <> @siteX
--		OR	@assoc <> @assocX
--		OR	@reason <> @reasonX
--		OR	@pro <> @proX
----		OR 	(@pre Is Not Null AND @preX Is Null)
----		OR 	(@rx Is Not Null AND @rxX Is Null)
----		OR 	(@date Is Not Null AND @dateX Is Null)
--		OR 	(@cmts Is Not Null AND @cmtsX Is Null)
----		OR 	(@logged Is Not Null AND @loggedX Is Null)
--		OR	(@rem Is Not Null and @remX is Null)
--		OR 	(@site Is Not Null AND @siteX Is Null)
--		OR 	(@assoc Is Not Null AND @assocX Is Null)
--		OR 	(@reason Is Not Null AND @reasonX Is Null)
--		OR 	(@pro Is Not Null AND @proX Is Null)
--			BEGIN
--			SET @today = getdate()
--			UPDATE NHJAX_ODS.dbo.PRESCRIPTION_ACTIVITY_LOG
--			SET 	PrescriptionActivityLogKey = @pre,
--				PrescriptionId = @rx,
--				ActivityLogDate = @date,
--				UserComments = @cmts,
--				--LoggedBy = @logged,
--				Remarks = @rem,
--				PharmacySiteId = @site,
--				AssociatedFillNumber = @assoc,
--				ReasonCodeId = @reason,
--				AuthorizingProviderId = @pro
--			WHERE PrescriptionActivityLogKey = @pre;
--			SET @urow = @urow + 1
--			END
--		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curLog INTO @pre,@rx,@date,@cmts,@rem,@site,@assoc,@reason,@pro
		
	COMMIT	
	END
END

CLOSE curLog
DEALLOCATE curLog

SET @surow = 'Prescription Activity Log Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Prescription Activity Log Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Prescription Activity Log Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Prescription Activity Log',0,@day;