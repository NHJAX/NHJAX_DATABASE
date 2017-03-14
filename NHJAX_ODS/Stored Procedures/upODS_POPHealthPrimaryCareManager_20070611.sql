

CREATE PROCEDURE [dbo].[upODS_POPHealthPrimaryCareManager_20070611] AS

Declare @pat bigint
Declare @pro bigint
Declare @enddate varchar(15)
Declare @pcmdate datetime
Declare @dmis bigint
Declare @enr int
Declare @pcm int

Declare @patX bigint
Declare @proX bigint
Declare @enddateX varchar(15)
Declare @pcmdateX datetime
Declare @dmisX bigint
Declare @enrX int
Declare @pcmX int

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @exists int

EXEC dbo.upActivityLog 'Begin POP PCM',0;
 
SET @today = getdate()
DECLARE curPCM CURSOR FAST_FORWARD FOR
SELECT	PAT.PatientId,
	PRO.ProviderId,
	PCM.PCM_PROJECTED_END_DATE, 
	DMIS.DMISId, 
	MPCM.MaxEnr, 
	MPCM.MaxPcm,
	PCM.PCM_ASSIGNED_DATE                     
FROM   vwMaxPcm MPCM 
	INNER JOIN vwMDE_NED_PATIENT$ENROLLMENT_HISTORY ENR 
	ON MPCM.KEY_NED_PATIENT = ENR.KEY_NED_PATIENT 
	AND MPCM.MaxEnr = ENR.KEY_NED_PATIENT$ENROLLMENT_HISTORY 
	INNER JOIN vwMDE_NED_PATIENT$ENROLLMENT_HISTORY$PCM_HISTORY PCM 
	ON MPCM.KEY_NED_PATIENT = PCM.KEY_NED_PATIENT 
	AND MPCM.MaxPcm = PCM.KEY_NED_PATIENT$ENROLLMENT_HISTORY$PCM_HISTORY 
	AND MPCM.MaxEnr = PCM.KEY_NED_PATIENT$ENROLLMENT_HISTORY 
	INNER JOIN vwPOPHealthPatientActivity PA
	ON PCM.KEY_NED_PATIENT = PA.PATIENT_IEN 
	INNER JOIN PATIENT PAT 
	ON ENR.KEY_NED_PATIENT = PAT.PatientKey 
	INNER JOIN PROVIDER PRO 
	ON PCM.PCM_IEN = PRO.ProviderKey 
	INNER JOIN DMIS 
	ON ENR.DMIS_ID_IEN = DMIS.DMISKey

OPEN curPCM
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch POP PCM',0
FETCH NEXT FROM curPCM INTO @pat,@pro,@enddate,@dmis,@enr,@pcm,@pcmdate
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@proX = ProviderId,
			@enddateX = PCMProjectedEndDate,
			@dmisX = DmisId,
			@enrX = EnrollmentHistoryNumber,
			@pcmX = PCMHistoryNumber,
			@pcmdateX = PCMEnrollmentDate
		FROM NHJAX_ODS.dbo.PRIMARY_CARE_MANAGER
		WHERE PatientId = @pat;
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PRIMARY_CARE_MANAGER(
				PatientId,
				ProviderId,
				PCMProjectedEndDate,
				DmisId,
				EnrollmentHistoryNumber,
				PCMHistoryNumber,
				PCMEnrollmentDate)
				VALUES(@pat,@pro,@enddate,@dmis,@enr,@pcm,@pcmdate);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@pro <> @proX
		OR	@enddate <> @enddateX
		OR	@dmis <> @dmisX
		OR	@enr <> @enrX
		OR	@pcm <> @pcmX
		OR	@pcmdate <> @pcmdateX	
		OR 	(@pro Is Not Null AND @proX Is Null)
		OR 	(@enddate Is Not Null AND @enddateX Is Null)
		OR 	(@dmis Is Not Null AND @dmisX Is Null)
		OR 	(@enr Is Not Null AND @enrX Is Null)
		OR 	(@pcm Is Not Null AND @pcmX Is Null)
		OR	(@pcmdate Is Not Null AND @pcmdateX Is Null)
			BEGIN
			SET @today = getdate()
			UPDATE NHJAX_ODS.dbo.PRIMARY_CARE_MANAGER
			SET 	ProviderId = @pro,
				PCMProjectedEndDate = @enddate,
				DmisId = @dmis,
				EnrollmentHistoryNumber = @enr,
				PCMHistoryNumber = @pcm,
				PCMEnrollmentDate = @pcmdate,
				UpdatedDate = @today
			WHERE PatientId = @pat;
			SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curPCM INTO @pat,@pro,@enddate,@dmis,@enr,@pcm,@pcmdate
	COMMIT	
	END
END
CLOSE curPCM
DEALLOCATE curPCM
SET @surow = 'POP PCM Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'POP PCM Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'POP PCM Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End POP PCM',0;

