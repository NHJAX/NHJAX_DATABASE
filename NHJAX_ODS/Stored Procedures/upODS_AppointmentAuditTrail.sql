
CREATE PROCEDURE [dbo].[upODS_AppointmentAuditTrail] AS

Declare @aud numeric(14,3)
Declare @stat bigint
Declare @loc bigint
Declare @ctr bigint
Declare @enc bigint
Declare @usr bigint
Declare @mod bigint

Declare @audX numeric(14,3)
Declare @statX bigint
Declare @locX bigint
Declare @ctrX bigint
Declare @encX bigint
Declare @usrX bigint
Declare @modX bigint

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

EXEC dbo.upActivityLog 'Begin Audit Trail',0,@day;

SET @tempDate = DATEADD(d,-20,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 
SET @today = getdate()

DECLARE curAud CURSOR FAST_FORWARD FOR
SELECT     
	AUD.KEY_APPOINTMENT_AUDIT_TRAIL, 
	ISNULL(STAT.AppointmentStatusId, 0) AS AppointmentStatusId, 
	ISNULL(LOC.HospitalLocationId, 0) AS HospitalLocationId, 
	ISNULL(CTR.MedicalCenterDivisionId, 0) AS MedicalCenterDivisionId, 
	ENC.PatientEncounterId, 
        	ISNULL(CHCS_USER.CHCSUserId, 0) AS CHCSUserId, 
	ISNULL(STAT_MOD.StatusModifierId,0) AS StatusModifierId
FROM    vwMDE_APPOINTMENT_AUDIT_TRAIL AUD 
	LEFT OUTER JOIN CHCS_USER 
	ON AUD.CLERK_IEN = CHCS_USER.CHCSUserKey 
	LEFT OUTER JOIN STATUS_MODIFIER STAT_MOD
	ON AUD.STATUS_MODIFIER = STAT_MOD.StatusModifierDesc
	INNER JOIN PATIENT_ENCOUNTER ENC 
	ON AUD.PATIENT_NAME_IEN = ENC.PatientAppointmentKey 
	LEFT OUTER JOIN MEDICAL_CENTER_DIVISION CTR 
	ON AUD.DIVISION_IEN = CTR.MedicalCenterDivisionKey 
	LEFT OUTER JOIN HOSPITAL_LOCATION LOC 
	ON AUD.CLINIC_IEN = LOC.HospitalLocationKey 
	LEFT OUTER JOIN APPOINTMENT_STATUS STAT 
	ON AUD.APPOINTMENT_STATUS_IEN = STAT.AppointmentStatusKey
WHERE  	(ENC.AppointmentDateTime > dbo.StartOfDay(@fromDate)) 

OPEN curAud
SET @trow = 0
SET @irow = 0

EXEC dbo.upActivityLog 'Fetch Audit Trail',0

FETCH NEXT FROM curAud INTO @aud,@stat,@loc,@ctr,@enc,@usr,@mod

if(@@FETCH_STATUS = 0)

BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@audX = AppointmentAuditTrailKey
		FROM NHJAX_ODS.dbo.APPOINTMENT_AUDIT_TRAIL
		WHERE AppointmentAuditTrailKey = @aud
		
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
			BEGIN TRANSACTION
				INSERT INTO NHJAX_ODS.dbo.APPOINTMENT_AUDIT_TRAIL(
				AppointmentAuditTrailKey,
				AppointmentStatusId,
				HospitalLocationId,
				MedicalCenterDivisionId,
				PatientEncounterId,
				CHCSUserId,
				StatusModifierId)
				VALUES(@aud,@stat,@loc,@ctr,@enc,@usr,@mod);
				SET @irow = @irow + 1
			COMMIT
			END
		
		SET @trow = @trow + 1
		FETCH NEXT FROM curAud INTO @aud,@stat,@loc,@ctr,@enc,@usr,@mod
	COMMIT	
	END

END


CLOSE curAud
DEALLOCATE curAud

SET @sirow = 'Audit Trail Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Audit Trail Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Audit Trail',0,@day;
