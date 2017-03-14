


CREATE PROCEDURE [dbo].[upODS_PrimaryCareManager] AS

Declare @pat bigint
Declare @pro bigint
Declare @pcmdate datetime
Declare @dmis bigint
Declare @enr int
Declare @pcm int
Declare @loc bigint

Declare @patX bigint
Declare @proX bigint
Declare @pcmdateX datetime
Declare @dmisX bigint
Declare @enrX int
Declare @pcmX int
Declare @locX bigint

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin PCM NDI',0,@day;

--Reset before each pass
UPDATE PRIMARY_CARE_MANAGER
SET IsUpdated = 0;

DECLARE cur CURSOR FAST_FORWARD FOR
SELECT   DISTINCT  
	PATIENT.PatientId, 
	PROVIDER.ProviderId, 
	DMIS.DMISId,
	0 AS MaxEnr,
	0 AS MaxPcm,
	NDI.PCM_START_DATE, 
	ISNULL(LOC.HospitalLocationId,0) AS HospitalLocation
FROM vwSTG_STG_PATIENT_ACTIVITY AS PA 
	INNER JOIN vwMDE_NDI_ELIGIBILITY AS NDI 
	ON PA.Patient_Ien = NDI.PATIENT_NAME_IEN 
	INNER JOIN PATIENT 
	ON PA.Patient_Ien = PATIENT.PatientKey 
	INNER JOIN PROVIDER 
	ON NDI.PCM_ID = PROVIDER.NPIKey 
	OR NDI.PCM_ID + '.000' = PROVIDER.NPIKey
	LEFT JOIN HOSPITAL_LOCATION AS LOC 
	ON PROVIDER.LocationId = LOC.HospitalLocationId 
	LEFT JOIN MEPRS_CODE AS MEP 
	ON LOC.MeprsCodeId = MEP.MeprsCodeId 
	INNER JOIN DMIS 
	ON NDI.PCM_DMIS_IEN = DMIS.DMISKey

	
OPEN cur
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch PCM NDI',0

FETCH NEXT FROM cur INTO @pat,@pro,@dmis,@enr,@pcm,@pcmdate,@loc
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
	Select 	@proX = ProviderId,
			@dmisX = DmisId,
			@enrX = EnrollmentHistoryNumber,
			@pcmX = PCMHistoryNumber,
			@pcmdateX = PCMEnrollmentDate,
			@locX = HospitalLocationId
		FROM NHJAX_ODS.dbo.PRIMARY_CARE_MANAGER
		WHERE PatientId = @pat;
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PRIMARY_CARE_MANAGER(
				PatientId,
				ProviderId,
				DmisId,
				EnrollmentHistoryNumber,
				PCMHistoryNumber,
				PCMEnrollmentDate,
				HospitalLocationId,
				IsUpdated)
				VALUES(@pat,@pro,@dmis,@enr,@pcm,@pcmdate,@loc,1);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@pro <> @proX
		OR	@dmis <> @dmisX
		OR	@enr <> @enrX
		OR	@pcm <> @pcmX
		OR	@pcmdate <> @pcmdateX
		OR	@loc <> @locX
		OR 	(@pro Is Not Null AND @proX Is Null)
		OR 	(@dmis Is Not Null AND @dmisX Is Null)
		OR 	(@enr Is Not Null AND @enrX Is Null)
		OR 	(@pcm Is Not Null AND @pcmX Is Null)
		OR	(@pcmdate Is Not Null AND @pcmdateX Is Null)
		OR	(@loc Is Not Null AND @locX Is Null)
			BEGIN
			
			UPDATE NHJAX_ODS.dbo.PRIMARY_CARE_MANAGER
			SET ProviderId = @pro,
				DmisId = @dmis,
				EnrollmentHistoryNumber = @enr,
				PCMHistoryNumber = @pcm,
				PCMEnrollmentDate = @pcmdate,
				HospitalLocationId = @loc,
				IsUpdated = 1,
				UpdatedDate = GETDATE()
			WHERE PatientId = @pat;
			SET @urow = @urow + 1
			END
		ELSE
			BEGIN
				UPDATE PRIMARY_CARE_MANAGER
				SET IsUpdated = 1
				WHERE PatientID = @pat;
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @pat,@pro,@dmis,@enr,@pcm,@pcmdate,@loc
	COMMIT	
	END
END
CLOSE cur
DEALLOCATE cur
SET @surow = 'PCM NDI Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'PCM NDI Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PCM NDI Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PCM NDI',0;

--Secondary check for patients not updated by NDI pass-- 
EXEC dbo.upActivityLog 'Begin PCM NED',0;

