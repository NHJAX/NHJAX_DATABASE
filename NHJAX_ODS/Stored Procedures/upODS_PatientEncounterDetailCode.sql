
CREATE PROCEDURE [dbo].[upODS_PatientEncounterDetailCode] AS

Declare @appt bigint
Declare @dtl bigint

Declare @apptX bigint
Declare @dtlX bigint

Declare @trow int
Declare @irow int
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

EXEC dbo.upActivityLog 'Begin Patient Encounter Detail Code',0,@day;

SET @tempDate = DATEADD(d,-100,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 

DECLARE cur CURSOR FAST_FORWARD FOR
SELECT	ENC.PatientEncounterId, 
	DTL.AppointmentDetailId
FROM   APPOINTMENT_DETAIL_CODE DTL 
	INNER JOIN vwMDE_PATIENT_APPOINTMENT$APPT_DETAIL_CODES APPTDTL 
	ON DTL.AppointmentDetailKey = APPTDTL.APPT_DETAIL_CODES_IEN 
	INNER JOIN PATIENT_ENCOUNTER ENC 
	ON APPTDTL.KEY_PATIENT_APPOINTMENT = ENC.PatientAppointmentKey
WHERE ENC.AppointmentDateTime > @fromDate

OPEN cur
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch Patient Encounter Detail Code',0

FETCH NEXT FROM cur INTO @appt,@dtl

if(@@FETCH_STATUS = 0)

BEGIN
BEGIN TRANSACTION
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		Select 	@apptX = PatientEncounterId
		FROM NHJAX_ODS.dbo.PATIENT_ENCOUNTER_DETAIL_CODE
		WHERE 	PatientEncounterId = @appt
		AND	AppointmentDetailId = @dtl

		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PATIENT_ENCOUNTER_DETAIL_CODE(
				PatientEncounterId,AppointmentDetailId)
				VALUES(@appt,@dtl);
				SET @irow = @irow + 1
			END
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @appt,@dtl
	
	END
COMMIT
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'Patient Encounter Detail Code Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Patient Encounter Detail Code Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Patient Encounter Detail Code',0,@day;
