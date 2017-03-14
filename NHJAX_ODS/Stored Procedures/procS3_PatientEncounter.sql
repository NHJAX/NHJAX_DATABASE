

CREATE PROCEDURE [dbo].[procS3_PatientEncounter] AS

Declare @err varchar(4000)

Declare @id int
Declare @pat int
Declare @key numeric(13,3)
Declare @pid bigint
Declare @dsur datetime
Declare @dur int
Declare @edate datetime
Declare @ssk int
Declare @crea int
Declare @dcan datetime
Declare @comm varchar(4000)

Declare @patX int
Declare @keyX numeric(13,3)
Declare @pidX bigint
Declare @dsurX datetime
Declare @durX int
Declare @edateX datetime
Declare @sskX int
Declare @creaX int
Declare @dcanX datetime
Declare @commX varchar(4000)

Declare @apt numeric(13,3)
Declare @pro bigint
Declare @can bigint
Declare @svc int
Declare @lu int
Declare @cby varchar(50)

Declare @urow int
Declare @trow int
Declare @irow int
Declare @drow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @sdrow varchar(50)
Declare @fromDate datetime
Declare @tempDate datetime
Declare @toDate datetime

Declare @exists int
Declare @day int

SET @tempDate = DATEADD(d,-90,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate);

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin S3 Encounters',0,@day;

DECLARE curS3 CURSOR FAST_FORWARD FOR
SELECT 
	PAT3.PatientId,
	PAT3.CHCSrowid, 
	PAT.PatientKey, 
	PAT.PatientId, 
	COALESCE (PAT3.estStartTime, 
	COALESCE (PAT3.CancelledOn, PAT3.DateSurgery)) AS AppointmentDateTime, 
    DATEDIFF(MINUTE, PAT3.NursingStartTime, PAT3.NursingEndTime) AS Duration, 
    PAT3.EntryDateTime, 
    PAT3.PatientID AS SourceSystemKey, 
    CASE PAT3.Cancelled 
		WHEN 1 THEN 3 
		ELSE 0 
	END AS PatientCancelledReasonId, 
	PAT3.CancelledOn, 
	ISNULL(PAT3.Remarks, '') + '|' 
	+ ISNULL(PAT3.NursAnesNotes, '') + '|' 
    + ISNULL(PAT3.FinalTimeOutNote, '') + '|' 
    + ISNULL(PAT3.CancellationNotes, '') + '|' 
    + ISNULL(CAN.LUReason,'') AS AppointmentComment,
    PAT3.CancelledBy
FROM [NHJAX-DB-S3].AORS.dbo.Patient AS PAT3 
	LEFT OUTER JOIN PATIENT AS PAT 
	ON PAT3.CHCSrowid = PAT.PatientKey 
	LEFT OUTER JOIN [NHJAX-DB-S3].AORS.dbo.LUCancelReason AS CAN 
	ON PAT3.CancelReason = CAN.LUReasonID
WHERE (PAT3.CHCSrowid IS NOT NULL) 
	AND (COALESCE (PAT3.estStartTime, 
	COALESCE (PAT3.CancelledOn, PAT3.DateSurgery)) > @fromDate)


OPEN curS3
SET @trow = 0
SET @irow = 0
SET @urow = 0
SET @drow = 0
EXEC dbo.upActivityLog 'Fetch S3 Encounters',0
FETCH NEXT FROM curS3 INTO @id,@pat,@key,@pid,@dsur,@dur,@edate,
	@ssk,@crea,@dcan,@comm,@cby
