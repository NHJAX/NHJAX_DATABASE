

CREATE PROCEDURE [dbo].[upODS_EncounterDiagnosisFreeText] AS


Declare @enc bigint
Declare @diag numeric(7,3)
Declare @txt varchar(61)

Declare @encX bigint
Declare @diagX numeric(7,3)
Declare @txtX datetime

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)

Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Encounter Diagnosis Free Text',0,@day; 

DECLARE curTxt CURSOR FOR
SELECT	ENC.PatientEncounterId,
		TXT.KEY_ENCOUNTER$DIAGNOSIS__FREE_TEXT_,
		TXT.DIAGNOSIS__FREE_TEXT_
FROM	PATIENT_ENCOUNTER AS ENC 
		INNER JOIN vwMDE_ENCOUNTER$DIAGNOSIS__FREE_TEXT_ AS TXT 
		ON ENC.EncounterKey = TXT.KEY_ENCOUNTER

OPEN curTxt
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch Encounter Diagnosis Free Text',0

FETCH NEXT FROM curTxt INTO @enc,@diag,@txt

if(@@FETCH_STATUS = 0)

BEGIN
BEGIN TRANSACTION
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		Select 	@encX = PatientEncounterId
		FROM 	NHJAX_ODS.dbo.ENCOUNTER_DIAGNOSIS_FREE_TEXT
		WHERE 	PatientEncounterId = @enc
		AND	EncounterDiagnosisFreeTextKey = @diag

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.ENCOUNTER_DIAGNOSIS_FREE_TEXT
				(
					PatientEncounterId,
					EncounterDiagnosisFreeTextKey,
					DiagnosisFreeText
				)
				VALUES(@enc,@diag,@txt);
				SET @irow = @irow + 1
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM curTxt INTO @enc,@diag,@txt
	END
COMMIT
END

CLOSE curTxt
DEALLOCATE curTxt

SET @sirow = 'Encounter Diagnosis Free Text Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Encounter Diagnosis Free Text Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

EXEC dbo.upActivityLog 'End Encounter Diagnosis Free Text',0,@day;