DECLARE curPCM CURSOR FAST_FORWARD FOR
SELECT     
	PAT.PatientId, 
	PRO.ProviderId, 
	DMIS.DMISId, 
	MPCM.MaxEnr, 
	MPCM.MaxPcm, 
	PCM.PCM_ASSIGNED_DATE, 
	HOSPITAL_LOCATION.HospitalLocationId
FROM MEPRS_CODE 
	INNER JOIN HOSPITAL_LOCATION 
	ON MEPRS_CODE.MeprsCodeId = HOSPITAL_LOCATION.MeprsCodeId 
	INNER JOIN vwSTG_STG_MAX_PCM AS MPCM 
	INNER JOIN vwMDE_NED_PATIENT$ENROLLMENT_HISTORY AS ENR 
	ON MPCM.KEY_NED_PATIENT = ENR.KEY_NED_PATIENT 
	AND MPCM.MaxEnr = ENR.KEY_NED_PATIENT$ENROLLMENT_HISTORY 
	INNER JOIN vwMDE_NED_PATIENT$ENROLLMENT_HISTORY$PCM_HISTORY AS PCM 
	ON MPCM.KEY_NED_PATIENT = PCM.KEY_NED_PATIENT 
	AND MPCM.MaxPcm = PCM.KEY_NED_PATIENT$ENROLLMENT_HISTORY$PCM_HISTORY 
	AND MPCM.MaxEnr = PCM.KEY_NED_PATIENT$ENROLLMENT_HISTORY 
	INNER JOIN vwSTG_STG_PATIENT_ACTIVITY AS PA 
	ON PCM.KEY_NED_PATIENT = PA.Patient_Ien 
	INNER JOIN PATIENT AS PAT 
	ON ENR.KEY_NED_PATIENT = PAT.PatientKey 
	INNER JOIN PROVIDER AS PRO 
	ON PCM.PCM_IEN = PRO.ProviderKey 
	INNER JOIN DMIS 
	ON ENR.DMIS_ID_IEN = DMIS.DMISKey 
	--INNER JOIN vwODS_PRIMARY_CARE_MANAGER_NotUpdated AS PCMX 
	--ON PAT.PatientId = PCMX.PatientID 
	ON HOSPITAL_LOCATION.HospitalLocationId = PRO.LocationId
WHERE PAT.PatientId NOT IN
	(
		SELECT PatientId FROM vwODS_PRIMARY_CARE_MANAGER_NotUpdated
	)


OPEN curPCM
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch PCM NED',0
FETCH NEXT FROM curPCM INTO @pat,@pro,@dmis,@enr,@pcm,@pcmdate,@loc
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@proX = ProviderId,
			@dmisX = DmisId,
			@enrX = EnrollmentHistoryNumber,
			@pcmX = PCMHistoryNumber,
			@pcmdateX = PCMEnrollmentDate,
			@locX = HospitalLocationId
		FROM NHJAX_ODS.dbo.PRIMARY_CARE_MANAGER
		WHERE PatientId = @pat;
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PRIMARY_CARE_MANAGER(
				PatientId,
				ProviderId,
				DmisId,
				EnrollmentHistoryNumber,
				PCMHistoryNumber,
				PCMEnrollmentDate,
				HospitalLocationId,
				IsUpdated)
				VALUES(@pat,@pro,@dmis,@enr,@pcm,@pcmdate,@loc,1);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@pro <> @proX
		OR	@loc <> @locX
		OR	@dmis <> @dmisX
		OR	@enr <> @enrX
		OR	@pcm <> @pcmX
		OR	@pcmdate <> @pcmdateX	
		OR 	(@pro Is Not Null AND @proX Is Null)
		OR 	(@loc Is Not Null AND @locX Is Null)
		OR 	(@dmis Is Not Null AND @dmisX Is Null)
		OR 	(@enr Is Not Null AND @enrX Is Null)
		OR 	(@pcm Is Not Null AND @pcmX Is Null)
		OR	(@pcmdate Is Not Null AND @pcmdateX Is Null)
			BEGIN
			
			UPDATE NHJAX_ODS.dbo.PRIMARY_CARE_MANAGER
			SET ProviderId = @pro,
				HospitalLocationId = @loc,
				DmisId = @dmis,
				EnrollmentHistoryNumber = @enr,
				PCMHistoryNumber = @pcm,
				PCMEnrollmentDate = @pcmdate,
				UpdatedDate = GETDATE(),
				IsUpdated = 1
			WHERE PatientId = @pat;
			SET @urow = @urow + 1
			END
			ELSE
			BEGIN
				UPDATE PRIMARY_CARE_MANAGER
				SET IsUpdated = 1
				WHERE PatientID = @pat;
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curPCM INTO @pat,@pro,@dmis,@enr,@pcm,@pcmdate,@loc
	COMMIT	
	END