if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		--BEGIN TRY
		
		Select 	@edateX = DateAppointmentMade,
			@durX = Duration,
			@sskX = SourceSystemKey,
			@dcanX = CancellationDateTime,
			@commX = AppointmentComment,
			@dsurX = AppointmentDateTime
		FROM PATIENT_ENCOUNTER
		WHERE PatientId = @pid
		AND EncounterKey = @ssk
		AND SourceSystemId IN (10)
		
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
			
				SET @apt = dbo.GenerateEncounterKey(@pid)
				
				--Lookup ProviderId @pro
				SELECT @svc = ServiceId
				FROM [NHJAX-DB-S3].AORS.dbo.[Service]
				WHERE PatientID = @id
								
				SELECT @lu = LUSurgicalStaffID
				FROM [NHJAX-DB-S3].AORS.dbo.[SurgicalStaff]
				WHERE ServiceID = @svc
				AND [Role] = 'S'
				
				SELECT @pro = ProviderId
				FROM PROVIDER
				WHERE SourceSystemKey = @lu
				AND SourceSystemId = 10
				
				--Lookup Cancelled By @can
				IF(@dcan IS NOT NULL)
				BEGIN
				SELECT @can = CHCS_USER.CHCSUserId
				FROM CHCS_USER
				INNER JOIN vwENET_TECHNICIAN AS TECH
				ON CHCS_USER.SSN = TECH.SSN
				WHERE TECH.LoginId = @cby
				END

				INSERT INTO PATIENT_ENCOUNTER(
				PatientAppointmentKey,
				PatientId,
				AppointmentDateTime,
				HospitalLocationId,
				ProviderId,
				Duration,
				AppointmentStatusId,
				EncounterKey,
				AppointmentTypeId,
				DateAppointmentMade,
				PriorityId,
				SourceSystemId,
				MeprsCodeId,
				IsNonCount,
				DMISId,
				PatientCancelledReasonId,
				CancelledBy,
				CancellationDateTime,
				AppointmentComment,
				SourceSystemKey)
				VALUES(@apt,@pid,@dsur,185,@pro,@dur,
				305,@ssk,1305,@edate,0,10,95,1,1527,
				@crea,@can,@dcan,@comm,@ssk);
				--SELECT @idX = SCOPE_IDENTITY();
				SET @irow = @irow + 1	

			END
		ELSE
			BEGIN

			IF	@edate <> @edateX
			OR	(@edate Is Not Null AND @edateX Is Null)
			BEGIN
				UPDATE PATIENT_ENCOUNTER
				SET DateAppointmentMade = @edate,
					UpdatedDate = GETDATE()
				WHERE PatientAppointmentKey = @apt
				AND SourceSystemId IN (10)
				AND PatientId = @pid;
			END
			
			IF	@dsur <> @dsurX
			OR	(@dsur Is Not Null AND @dsurX Is Null)
			BEGIN
				UPDATE PATIENT_ENCOUNTER
				SET AppointmentDateTime = @dsur,
					UpdatedDate = GETDATE()
				WHERE PatientAppointmentKey = @apt
				AND SourceSystemId IN (10)
				AND PatientId = @pid;
			END
			
			IF @dur <> @durX
			OR (@dur Is Not Null AND @durX Is Null)
			BEGIN
				UPDATE PATIENT_ENCOUNTER
				SET Duration = @dur,
				UpdatedDate = GETDATE()
				WHERE PatientAppointmentKey = @apt
				AND SourceSystemId IN (10)
				AND PatientId = @pid;
			END
			
			IF @ssk <> @sskX
			OR (@ssk Is Not Null AND @sskX Is Null)
			BEGIN
				UPDATE PATIENT_ENCOUNTER
				SET SourceSystemKey = @ssk,
				UpdatedDate = GETDATE()
				WHERE PatientAppointmentKey = @apt
				AND SourceSystemId IN (10)
				AND PatientId = @pid;
			END
			
			IF @dcan <> @dcanX
			OR (@dcan Is Not Null AND @dcanX Is Null)
			BEGIN
				UPDATE PATIENT_ENCOUNTER
				SET CancellationDateTime = @dcan,
				UpdatedDate = GETDATE()
				WHERE PatientAppointmentKey = @apt
				AND SourceSystemId IN (10)
				AND PatientId = @pid;
			END
			
			IF @comm <> @commX
			OR (@comm Is Not Null AND @commX Is Null)
			BEGIN
				UPDATE PATIENT_ENCOUNTER
				SET AppointmentComment = @comm,
				UpdatedDate = GETDATE()
				WHERE PatientAppointmentKey = @apt
				AND SourceSystemId IN (10)
				AND PatientId = @pid;
			END
			
		END
		SET @trow = @trow + 1
		
		SET @can = NULL

		FETCH NEXT FROM curS3 INTO @id,@pat,@key,@pid,@dsur,@dur,@edate,
				@ssk,@crea,@dcan,@comm,@cby
			
	COMMIT
	END

END
CLOSE curS3
DEALLOCATE curS3

SET @surow = 'Patient S3 Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Patient S3 Inserted: ' + CAST(@irow AS varchar(50))
SET @sdrow = 'Patient S3 Deleted: ' + CAST(@drow AS varchar(50))
SET @strow = 'Patient S3 Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @sdrow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End S3 Encounters',0,@day;