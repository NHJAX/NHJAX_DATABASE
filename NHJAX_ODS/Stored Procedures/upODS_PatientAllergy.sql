

CREATE PROCEDURE [dbo].[upODS_PatientAllergy] AS

Declare @pat bigint
Declare @alrgy bigint
Declare @com varchar(151)
Declare @key numeric(8,3)

Declare @patX bigint
Declare @alrgyX bigint
Declare @comX varchar(151)
Declare @keyX numeric(8,3)

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

EXEC dbo.upActivityLog 'Begin Patient Allergy',0,@day;

SET @today = getdate()
DECLARE curAlrgy CURSOR FAST_FORWARD FOR
SELECT DISTINCT 
	PAT.PatientId, 
	AGY.AllergyId, 
	CHDA.COMMENT_,
	CHDA.KEY_CLINICAL_HISTORY$DRUG_ALLERGY
FROM   vwMDE_CLINICAL_HISTORY$DRUG_ALLERGY CHDA 
	INNER JOIN vwMDE_CLINICAL_HISTORY CH 
	ON CHDA.KEY_CLINICAL_HISTORY = CH.KEY_CLINICAL_HISTORY 
	INNER JOIN NHJAX_ODS.dbo.PATIENT PAT 
	ON CH.NAME_IEN = PAT.PatientKey 
	INNER JOIN NHJAX_ODS.dbo.ALLERGY AGY 
	ON CHDA.ALLERGY_SELECTION_IEN = AGY.AllergySelectionKey 
	INNER JOIN vwSTG_STG_PATIENT_ACTIVITY PACT 
	ON PAT.Patientkey = PACT.PATIENT_IEN

OPEN curAlrgy
SET @trow = 0
SET @irow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch Patient Allergy',0

FETCH NEXT FROM curAlrgy INTO @pat,@alrgy,@com,@key
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@patX = PatientId,
			@alrgyX = AllergyId,
			@comX = Comments,
			@keyX = PatientAllergyKey
		FROM NHJAX_ODS.dbo.PATIENT_ALLERGY
		WHERE PatientId = @pat
		AND AllergyId = @alrgy
		AND PatientAllergyKey = @key
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PATIENT_ALLERGY(
				PatientId,
				AllergyId,
				Comments,
				PatientAllergyKey)
				VALUES(@pat,@alrgy,@com,@key);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@com <> @comX
		OR	(@com Is Not Null AND @comX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.PATIENT_ALLERGY
			SET 	Comments = @com,
				UpdatedDate = @today
			WHERE PatientId = @pat
			AND AllergyId = @alrgy
			AND PatientAllergyKey = @key;
			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curAlrgy INTO @pat,@alrgy,@com,@key
	COMMIT
	END
END
CLOSE curAlrgy
DEALLOCATE curAlrgy
SET @surow = 'Patient Allergy Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Patient Allergy Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Patient Allergy Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Patient Allergy',0,@day;

