
CREATE PROCEDURE [dbo].[upODS_Prescriptions] AS

--Update Indexes
Declare @Old bigint
Declare @New bigint
Declare @Diff Numeric(15,4)
Declare @Msg Varchar(200)

EXEC [NHJAX-CACHE].STAGING.dbo.upCreateIndexes_PRESCRIPTION

SELECT @Old = ActivityCount FROM ACTIVITY_COUNT WHERE TableName = 'PRESCRIPTION'
SELECT @New = Count(*) FROM [NHJAX-CACHE].STAGING.dbo.PRESCRIPTION

SET @Diff = 1 - (CAST(@New AS Numeric(15,4))/CAST(@Old AS Numeric(15,4)))

PRINT @Old
PRINT @New
PRINT @Diff

IF @New = 0
	BEGIN
	SET @Msg = 'MDE: PRESCRIPTION was 0'
	END
	
ELSE IF @DIFF >= .15 OR @DIFF <= -.25 OR @DIFF = 0
	BEGIN
	SET @Msg = 'MDE: PRESCRIPTION had a ' + CAST(@Diff AS Varchar(15)) + '% variance| OLD: ' + CAST(@Old AS Varchar(15)) + '| NEW: ' + CAST(@New AS Varchar(15))
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
WHERE TableName = 'PRESCRIPTION'

Declare @pre decimal
Declare @rx varchar(10)
Declare @pat bigint
Declare @pro bigint
Declare @drug bigint
Declare @qty numeric(15,5)
Declare @supply numeric(10,3)
Declare @refills numeric(8,3)
Declare @stat bigint
Declare @remain numeric(8,3)
Declare @fill datetime
Declare @expir datetime
Declare @order datetime
Declare @sig varchar(220)
Declare @sig1 varchar(28)
Declare @sig2 varchar(28)
Declare @sig3 varchar(29)
Declare @ex datetime
Declare @oid bigint
Declare @com varchar(80)
Declare @apre varchar(26)
DECLARE @edit bigint
Declare @log bigint

Declare @preX decimal
Declare @rxX varchar(10)
Declare @patX bigint
Declare @proX bigint
Declare @drugX bigint
Declare @qtyX numeric(15,5)
Declare @supplyX numeric(10,3)
Declare @refillsX numeric(8,3)
Declare @statX bigint
Declare @remainX numeric(8,3)
Declare @fillX datetime
Declare @expirX datetime
Declare @orderX datetime
Declare @sigX varchar(220)
Declare @sig1X varchar(28)
Declare @sig2X varchar(28)
Declare @sig3X varchar(29)
Declare @exX datetime
Declare @oidX bigint
Declare @comX varchar(80)
Declare @apreX varchar(26)
declare @editX bigint
Declare @logX bigint

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

EXEC dbo.upActivityLog 'Begin Prescription',0,@day;

