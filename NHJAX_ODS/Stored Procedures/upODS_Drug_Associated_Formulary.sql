

CREATE PROCEDURE [dbo].[upODS_Drug_Associated_Formulary] 

AS

Declare @site numeric(5,0)
Declare @drug numeric(14,3)
Declare @assoc numeric(7,3)
Declare @ien numeric(21,3)
Declare @lc numeric(18,5)
Declare @pdtsuc numeric(18,5)
Declare @sys int 

Declare @siteX numeric(5,0)
Declare @drugX numeric(14,3)
Declare @assocX numeric(7,3)
Declare @ienX numeric(21,3)
Declare @lcX numeric(18,5)
Declare @pdtsucX numeric(18,5)
declare @sysX int

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

EXEC dbo.upActivityLog 'Begin Drug Associated Formulary',0,@day;

SET @today = getdate()
DECLARE curDrugAssocForm CURSOR FAST_FORWARD FOR
SELECT		KEY_SITE,
			KEY_DRUG,
			KEY_DRUG$ASSOCIATED_FORMULARY,
			ASSOCIATED_FORMULARY_IEN,
			LOCAL_COST,
			PDTS_UNIT_COST,
			2
FROM         [nhjax-cache].staging.dbo.DRUG$ASSOCIATED_FORMULARY form
WHERE   (KEY_DRUG$ASSOCIATED_FORMULARY = 1)

OPEN curDrugAssocForm
SET @trow = 0
SET @irow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch Drug Associated Formulary',0

FETCH NEXT FROM curDrugAssocForm INTO @site,@drug,@assoc,@ien,@lc,@pdtsuc,@sys
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
	
	Select 	@siteX = KeySite,
			@drugX = KeyDrug,
			@assocX = KeyDrug_AssociatedFormulary,
			@ienX = AssociatedFormularyIEN,
			@lcX = LocalCost,
			@pdtsucX = PDTSUnitCost,
			@sysX = SourceSystemId
			
		FROM NHJAX_ODS.dbo.DRUG_ASSOCIATED_FORMULARY
		WHERE keydrug = @drug
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.DRUG_ASSOCIATED_FORMULARY(
				KeySite,
				KeyDrug,
				KeyDrug_AssociatedFormulary,
				AssociatedFormularyIEN,
				LocalCost,
				PDTSUnitCost,
				SourceSystemId
				)
				VALUES(@site,@drug,@assoc,@ien,@lc,@pdtsuc,2);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@site <> @siteX
		OR	@drug <> @drugX
		OR	@assoc <> @assocX
		OR	@ien <> @ienX
		OR	@lc <> @lcX
		OR	@pdtsuc <> @pdtsucX
		OR	@sys <> @sysX
		OR 	(@site Is Not Null AND @siteX Is Null)
		OR	(@drug Is Not Null AND @drugX Is Null)
		OR	(@assoc Is Not Null AND @assocX Is Null)
		OR	(@ien Is Not Null AND @ienX Is Null)
		OR	(@lc Is Not Null AND @lcX Is Null)
		OR	(@pdtsuc Is Not Null AND @pdtsucX Is Null)
		OR  (@sys is Not Null and @sysX is Null)
					BEGIN
			UPDATE NHJAX_ODS.dbo.DRUG_ASSOCIATED_FORMULARY
			SET 	KeySite = @site,
					KeyDrug = @drug,
					KeyDrug_AssociatedFormulary = @assoc,
					AssociatedFormularyIEN = @ien,
					LocalCost = @lc,
					PDTSUnitCost = @pdtsuc,
					sourceSystemId = 2				
					
			WHERE Keydrug = @drug;
			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curDrugAssocForm INTO @site,@drug,@assoc,@ien,@lc,@pdtsuc,@sys
	COMMIT
	END
END
CLOSE curDrugAssocForm
DEALLOCATE curDrugAssocForm
SET @surow = 'Drug Associated Formulary Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Drug Associated Formulary Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Drug Associated Formulary Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Drug Associated Formulary',0,@day;



