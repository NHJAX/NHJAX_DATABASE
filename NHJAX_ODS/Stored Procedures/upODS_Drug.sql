

CREATE PROCEDURE [dbo].[upODS_Drug] AS

Declare @drug bigint
Declare @desc varchar(41)
Declare @ndc varchar(13)
Declare @pack varchar(15)
Declare @unit int
Declare @price money
Declare @ppu money
Declare @pdts money
Declare @lpn varchar(40)
declare @mu varchar(15)
declare @dea varchar(30)
declare @ahfs bigint
declare @tc bigint
Declare @str numeric(20,5)
Declare @rte bigint
Declare @frm bigint

Declare @drugX bigint
Declare @descX varchar(41)
Declare @ndcX varchar(13)
Declare @packX varchar(15)
Declare @unitX int
Declare @priceX money
Declare @ppuX money
Declare @pdtsX money
Declare @lpnX varchar(40)
DECLARE @muX varchar(15)
declare @deaX varchar(30)
declare @ahfsX bigint
declare @tcX bigint
Declare @strX numeric(20,5)
Declare @rteX bigint
Declare @frmX bigint

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Drug',0,@day;

SET @today = getdate()
DECLARE curDrug CURSOR FAST_FORWARD FOR
SELECT	DRUG.KEY_DRUG, 
	DRUG.NAME, 
	dbo.FormattedNDC(DRUG.PRIMARY_NDC_NUMBER_IEN) AS NDCNumber, 
	anti.PKG, 
	anti.Unit, 
	IsNull(anti.FSS_PRICE,0) AS FSSPrice, 
	IsNull(anti.[Price Per Unit],0) As PricePerUnit,
	IsNull(FORM.PDTS_UNIT_COST,0) AS PDTSUnitCost,
	DRUG.LABEL_PRINT_NAME,
	DRUG.METRIC_UNIT,
	ISNULL(DRUG.DEA_SPECIAL_HDLG, 'U') AS DEA_SPECIAL_HDLG,
	ISNULL(AHFS.AHFSClassificationId, 0) AS AHFSClassificationId,
	ISNULL(TC.TherapeuticClassId, 0) AS TherapeuticClassId,
	ISNULL(RTE.DrugRouteId, 0) AS DrugRouteId,
	ISNULL(FRM.DrugFormId, 0) AS DrugFormId,
	DRUG.DOSAGE_STRENGTH
FROM   vwMDE_CPG_ANTIBIOTIC anti 
	RIGHT OUTER JOIN vwMDE_DRUG DRUG 
	ON anti.NDC = dbo.FormattedNDC(DRUG.PRIMARY_NDC_NUMBER_IEN) 
	LEFT OUTER JOIN vwMDE_DRUG$ASSOCIATED_FORMULARY FORM 
	ON DRUG.KEY_DRUG = FORM.KEY_DRUG
	LEFT OUTER JOIN AHFS_CLASSIFICATION AS AHFS
	ON AHFS.AHFSClassificationDesc = DRUG.AHFS_CLASSIFICATION
	LEFT OUTER JOIN THERAPEUTIC_CLASS AS TC
	ON TC.TherapeuticClassDesc = DRUG.THERAPEUTIC_CLASS
	LEFT OUTER JOIN DRUG_ROUTE AS RTE
	ON DRUG.ROUTE_IEN = RTE.DrugRouteKey
	LEFT OUTER JOIN DRUG_FORM AS FRM
	ON DRUG.FORM_IEN = FRM.DrugFormKEy
WHERE   (FORM.KEY_DRUG$ASSOCIATED_FORMULARY = 1)

OPEN curDrug
SET @trow = 0
SET @irow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch Drug',0

