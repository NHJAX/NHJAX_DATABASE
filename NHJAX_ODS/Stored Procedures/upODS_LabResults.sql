
CREATE PROCEDURE [dbo].[upODS_LabResults] AS


BEGIN TRY
Declare @err varchar(4000)
Declare @ern int

Declare @pat bigint
Declare @lab bigint
Declare @loc bigint
Declare @ord bigint
Declare @acc bigint
Declare @taken datetime
Declare @enter datetime
Declare @certify datetime
Declare @result varchar(19)
Declare @unit numeric(15,2)
Declare @key numeric(10,3)
Declare @sub numeric(26,9)
Declare @eusr bigint
Declare @samp bigint
Declare @log datetime
Declare @cusr bigint
Declare @rnr bigint
Declare @rdate datetime
Declare @com varchar(4000)

Declare @patX bigint
Declare @labX bigint
Declare @locX bigint
Declare @ordX bigint
Declare @accX bigint
Declare @takenX datetime
Declare @enterX datetime
Declare @certifyX datetime
Declare @resultX varchar(19)
Declare @unitX numeric(15,2)
Declare @keyX numeric(10,3)
Declare @subX numeric(26,9)
Declare @eusrX bigint
Declare @sampX bigint
Declare @logX datetime
Declare @cusrX bigint
Declare @rnrX bigint
Declare @rdateX datetime
Declare @comX varchar(4000)

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

Declare @Msg Varchar(2000)
Declare @subj varchar(50)

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Lab Result',0,@day;

