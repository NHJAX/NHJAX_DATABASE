

create PROCEDURE [dbo].[xxxODS_gCareEncounter20090601] AS

Declare @enc numeric(13,3)
Declare @pat bigint
Declare @dt datetime
Declare @stat bigint
Declare @desc varchar(80)
Declare @key varchar(50)

Declare @exists int

DECLARE cur CURSOR FAST_FORWARD FOR
SELECT   DISTINCT  
	PAT.PatientId, 
	ENC.Date, 
    CASE ENC.Status 
		WHEN 'completed' THEN 2 
		WHEN 'no show' THEN 4 
		WHEN 'rescheduled' THEN 200 
		WHEN 'started' THEN 201 
		WHEN 'waiting' THEN 202 
		WHEN 'cancelled' THEN 3 
		WHEN 'scheduled' THEN 203 
		ELSE 0 
	END AS AppointmentStatusId, 
	ENC.Purpose AS ReasonForAppointment,
	ENC.EventID
FROM  vwXXX_Patient20090522 AS PAT 
INNER JOIN vwXXX_Appointments20090529 AS ENC 
ON PAT.PatientKey = ENC.PatientID
WHERE ENC.EventID IS NOT NULL

OPEN cur

FETCH NEXT FROM cur INTO @pat,@dt,@stat,@desc,@key
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN	
	BEGIN TRANSACTION
		--must update generator before calling function.
		UPDATE GENERATOR SET LastNumber=LastNumber+1

		SET @enc = dbo.GenerateEncounterKey(@pat)
		
		INSERT INTO PATIENT_ENCOUNTER
		(
			EncounterKey,
			PatientId,
			AppointmentDateTime,
			AppointmentStatusId,
			ReasonForAppointment,
			SourceSystemId,
			SourceSystemKey
		)
		VALUES
		(
			@enc,@pat,@dt,@stat,@desc,12,@key
		)
		FETCH NEXT FROM cur INTO @pat,@dt,@stat,@desc,@key
	COMMIT
	END
END
CLOSE cur
DEALLOCATE cur