FETCH NEXT FROM curDrug INTO @drug,@desc,@ndc,@pack,@unit,
	@price,@ppu,@pdts,@lpn,@mu,@dea,@ahfs,@tc,@rte,@frm,@str
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN	
	BEGIN TRANSACTION
		Select 	@drugX = DrugKey,
			@descX = DrugDesc,
			@ndcX = NDCNumber,
			@packX = Package,
			@unitX = DrugUnit,
			@priceX = FSSPrice,
			@ppuX = PricePerUnit,
			@pdtsX = PDTSUnitCost,
			@lpnX = LabelPrintName,
			@muX = MetricUnit,
			@deaX = DrugScheduleCode,
			@ahfsX = AHFSClassificationId,
			@tcX = TherapeuticClassId,
			@rteX = DrugRouteId,
			@frmX = DrugFormId,
			@strX = DosageStrength
		FROM NHJAX_ODS.dbo.DRUG
		WHERE DrugKey = @drug
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.DRUG(
				DrugKey,
				DrugDesc,
				NDCNumber,
				Package,
				DrugUnit,
				FSSPrice,
				PricePerUnit,
				PDTSUnitCost,
				SourceSystemId,
				LabelPrintName,
				MetricUnit,
				DrugScheduleCode,
				AHFSClassificationId,
				TherapeuticClassId,
				DrugRouteId,
				DrugFormId,
				DosageStrength)
				VALUES(@drug,@desc,@ndc,@pack,@unit,@price,
					@ppu,@pdts,2,@lpn,@mu,@dea,@ahfs,@tc,
					@rte,@frm,@str);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN		
		IF	@desc <> @descX
		OR	@ndc <> @ndcX
		OR	@pack <> @packX
		OR	@unit <> @unitX
		OR	@price <> @priceX
		OR	@ppu <> @ppuX
		OR	@pdts <> @pdtsX
		OR	@lpn <> @lpnX
		OR  @mu <> @muX
		OR  @dea <> @deaX
		OR 	(@desc Is Not Null AND @descX Is Null)
		OR	(@ndc Is Not Null AND @ndcX Is Null)
		OR	(@pack Is Not Null AND @packX Is Null)
		OR	(@unit Is Not Null AND @unitX Is Null)
		OR	(@price Is Not Null AND @priceX Is Null)
		OR	(@ppu Is Not Null AND @ppuX Is Null)
		OR	(@pdts Is Not Null AND @pdtsX Is Null)
		OR	(@lpn Is Not Null AND @lpnX Is Null)
		OR	(@mu Is Not Null AND @muX Is Null)
		OR   (@dea Is Not Null AND @deaX Is Null)		
			BEGIN
			UPDATE NHJAX_ODS.dbo.DRUG
			SET 	DrugDesc = @desc,
				NDCNumber = @ndc,
				Package = @pack,
				DrugUnit = @unit,
				FSSPrice = @price,
				PricePerUnit = @ppu,
				PDTSUnitCost = @pdts,
				LabelPrintName = @lpn,
				MetricUnit = @mu,
				UpdatedDate = @today,
				DrugScheduleCode = @dea
			WHERE DrugKey = @drug;
			SET @urow = @urow + 1
			END
			IF @ahfs <> @ahfsX
				OR 	(@ahfs Is Not Null AND @ahfsX Is Null)
				BEGIN
					UPDATE DRUG
					SET AHFSClassificationId = @ahfs,
						UpdatedDate = GetDate()
					WHERE DrugKey = @drug;
				END
			IF @tc <> @tcX
				OR 	(@tc Is Not Null AND @tcX Is Null)
				BEGIN
					UPDATE DRUG
					SET TherapeuticClassId = @tc,
						UpdatedDate = GetDate()
					WHERE DrugKey = @drug;
				END
			IF @rte <> @rteX
				OR 	(@rte Is Not Null AND @rteX Is Null)
				BEGIN
					UPDATE DRUG
					SET DrugRouteId = @rte,
						UpdatedDate = GetDate()
					WHERE DrugKey = @drug;
				END
			IF @frm <> @frmX
				OR 	(@frm Is Not Null AND @frmX Is Null)
				BEGIN
					UPDATE DRUG
					SET DrugFormId = @frm,
						UpdatedDate = GetDate()
					WHERE DrugKey = @drug;
				END
			IF @str <> @strX
				OR 	(@str Is Not Null AND @strX Is Null)
				BEGIN
					UPDATE DRUG
					SET DosageStrength = @str,
						UpdatedDate = GetDate()
					WHERE DrugKey = @drug;
				END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curDrug INTO @drug,@desc,@ndc,@pack,
			@unit,@price,@ppu,@pdts,@lpn,@mu,@dea,@ahfs,@tc,
			@rte,@frm,@str
	COMMIT
	END
END
CLOSE curDrug
DEALLOCATE curDrug
SET @surow = 'Drug Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Drug Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Drug Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Drug',0,@day;


