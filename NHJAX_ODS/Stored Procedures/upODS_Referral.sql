
CREATE PROCEDURE [dbo].[upODS_Referral] AS


--Update Indexes : ORDER_
Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)


EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_ORDER_

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'ORDER_'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.ORDER_

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: ORDER_ was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25 OR @DIFF = 0
	BEGIN
	SET @Msg = 'MDE: ORDER_ had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
	END

IF LEN(@Msg) > 0
	BEGIN
	--PRINT @Msg
	EXEC upActivityLog @Msg, 99995
	EXEC upSendMail @Sub='MDE/SQL Server Warning - ODS', @msg=@Msg	
	END

--Update Indexes : MCP_REFERRAL
EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_MCP_REFERRAL

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'MCP_REFERRAL'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.MCP_REFERRAL

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: MCP_REFERRAL was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25
	BEGIN
	SET @Msg = 'MDE: MCP_REFERRAL had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
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
WHERE TableName = 'MCP_REFERRAL'

--UPDATE ACTIVITY_COUNT
UPDATE ACTIVITY_COUNT
SET ActivityCount = @new,
UpdatedDate = getdate()
WHERE TableName = 'ORDER_'

Declare @ref decimal
Declare @date datetime
Declare @reason varchar(5000)
Declare @proto bigint
Declare @locto bigint
Declare @proby bigint
Declare @locby bigint
Declare @ord bigint
Declare @ap bigint
Declare @vis decimal
Declare @pat bigint

Declare @refX decimal
Declare @dateX datetime
Declare @reasonX varchar(5000)
Declare @protoX bigint
Declare @loctoX bigint
Declare @probyX bigint
Declare @locbyX bigint
Declare @ordX bigint
Declare @apX bigint
Declare @visX decimal
Declare @patX bigint

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
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Referral',0,@day;

SET @tempDate = DATEADD(d,-360,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 
SET @today = getdate()

DECLARE curRef CURSOR FAST_FORWARD FOR
SELECT	REF.KEY_MCP_REFERRAL AS ReferralKey, 
	REF.REFERRAL_DATE_TIME AS ReferralDate, 
    REPLACE(REPLACE(CAST(REF.REASON_FOR_REFERRAL AS Varchar(5000)),'  ',' '),'  ',' '), 
	PROTo.ProviderId AS ReferredToProviderId, 
    LOCTo.HospitalLocationId AS ReferredToLocationId, 
	PROBy.ProviderId AS ReferredByProviderId, 
	LOCBy.HospitalLocationId AS ReferredByLocationId, 
    ORD.OrderId AS PatientOrderId, 
	ISNULL(ANCILLARY_PROCEDURE.AncillaryProcedureId, 0) AS AncillaryProcedureId,
	REF.NUMBER_OF_VISITS,
	PAT.PatientId
FROM    ANCILLARY_PROCEDURE 
	INNER JOIN PATIENT_ORDER ORD 
	INNER JOIN vwMDE_ORDER_ CDSS_ORD
	ON ORD.OrderKey = CDSS_ORD.KEY_ORDER 
	ON ANCILLARY_PROCEDURE.AncillaryProcedureKey = CDSS_ORD.ANCILLARY_PROCEDURE_IEN 
	RIGHT OUTER JOIN vwMDE_MCP_REFERRAL REF 
	ON ORD.OrderKey = REF.ORDER_IEN 
	LEFT OUTER JOIN HOSPITAL_LOCATION LOCBy 
	ON REF.REFERRAL_FROM_IEN = LOCBy.HospitalLocationKey 
	LEFT OUTER JOIN PROVIDER PROBy 
	ON REF.REFERRED_BY_IEN = PROBy.ProviderKey 
	LEFT OUTER JOIN PROVIDER PROTo 
	ON REF.REFERRED_TO_PROVIDER_IEN = PROTo.ProviderKey 
	LEFT OUTER JOIN HOSPITAL_LOCATION LOCTo 
	ON REF.REFERRED_TO_PLACE_OF_CARE_IEN = LOCTo.HospitalLocationKey
	INNER JOIN PATIENT AS PAT
	ON REF.PATIENT_IEN = PAT.PatientKey
WHERE  	(REF.REFERRAL_DATE_TIME >= @fromDate) 

OPEN curRef
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Referral',0

FETCH NEXT FROM curRef INTO @ref,@date,@reason,@proto,
	@locto,@proby,@locby,@ord,@ap,@vis,@pat

if(@@FETCH_STATUS = 0)

BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@refX = ReferralKey,
			@dateX = ReferralDate,
			@reasonX = ReasonForReferral,
			@protoX = ReferredToProviderId,
			@loctoX = ReferredToLocationId,
			@probyX = ReferredByProviderId,
			@locbyX = ReferredByLocationId,
			@ordX = PatientOrderid,
			@apX = AncillaryProcedureId,
			@visX = NumberofVisits,
			@patX = PatientId
		FROM NHJAX_ODS.dbo.REFERRAL
		WHERE ReferralKey = @ref
		
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
			BEGIN TRANSACTION
				INSERT INTO NHJAX_ODS.dbo.REFERRAL(
				ReferralKey,
				ReferralDate,
				ReasonForReferral,
				ReferredToProviderId,
				ReferredToLocationId,
				ReferredByProviderId,
				ReferredByLocationId,
				PatientOrderId,
				AncillaryProcedureId,
				ReferralNumber,
				NumberofVisits,
				PatientId)
				VALUES(
					@ref,
					@date,
					@reason,
					@proto,
					@locto,
					@proby,
					@locby,
					@ord,
					@ap,
					LEFT(CAST(@ref AS varchar(15)), 11),
					@vis,
					@pat
					);
				SET @irow = @irow + 1
			COMMIT
			END
		ELSE
			BEGIN
		IF	@date <> @dateX
		OR	@reason <> @reasonX
		OR	@proto <> @protoX
		OR	@locto <> @loctoX
		OR	@proby <> @probyX
		OR	@locby <> @locbyX
		OR	@ord <> @ordX
		OR	@ap <> @apX
		OR	@vis <> @visX
		OR	@pat <> @patX
		OR 	(@date Is Not Null AND @dateX Is Null)
		OR 	(@reason Is Not Null AND @reasonX Is Null)
		OR 	(@proto Is Not Null AND @protoX Is Null)
		OR 	(@locto Is Not Null AND @loctoX Is Null)
		OR 	(@proby Is Not Null AND @probyX Is Null)
		OR 	(@locby Is Not Null AND @locbyX Is Null)
		OR 	(@ord Is Not Null AND @ordX Is Null)
		OR	(@ap Is Not Null AND @apX Is Null)
		OR	(@vis Is Not Null AND @visX Is Null)
		OR	(@pat Is Not Null AND @patX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.REFERRAL
			SET 	ReferralDate = @date,
				ReasonForReferral = @reason,
				ReferredToProviderId = @proto,
				ReferredToLocationId = @locto,
				ReferredByProviderId = @proby,
				ReferredByLocationId = @locby,
				PatientOrderId = @ord,
				AncillaryProcedureId = @ap,
				NumberofVisits = @vis,
				PatientId = @pat,
				UpdatedDate = @today
			WHERE ReferralKey = @ref;

			SET @urow = @urow + 1
			END
			END
		
		
		SET @trow = @trow + 1
		FETCH NEXT FROM curRef INTO @ref,@date,@reason,@proto,
			@locto,@proby,@locby,@ord,@ap,@vis,@pat
	COMMIT	
	END

END


CLOSE curRef
DEALLOCATE curRef

SET @surow = 'Referral Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Referral Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Referral Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Referral',0,@day;