END
CLOSE curPCM
DEALLOCATE curPCM

--Third Check for NDI External Updates 2014-10-16 KSK
DECLARE cur CURSOR FAST_FORWARD FOR
SELECT   DISTINCT  
	PATIENT.PatientId, 
	PROVIDER.ProviderId, 
	DMIS.DMISId,
	0 AS MaxEnr,
	0 AS MaxPcm,
	NDI.PCM_START_DATE, 
	LOC.HospitalLocationId	
FROM vwSTG_STG_PATIENT_ACTIVITY AS PA 
	INNER JOIN vwMDE_NDI_ELIGIBILITY AS NDI 
	ON PA.Patient_Ien = NDI.PATIENT_NAME_IEN 
	INNER JOIN vwMDE_PROVIDER AS PRO 
	ON NDI.PCM_ID = PRO.NPI_ID 
	INNER JOIN PATIENT 
	ON PA.Patient_Ien = PATIENT.PatientKey 
	INNER JOIN PROVIDER ON PRO.KEY_PROVIDER = PROVIDER.ProviderKey 
	INNER JOIN HOSPITAL_LOCATION AS LOC 
	ON PROVIDER.LocationId = LOC.HospitalLocationId 
	INNER JOIN MEPRS_CODE AS MEP 
	ON LOC.MeprsCodeId = MEP.MeprsCodeId 
	INNER JOIN DMIS 
	ON NDI.PCM_DMIS_IEN = DMIS.DMISKey

	
OPEN cur
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch PCM NDI X',0

FETCH NEXT FROM cur INTO @pat,@pro,@dmis,@enr,@pcm,@pcmdate,@loc
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
	Select 	@proX = ProviderId,
			@dmisX = DmisId,
			@enrX = EnrollmentHistoryNumber,
			@pcmX = PCMHistoryNumber,
			@pcmdateX = PCMEnrollmentDate,
			@locX = HospitalLocationId
		FROM NHJAX_ODS.dbo.PRIMARY_CARE_MANAGER
		WHERE PatientId = @pat;
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.PRIMARY_CARE_MANAGER(
				PatientId,
				ProviderId,
				DmisId,
				EnrollmentHistoryNumber,
				PCMHistoryNumber,
				PCMEnrollmentDate,
				HospitalLocationId,
				IsUpdated)
				VALUES(@pat,@pro,@dmis,@enr,@pcm,@pcmdate,@loc,1);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@pro <> @proX
		OR	@dmis <> @dmisX
		OR	@enr <> @enrX
		OR	@pcm <> @pcmX
		OR	@pcmdate <> @pcmdateX
		OR	@loc <> @locX
		OR 	(@pro Is Not Null AND @proX Is Null)
		OR 	(@dmis Is Not Null AND @dmisX Is Null)
		OR 	(@enr Is Not Null AND @enrX Is Null)
		OR 	(@pcm Is Not Null AND @pcmX Is Null)
		OR	(@pcmdate Is Not Null AND @pcmdateX Is Null)
		OR	(@loc Is Not Null AND @locX Is Null)
			BEGIN
			
			UPDATE NHJAX_ODS.dbo.PRIMARY_CARE_MANAGER
			SET ProviderId = @pro,
				DmisId = @dmis,
				EnrollmentHistoryNumber = @enr,
				PCMHistoryNumber = @pcm,
				PCMEnrollmentDate = @pcmdate,
				HospitalLocationId = @loc,
				IsUpdated = 1,
				UpdatedDate = GETDATE()
			WHERE PatientId = @pat;
			SET @urow = @urow + 1
			END
		ELSE
			BEGIN
				UPDATE PRIMARY_CARE_MANAGER
				SET IsUpdated = 1
				WHERE PatientID = @pat;
			END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @pat,@pro,@dmis,@enr,@pcm,@pcmdate,@loc
	COMMIT	
	END
END
CLOSE cur
DEALLOCATE cur
SET @surow = 'PCM NDI X Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'PCM NDI X Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PCM NDI X Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PCM NDI X',0;

--20131028 - delete records not updated
DELETE FROM PRIMARY_CARE_MANAGER
WHERE IsUpdated = 0
AND DATEDIFF(DAY,UpdatedDate,GETDATE()) > 120

SET @surow = 'PCM NED Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'PCM NED Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PCM NED Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PCM NED',0,@day;


