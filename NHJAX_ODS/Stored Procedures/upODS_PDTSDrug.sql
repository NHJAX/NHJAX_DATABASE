

CREATE PROCEDURE [dbo].[upODS_PDTSDrug] AS

Declare @drug bigint
Declare @desc varchar(41)
Declare @ndc varchar(13)
Declare @pack varchar(15)
Declare @unit int
Declare @price money
Declare @ppu money
Declare @pdts money

Declare @drugX bigint
Declare @descX varchar(41)
Declare @ndcX varchar(13)
Declare @packX varchar(15)
Declare @unitX int
Declare @priceX money
Declare @ppuX money
Declare @pdtsX money

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

EXEC dbo.upActivityLog 'Begin PDTS Drug',0,@day;

SET @today = getdate()
DECLARE curDrug CURSOR FAST_FORWARD FOR
SELECT	DRUG.KEY_DRUG, 
	DRUG.NAME, 
	dbo.FormattedNDC(DRUG.PRIMARY_NDC_NUMBER_IEN) AS NDCNumber, 
	anti.PKG, 
	anti.Unit, 
	IsNull(anti.FSS_PRICE,0) AS FSSPrice, 
	IsNull(anti.[Price Per Unit],0) As PricePerUnit,
    IsNull(FORM.PDTS_UNIT_COST,0) AS PDTSUnitCost
FROM   vwMDE_CPG_ANTIBIOTIC anti 
	RIGHT OUTER JOIN vwMDE_DRUG DRUG 
	ON anti.NDC = dbo.FormattedNDC(DRUG.PRIMARY_NDC_NUMBER_IEN) 
	LEFT OUTER JOIN vwMDE_DRUG$ASSOCIATED_FORMULARY FORM 
	ON DRUG.KEY_DRUG = FORM.KEY_DRUG
WHERE   (FORM.KEY_DRUG$ASSOCIATED_FORMULARY = 1) 
AND DRUG.PRIMARY_NDC_NUMBER_IEN IS NOT NULL

OPEN curDrug
SET @trow = 0
SET @irow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch PDTS Drug',0

FETCH NEXT FROM curDrug INTO @drug,@desc,@ndc,@pack,@unit,@price,@ppu,@pdts
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
			@pdtsX = PDTSUnitCost
		FROM NHJAX_ODS.dbo.DRUG
		WHERE NDCNumber = @ndc
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
				SourceSystemId)
				VALUES(@drug,@desc,@ndc,@pack,@unit,@price,@ppu,@pdts,2);
				SET @irow = @irow + 1
			END
		ELSE IF @drugX = 0
			BEGIN
			UPDATE NHJAX_ODS.dbo.DRUG
			SET DrugDesc = @desc,
				DrugKey = @drug,
				Package = @pack,
				DrugUnit = @unit,
				FSSPrice = @price,
				PricePerUnit = @ppu,
				PDTSUnitCost = @pdts,
				UpdatedDate = @today
			WHERE NDCNumber = @ndc;
			SET @urow = @urow + 1
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM curDrug INTO @drug,@desc,@ndc,@pack,@unit,@price,@ppu,@pdts
	COMMIT
	END
END
CLOSE curDrug
DEALLOCATE curDrug
SET @surow = 'PDTS Drug Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'PDTS Drug Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PDTS Drug Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PDTS Drug',0,@day;

--Loop to add new PDTS Drugs

EXEC dbo.upActivityLog 'Begin PDTS Drug2',0,@day;

DECLARE curDrug CURSOR FAST_FORWARD FOR
SELECT ACCEPTED_DRUG_NAME,
		dbo.FormattedNDC(ACCEPTED_NDC_NUMBER)
FROM vwMDE_PDTS_PROFILE_COLLECTION_F$ACCEPTED_RESPONSE_DETAIL AS PDTS2

OPEN curDrug
SET @trow = 0
SET @irow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch PDTS Drug2',0

FETCH NEXT FROM curDrug INTO @desc,@ndc
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
			@pdtsX = PDTSUnitCost
		FROM NHJAX_ODS.dbo.DRUG
		WHERE NDCNumber = @ndc
		AND DrugDesc NOT LIKE 'XX%'
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.DRUG(
				DrugDesc,
				NDCNumber,
				SourceSystemId)
				VALUES(@desc,@ndc,5);
				SET @irow = @irow + 1
			END

		SET @trow = @trow + 1
		FETCH NEXT FROM curDrug INTO @desc,@ndc
	COMMIT
	END
END
CLOSE curDrug
DEALLOCATE curDrug

SET @surow = 'PDTS Drug2 Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'PDTS Drug2 Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PDTS Drug2 Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PDTS Drug2',0,@day;