SET @tempDate = DATEADD(d,-90,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 
SET @today = getdate()

DECLARE	curLabResult CURSOR FAST_FORWARD FOR 
SELECT	PAT.PatientId, 
	LAB.LabTestid, 
	LOC.HospitalLocationId, 
	dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY.DATE_TIME_SPECIMEN_TAKEN, 
	dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT.ENTER_DATE_TIME, 
	dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT.CERTIFY_DATE_TIME, 
    dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT.RESULT, 
	ISNULL(ORD.OrderId, 0) AS OrderId, 
	LAB.UnitCost, 
	PAT.PatientKey, 
	1 AS AccessionTypeId, 
    dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY.KEY_LAB_RESULT$CLINICAL_CHEMISTRY AS LabResultSubKey,
    EUSR.CHCSUserId,
    SAMP.CollectionSampleId,
    dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY.LOG_IN_DATE_TIME,
    CUSR.CHCSUserId,
    PROVIDER.ProviderId,
    dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT.RNR_DATE_TIME,
    '' AS Result_Comment
FROM    dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY 
	INNER JOIN dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT 
	ON dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY.KEY_LAB_RESULT$CLINICAL_CHEMISTRY = dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT.KEY_LAB_RESULT$CLINICAL_CHEMISTRY 
	AND dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY.KEY_LAB_RESULT = dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT.KEY_LAB_RESULT 
	INNER JOIN PATIENT PAT 
	ON dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY.KEY_LAB_RESULT = PAT.PatientKey 
	INNER JOIN HOSPITAL_LOCATION LOC 
	ON dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY.LAB_WORK_ELEMENT_IEN = LOC.HospitalLocationKey 
	INNER JOIN LAB_TEST LAB 
	ON dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT.TEST_IEN = LAB.LabTestKey 
	LEFT OUTER JOIN dbo.vwMDE_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR 
	ON dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT.KEY_LAB_RESULT = dbo.vwMDE_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR.KEY_LAB_RESULT 
	AND dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT.KEY_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT = dbo.vwMDE_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR.KEY_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT 
	AND dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT.KEY_LAB_RESULT$CLINICAL_CHEMISTRY = dbo.vwMDE_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR.KEY_LAB_RESULT$CLINICAL_CHEMISTRY 
	LEFT OUTER JOIN dbo.vwMDE_ORDER_TASK 
	INNER JOIN PATIENT_ORDER ORD 
	ON dbo.vwMDE_ORDER_TASK.ORDER_IEN = ORD.OrderKey 
	ON dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT.ORDER_TASK_IEN = dbo.vwMDE_ORDER_TASK.KEY_ORDER_TASK
	LEFT OUTER JOIN CHCS_USER AS EUSR
	ON dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT.ENTER_PERSON_IEN = EUSR.CHCSUserKey
	LEFT OUTER JOIN COLLECTION_SAMPLE AS SAMP
	ON dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY.COLLECTION_SAMPLE_IEN = SAMP.CollectionSampleKey
	LEFT OUTER JOIN CHCS_USER AS CUSR
	ON dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT.CERTIFY_PERSON_IEN = CUSR.CHCSUserKey
	LEFT OUTER JOIN PROVIDER
	ON dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT.RNR_HCP_IEN = PROVIDER.ProviderKey
WHERE   ((dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT.ENTER_DATE_TIME >= @fromDate)
OR	(dbo.vwMDE_LAB_RESULT$CLINICAL_CHEMISTRY$RESULT.CERTIFY_DATE_TIME >= @fromDate)
OR 	(dbo.vwMDE_LAB_RESUL$CLINICAL_$RESULT$APPENDED_AMENDED_RNR.APPENDED_AMENDED_RNR_DATE_TIME >= @fromDate)) 

UNION
SELECT	PAT.PatientId, 
	LAB.LabTestid, 
	HOSPITAL_LOCATION.HospitalLocationId, 
	dbo.vwMDE_LAB_RESULT$BACTERIOLOGY.DATE_TIME_SPECIMEN_TAKEN, 
	dbo.vwMDE_LAB_RESULT$BACTERIOLOGY$TEST.ENTER_DATE_TIME,
	dbo.vwMDE_LAB_RESULT$BACTERIOLOGY$TEST.CERTIFY_DATE_TIME, 
	NULL AS Result, 
	ISNULL(ORD.OrderId, 0) AS OrderId, 
	LAB.UnitCost, 
	PAT.PatientKey, 
	2 AS AccessionTypeId, 
    dbo.vwMDE_LAB_RESULT$BACTERIOLOGY.KEY_LAB_RESULT$BACTERIOLOGY AS LabResultSubKey,
    EUSR.CHCSUserId,
    SAMP.CollectionSampleId,
    dbo.vwMDE_LAB_RESULT$BACTERIOLOGY.LOG_IN_DATE_TIME,
    CUSR.CHCSUserId,
    ISNULL(PROVIDER.ProviderId,0) AS ProviderId,
    dbo.vwMDE_LAB_RESULT$BACTERIOLOGY$TEST.RNR_DATE_TIME,
    CAST(dbo.vwMDE_LAB_RESULT$BACTERIOLOGY$TEST.RESULT_COMMENT AS varchar(4000)) AS Result_Comment
FROM    dbo.vwMDE_LAB_RESULT$BACTERIOLOGY$TEST 
	INNER JOIN dbo.vwMDE_LAB_RESULT$BACTERIOLOGY 
	ON dbo.vwMDE_LAB_RESULT$BACTERIOLOGY$TEST.KEY_LAB_RESULT$BACTERIOLOGY = dbo.vwMDE_LAB_RESULT$BACTERIOLOGY.KEY_LAB_RESULT$BACTERIOLOGY 
	AND dbo.vwMDE_LAB_RESULT$BACTERIOLOGY$TEST.KEY_LAB_RESULT = dbo.vwMDE_LAB_RESULT$BACTERIOLOGY.KEY_LAB_RESULT 
	INNER JOIN PATIENT PAT 
	ON dbo.vwMDE_LAB_RESULT$BACTERIOLOGY.KEY_LAB_RESULT = PAT.PatientKey 
	INNER JOIN LAB_TEST LAB 
	ON dbo.vwMDE_LAB_RESULT$BACTERIOLOGY$TEST.TEST_IEN = LAB.LabTestKey 
	INNER JOIN HOSPITAL_LOCATION 
	ON dbo.vwMDE_LAB_RESULT$BACTERIOLOGY.LAB_WORK_ELEMENT_IEN = HOSPITAL_LOCATION.HospitalLocationKey 
	LEFT OUTER JOIN dbo.vwMDE_LAB_RESUL$BACTERIOL$TEST$APPENDED_AMENDED_RNR 
	ON dbo.vwMDE_LAB_RESULT$BACTERIOLOGY$TEST.KEY_LAB_RESULT = dbo.vwMDE_LAB_RESUL$BACTERIOL$TEST$APPENDED_AMENDED_RNR.KEY_LAB_RESULT 
	AND dbo.vwMDE_LAB_RESULT$BACTERIOLOGY$TEST.KEY_LAB_RESULT$BACTERIOLOGY$TEST = dbo.vwMDE_LAB_RESUL$BACTERIOL$TEST$APPENDED_AMENDED_RNR.KEY_LAB_RESULT$BACTERIOLOGY$TEST 
	AND dbo.vwMDE_LAB_RESULT$BACTERIOLOGY$TEST.KEY_LAB_RESULT$BACTERIOLOGY = dbo.vwMDE_LAB_RESUL$BACTERIOL$TEST$APPENDED_AMENDED_RNR.KEY_LAB_RESULT$BACTERIOLOGY 
	LEFT OUTER JOIN dbo.vwMDE_ORDER_TASK 
	INNER JOIN PATIENT_ORDER ORD 
	ON dbo.vwMDE_ORDER_TASK.ORDER_IEN = ORD.OrderKey 
	ON dbo.vwMDE_LAB_RESULT$BACTERIOLOGY$TEST.ORDER_TASK_IEN = dbo.vwMDE_ORDER_TASK.KEY_ORDER_TASK
	LEFT OUTER JOIN CHCS_USER AS EUSR
	ON dbo.vwMDE_LAB_RESULT$BACTERIOLOGY$TEST.ENTER_PERSON_IEN = EUSR.CHCSUserKey
	LEFT OUTER JOIN COLLECTION_SAMPLE AS SAMP
	ON dbo.vwMDE_LAB_RESULT$BACTERIOLOGY.COLLECTION_SAMPLE_IEN = SAMP.CollectionSampleKey
	LEFT OUTER JOIN CHCS_USER AS CUSR
	ON dbo.vwMDE_LAB_RESULT$BACTERIOLOGY$TEST.CERTIFY_PERSON_IEN = CUSR.CHCSUserKey
	LEFT OUTER JOIN PROVIDER
	ON dbo.vwMDE_LAB_RESULT$BACTERIOLOGY$TEST.RNR_HCP_IEN = PROVIDER.ProviderKey
WHERE   ((dbo.vwMDE_LAB_RESULT$BACTERIOLOGY$TEST.ENTER_DATE_TIME >= @fromDate)
OR	(dbo.vwMDE_LAB_RESULT$BACTERIOLOGY$TEST.CERTIFY_DATE_TIME >= @fromDate)
OR 	(dbo.vwMDE_LAB_RESUL$BACTERIOL$TEST$APPENDED_AMENDED_RNR.APPENDED_AMENDED_RNR_DATE_TIME >= @fromDate)) 

UNION
SELECT	PAT.PatientId, 
	1418 AS LabTestId, 
	HOSPITAL_LOCATION.HospitalLocationId, 
	dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN.DATE_TIME_SPECIMEN_RECEIVED, 
	dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN.ENTER_DATE_TIME,
	dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN.CERTIFY_DATE_TIME, 
	NULL AS Result, 
	ISNULL(ORD.OrderId, 0) AS OrderId, 
	0 AS UnitCost, 
	PAT.PatientKey, 
	7 AS AccessionTypeId, 
    dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN.KEY_LAB_RESULT$CYTOLOGY_GYN AS LabResultSubKey,
    EUSR.CHCSUserId,
    266 AS CollectionSampleId,
    '1/1/1776' AS LOG_IN_DATE_TIME,
    CUSR.CHCSUserId,
    ISNULL(PROVIDER.ProviderId,0) AS ProviderId,
    dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN.RNR_DATE_TIME,
    CAST(dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN.RESULT_COMMENT AS varchar(4000)) AS Result_Comment
FROM  dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN 
	INNER JOIN PATIENT PAT 
	ON dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN.KEY_LAB_RESULT = PAT.PatientKey 
	INNER JOIN HOSPITAL_LOCATION 
	ON dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN.LAB_WORK_ELEMENT_IEN = HOSPITAL_LOCATION.HospitalLocationKey 
	LEFT OUTER JOIN dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN$APPENDED_AMENDED_RNR 
	ON dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN.KEY_LAB_RESULT = dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN$APPENDED_AMENDED_RNR.KEY_LAB_RESULT 
	AND dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN.KEY_LAB_RESULT$CYTOLOGY_GYN = dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN$APPENDED_AMENDED_RNR.KEY_LAB_RESULT$CYTOLOGY_GYN 
	LEFT OUTER JOIN dbo.vwMDE_ORDER_TASK 
	ON dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN.ORDER_TASK_IEN = dbo.vwMDE_ORDER_TASK.KEY_ORDER_TASK
	INNER JOIN PATIENT_ORDER ORD 
	ON dbo.vwMDE_ORDER_TASK.ORDER_IEN = ORD.OrderKey 
	LEFT OUTER JOIN CHCS_USER AS EUSR
	ON dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN.ENTER_PERSON_IEN = EUSR.CHCSUserKey
	LEFT OUTER JOIN CHCS_USER AS CUSR
	ON dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN.CERTIFY_PERSON_IEN = CUSR.CHCSUserKey
	LEFT OUTER JOIN PROVIDER
	ON dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN.RNR_HCP_IEN = PROVIDER.ProviderKey
WHERE   ((dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN.ENTER_DATE_TIME >= @fromDate)
OR	(dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN.CERTIFY_DATE_TIME >= @fromDate)
OR 	(dbo.vwMDE_LAB_RESULT$CYTOLOGY_GYN$APPENDED_AMENDED_RNR.APPENDED_AMENDED_RNR_DATE_TIME >= @fromDate))


OPEN curLabResult
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Lab Result',0

FETCH NEXT FROM curLabResult INTO @pat,@lab,@loc,@taken,@enter,@certify,
	@result,@ord,@unit,@key,@acc,@sub,@eusr,@samp,@log,@cusr,@rnr,@rdate,
	@com

if(@@FETCH_STATUS = 0)

BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@patX = PatientId,
			@labX = LabTestId,
			@locX = LabWorkElementId,
			@takenX = TakenDate,
			@enterX = EnterDate,
			@certifyX = CertifyDate,
			@resultX = Result,
			@ordX = OrderId,
			@unitX = UnitCost,
			@keyX = LabResultKey,
			@accX = AccessionTypeId,
			@subX = LabResultSubKey,
			@eusrX = EnterPersonId,
			@sampX = CollectionSampleId,
			@logX = LogInDate,
			@cusrX = CertifyPersonId,
			@rnrX = RNRPersonId,
			@rdateX = RNRDate,
			@comX = ResultComments
		FROM NHJAX_ODS.dbo.LAB_RESULT
		WHERE PatientId = @pat
		AND LabTestId = @lab
		AND TakenDate = @taken
		SET @exists = @@RowCount

		
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.LAB_RESULT(
				PatientId,
				LabTestId,
				LabWorkElementId,
				TakenDate,
				EnterDate,
				CertifyDate,
				Result,
				OrderId,
				UnitCost,
				LabResultKey,
				AccessionTypeId,
				LabResultSubKey,
				EnterPersonId,
				CollectionSampleId,
				LogInDate,
				CertifyPersonId,
				RNRPersonId,
				RNRDate,
				ResultComments)
				VALUES(@pat,@lab,@loc,@taken,@enter,@certify,@result,
				@ord,@unit,@key,@acc,@sub,@eusr,@samp,@log,@cusr,@rnr,
				@rdate,@com);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
				IF	@loc <> @locX
				OR	@taken <> @takenX
				OR	@enter <> @enterX
				OR	@certify <> @certifyX
				OR	@result <> @resultX
				OR	@ord <> @ordX
				OR	@unit <> @unitX
				OR 	(@loc Is Not Null AND @locX Is Null)
				OR 	(@taken Is Not Null AND @takenX Is Null)
				OR 	(@enter Is Not Null AND @enterX Is Null)
				OR 	(@certify Is Not Null AND @certifyX Is Null)
				OR 	(@result Is Not Null AND @resultX Is Null)
				OR	(@ord > 0 AND @ordX = 0)
				OR	(@unit Is Not Null AND @unitX Is Null)
				OR	(@sub Is Not Null AND @subX Is Null)
					BEGIN		
			
					UPDATE NHJAX_ODS.dbo.LAB_RESULT
					SET 	LabWorkElementId = @loc,
						TakenDate = @taken,
						EnterDate = @enter,
						CertifyDate = @certify,
						Result = @result,
						Orderid = @ord,
						UnitCost = @unit,
						LabResultKey = @key,
						AccessionTypeId = @acc,
						LabResultSubKey = @sub,
						UpdatedDate = @today
					WHERE PatientId = @pat
					AND LabTestId = @lab
					AND TakenDate = @taken;

					SET @urow = @urow + 1
					END
					
				IF @eusr <> @eusrX
				OR (@eusr Is Not Null AND @eusrX Is Null)
				BEGIN
					UPDATE LAB_RESULT
					SET EnterPersonId = @eusr,
						UpdatedDate = GETDATE()
					WHERE PatientId = @pat
					AND LabTestId = @lab
					AND TakenDate = @taken;
				END
				
				IF @samp <> @sampX
				OR (@samp Is Not Null AND @sampX Is Null)
				BEGIN
					UPDATE LAB_RESULT
					SET CollectionSampleId = @samp,
						UpdatedDate = GETDATE()
					WHERE PatientId = @pat
					AND LabTestId = @lab
					AND TakenDate = @taken;
				END
				
				IF @log <> @logX
				OR (@log Is Not Null AND @logX Is Null)
				BEGIN
					UPDATE LAB_RESULT
					SET LogInDate = @log,
						UpdatedDate = GETDATE()
					WHERE PatientId = @pat
					AND LabTestId = @lab
					AND TakenDate = @taken;
				END
				
				IF @cusr <> @cusrX
				OR (@cusr Is Not Null AND @cusrX Is Null)
				BEGIN
					UPDATE LAB_RESULT
					SET CertifyPersonId = @cusr,
						UpdatedDate = GETDATE()
					WHERE PatientId = @pat
					AND LabTestId = @lab
					AND TakenDate = @taken;
				END
				
				IF @rnr <> @rnrX
				OR (@rnr Is Not Null AND @rnrX Is Null)
				BEGIN
					UPDATE LAB_RESULT
					SET RNRPersonId = @rnr,
						UpdatedDate = GETDATE()
					WHERE PatientId = @pat
					AND LabTestId = @lab
					AND TakenDate = @taken;
				END
				
				IF @rdate <> @rdateX
				OR (@rdate Is Not Null AND @rdateX Is Null)
				BEGIN
					UPDATE LAB_RESULT
					SET RNRDate = @rdate,
						UpdatedDate = GETDATE()
					WHERE PatientId = @pat
					AND LabTestId = @lab
					AND TakenDate = @taken;
				END
				
				IF @com <> @comX
				OR (@com Is Not Null AND @comX Is Null)
				BEGIN
					UPDATE LAB_RESULT
					SET ResultComments = @com,
						UpdatedDate = GETDATE()
					WHERE PatientId = @pat
					AND LabTestId = @lab
					AND TakenDate = @taken;
				END
					
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM curLabResult INTO @pat,@lab,@loc,@taken,@enter,
		@certify,@result,@ord,@unit,@key,@acc,@sub,@eusr,@samp,@log,@cusr,
		@rnr,@rdate,@com
		
	COMMIT
	END
END

CLOSE curLabResult
DEALLOCATE curLabResult

SET @surow = 'Lab Result Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Lab Result Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Lab Result Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Lab Result',0,@day;

END TRY
BEGIN CATCH
	SELECT @err = 'ERROR: ETL Lab Results ' + ERROR_MESSAGE();
	SELECT @ern = ERROR_NUMBER();

	EXEC dbo.upActivityLog @err , @ern
	EXEC upSendMail @sub='SQL Server Error', @Msg = @err
END CATCH