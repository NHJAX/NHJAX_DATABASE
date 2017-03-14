
CREATE PROCEDURE [dbo].[upODS_EncounterDiagnosis] AS
Declare @enc bigint
Declare @diag bigint
Declare @priority int
Declare @desc varchar(64)
Declare @encX bigint
Declare @diagX bigint
Declare @priorityX int
Declare @descX varchar(64)
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

EXEC dbo.upActivityLog 'Begin Encounter Diagnosis',0,@day;

SET @tempDate = DATEADD(d,-100,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 


DECLARE curEncDiag CURSOR FAST_FORWARD FOR
SELECT	PATENC.PatientEncounterId, 
		DIAG.DiagnosisId, 
		1 AS PRIORITY, 
		DIAG.DiagnosisDesc
FROM   	vwMDE_ENCOUNTER ENC 
		INNER JOIN PATIENT_ENCOUNTER PATENC 
		ON ENC.KEY_ENCOUNTER = PATENC.EncounterKey 
		INNER JOIN DIAGNOSIS DIAG 
		ON ENC.DRG_CODE_IEN = DIAG.DiagnosisKey
WHERE   	(ENC.DATE_TIME >= @fromDate) 
AND 		PATENC.PatientAppointmentKey = 0
UNION	SELECT PATENC.PatientEncounterId, 
		DIAG.DiagnosisId, 
		ENCD.KEY_ENCOUNTER$DIAGNOSIS AS PRIORITY, 
		DIAG.DiagnosisDesc
FROM	vwMDE_ENCOUNTER AS ENC 
		INNER JOIN PATIENT_ENCOUNTER AS PATENC 
		ON ENC.KEY_ENCOUNTER = PATENC.EncounterKey 
		INNER JOIN vwMDE_ENCOUNTER$DIAGNOSIS AS ENCD 
		ON ENC.KEY_ENCOUNTER = ENCD.KEY_ENCOUNTER 
		INNER JOIN DIAGNOSIS AS DIAG 
		ON ENCD.DIAGNOSIS_IEN = DIAG.DiagnosisKey
WHERE   	(ENC.DATE_TIME >= @fromDate) 
AND 		PATENC.PatientAppointmentKey = 0
UNION 	SELECT PATENC.PatientEncounterId, 
		DIAG.DiagnosisId, 
		CASE KGICD.PRIORITY
		WHEN 'U' THEN 0
		ELSE
		ISNULL(KGICD.PRIORITY,0)
		END AS PRIORITY, 
		KGICD.DESCRIPTION
FROM   	vwMDE_KG_ADC_DATA$ICD_DIAGNOSIS KGICD 
		INNER JOIN vwMDE_KG_ADC_DATA KG 
		ON KGICD.KEY_KG_ADC_DATA = KG.KEY_KG_ADC_DATA 
		INNER JOIN vwMDE_PATIENT_APPOINTMENT APPT 
		INNER JOIN PATIENT_ENCOUNTER PATENC 
		ON APPT.KEY_PATIENT_APPOINTMENT = PATENC.PatientAppointmentKey 
		ON KG.APPOINTMENT_IEN = APPT.KEY_PATIENT_APPOINTMENT 
		INNER JOIN DIAGNOSIS DIAG 
		ON KGICD.ICD_DIAGNOSIS_IEN = DIAG.DiagnosisKey
WHERE 	APPT.APPOINTMENT_DATE_TIME >= @fromDate

OPEN curEncDiag
SET @trow = 0
SET @irow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch Encounter Diagnosis',0

FETCH NEXT FROM curEncDiag INTO @enc,@diag,@priority,@desc
if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@encX = PatientEncounterId,
			@diagX = DiagnosisId,
			@priorityX = Priority,
			@descX = Description
		FROM NHJAX_ODS.dbo.ENCOUNTER_DIAGNOSIS
		WHERE PatientEncounterId = @enc
		AND DiagnosisId = @diag
		AND Priority = @priority
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.ENCOUNTER_DIAGNOSIS(
				PatientEncounterId,
				DiagnosisId,
				Priority,
				Description)
				VALUES(@enc,@diag,@priority,@desc);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@priority <> @priorityX
		OR	@desc <> @descX
		OR 	(@priority Is Not Null AND @priorityX Is Null)
		OR 	(@desc Is Not Null AND @descX Is Null)
			BEGIN
			SET @today = getdate()
			UPDATE NHJAX_ODS.dbo.ENCOUNTER_DIAGNOSIS
			SET 	Priority = @priority,
				Description = @desc,
				UpdatedDate = @today
			WHERE PatientEncounterId = @enc
			AND DiagnosisId = @diag
			AND Priority = @priority;
			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curEncDiag INTO @enc,@diag,@priority,@desc
	COMMIT
	END

END
CLOSE curEncDiag
DEALLOCATE curEncDiag
SET @surow = 'Encounter Diagnosis Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Encounter Diagnosis Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Encounter Diagnosis Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Encounter Diagnosis',0,@day;