SET @tempDate = DATEADD(d,-100,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 

DECLARE	curPrescription CURSOR FAST_FORWARD FOR 
SELECT	vwMDE_PRESCRIPTION.KEY_PRESCRIPTION, 
	vwMDE_PRESCRIPTION.RX_#, 
	PAT.PatientId, 
	PRO.ProviderId, 
	DRUG.DrugId, 
	vwMDE_PRESCRIPTION.QTY, 
	vwMDE_PRESCRIPTION.DAYS_SUPPLY, 
	vwMDE_PRESCRIPTION.REFILLS, 
	PS.PreStatusId, 
    vwMDE_PRESCRIPTION.REFILLS_REMAINING, 
	vwMDE_PRESCRIPTION.LAST_FILL_DATE, 
	vwMDE_PRESCRIPTION.FILL_EXPIRATION, 
	vwMDE_PRESCRIPTION.ORDER_DATE_TIME, 
	vwMDE_PRESCRIPTION.SIG, 
	vwMDE_PRESCRIPTION.SIG1, 
	vwMDE_PRESCRIPTION.SIG2, 
	vwMDE_PRESCRIPTION.SIG3, 
    vwMDE_PRESCRIPTION.EXPIRATION_DATE, 
	IsNull(ORD.OrderId,0) AS OrderId,
	vwMDE_PRESCRIPTION.COMMENTS, 
	vwMDE_PRESCRIPTION.PROVIDER_IEN,
	ISNULL(PE.PRESCRIPTIONEDITEDID,0) AS PRESCRIPTIONEDITEDID,
	vwMDE_PRESCRIPTION.LOGGED_BY_IEN
FROM    PRESCRIPTION_STATUS PS 
	INNER JOIN vwMDE_PRESCRIPTION 
	ON PS.PreStatusDesc = vwMDE_PRESCRIPTION.[STATUS] 
	INNER JOIN PATIENT PAT 
	ON vwMDE_PRESCRIPTION.PATIENT_IEN = PAT.PatientKey 
	INNER JOIN PROVIDER PRO 
	ON vwMDE_PRESCRIPTION.PROVIDER_IEN = PRO.ProviderKey 
	INNER JOIN DRUG 
	ON vwMDE_PRESCRIPTION.DRUG_IEN = DRUG.DrugKey 
	LEFT OUTER JOIN PATIENT_ORDER ORD 
	ON vwMDE_PRESCRIPTION.ORDER_POINTER_IEN = ORD.OrderKey
	LEFT OUTER JOIN PRESCRIPTION_EDITED PE
	ON vwMDE_PRESCRIPTION.EDITED = PE.EditedDesc
WHERE  	(vwMDE_PRESCRIPTION.EXPIRATION_DATE >= @fromDate)

OPEN curPrescription
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Prescription',0
FETCH NEXT FROM curPrescription INTO @pre,@rx,@pat,@pro,@drug,@qty,@supply,@refills,@stat,@remain,@fill,@expir,
		@order,@sig,@sig1,@sig2,@sig3,@ex,@oid,@com,@apre,@edit,@log

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@preX = PrescriptionKey,
			@rxX = RXNumber,
			@patX = PatientId,
			@proX = ProviderId,
			@drugX = DrugId,
			@qtyX = Quantity,
			@supplyX = DaysSupply,
			@refillsX = Refills,
			@statX = PreStatusId,
			@remainX = RefillsRemaining,
			@fillX = LastFillDate,
			@expirX = FillExpiration,
			@orderX = OrderDateTime,
			@sigX = Sig,
			@sig1X = Sig1,
			@sig2X = Sig2,
			@sig3X = Sig3,
			@exX = ExpirationDate,
			@oidX = OrderId,
			@comX = Comments,
			@apreX = AcceptedPrescriber,
			@editX = PrescriptionEditedId,
			@logX = LoggedBy
		FROM NHJAX_ODS.dbo.PRESCRIPTION
		WHERE PrescriptionKey = @pre
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PRESCRIPTION(
				PrescriptionKey,
				RXNumber,
				PatientId,
				ProviderId,
				DrugId,
				Quantity,
				DaysSupply,
				Refills,
				PreStatusId,
				RefillsRemaining,
				LastFillDate,
				FillExpiration,
				OrderDateTime,
				Sig,
				Sig1,
				Sig2,
				Sig3,
				ExpirationDate,
				OrderId,
				Comments,
				SourceSystemId,
				AcceptedPrescriber,
				PharmacyId,
				PrescriptionEditedId,
				LoggedBy)
				VALUES(@pre,@rx,@pat,@pro,@drug,@qty,@supply,@refills,@stat,@remain,@fill,@expir,
					@order,@sig,@sig1,@sig2,@sig3,@ex,@oid,@com,2,@apre,1,
					@edit,@log);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@rx <> @rxX
		OR	@pat <> @patX
		OR	@pro <> @proX
		OR	@drug <> @drugX
		OR	@qty <> @qtyX
		OR	@refills <> @refillsX
		OR	@stat <> @statX
		OR	@remain <> @remainX
		OR	@expir <> @expirX
		OR	@order <> @orderX
		OR	@sig <> @sigX
		OR	@sig1 <> @sig1X
		OR	@sig2 <> @sig2X
		OR	@sig3 <> @sig3X
		OR	@ex <> @exX	
		OR	@oid <> @oidX
		OR	@com <> @comX
		OR  @apre <> @apreX
		OR  @edit <> @editX
		OR 	(@rx Is Not Null AND @rxX Is Null)
		OR 	(@pat Is Not Null AND @patX Is Null)
		OR 	(@pro Is Not Null AND @proX Is Null)
		OR 	(@drug Is Not Null AND @drugX Is Null)
		OR 	(@qty Is Not Null AND @qtyX Is Null)
		OR 	(@refills Is Not Null AND @refillsX Is Null)
		OR 	(@stat Is Not Null AND @statX Is Null)
		OR 	(@remain Is Not Null AND @remainX Is Null)
		OR 	(@expir Is Not Null AND @expirX Is Null)
		OR 	(@order Is Not Null AND @orderX Is Null)
		OR 	(@sig Is Not Null AND @sigX Is Null)
		OR 	(@sig1 Is Not Null AND @sig1X Is Null)
		OR 	(@sig2 Is Not Null AND @sig2X Is Null)
		OR 	(@sig3 Is Not Null AND @sig3X Is Null)
		OR	(@ex Is Not Null AND @exX Is Null)
		OR	(@oid Is Not Null AND @oidX Is Null)
		OR	(@com Is Not Null AND @comX Is Null)
		OR  (@apre Is Not Null AND @apreX Is Null)
		OR  (@edit Is Not Null AND @editX Is Null)
			BEGIN
			--SET @today = getdate()
			UPDATE NHJAX_ODS.dbo.PRESCRIPTION
			SET 	RXNumber = @rx,
				PatientId = @pat,
				Providerid = @pro,
				DrugId = @drug,
				Quantity = @qty,
				Refills = @refills,
				PreStatusId = @stat,
				RefillsRemaining = @remain,
				FillExpiration = @expir,
				OrderDateTime = @order,
				Sig = @sig,
				Sig1 = @sig1,
				Sig2 = @sig2,
				Sig3 = @sig3,
				ExpirationDate = @ex,
				OrderId = @oid,
				Comments = @com,
				SourceSystemId = 2,
				AcceptedPrescriber = @apre,
				PharmacyId = 1,
				UpdatedDate = getdate(),
			    PrescriptionEditedId = @edit
			WHERE PrescriptionKey = @pre;
			SET @urow = @urow + 1
			END
			--Special Check for Fill date/Days supply = null only
			BEGIN
				IF (@fill Is Not Null AND @fillX Is Null)	
					BEGIN
						UPDATE PRESCRIPTION
						SET LastFillDate = @fill
						WHERE PrescriptionKey = @pre
					END
			END
			BEGIN
				IF (@supply Is Not Null AND @supplyX Is Null)	
					BEGIN
						UPDATE PRESCRIPTION
						SET DaysSupply = @supply
						WHERE PrescriptionKey = @pre
					END
			END
			IF (@log IS NOT NULL AND @logX IS NULL)
			BEGIN
				UPDATE PRESCRIPTION
				SET LoggedBy = @log,
				UpdatedDate = GETDATE()
				WHERE PrescriptionKey = @pre
			END
			--End Special Check
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curPrescription INTO @pre,@rx,@pat,@pro,@drug,@qty,@supply,@refills,@stat,@remain,
			@fill,@expir,@order,@sig,@sig1,@sig2,@sig3,@ex,@oid,@com,@apre,
			@edit,@log
		
	COMMIT	
	END
END

CLOSE curPrescription
DEALLOCATE curPrescription

SET @surow = 'Prescription Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Prescription Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Prescription Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Prescription',0,@day;


