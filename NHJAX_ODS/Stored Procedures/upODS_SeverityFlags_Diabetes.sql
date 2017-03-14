


CREATE PROCEDURE [dbo].[upODS_SeverityFlags_Diabetes]

AS
	DECLARE @tempDate datetime
	DECLARE @fromDate datetime
	DECLARE @loop int
	DECLARE @exists int

	DECLARE @pat bigint
	DECLARE @disp int
	DECLARE @er int
    DECLARE @hosp int
	DECLARE	@labs int
	DECLARE @enc int
		
SET @tempDate = DATEADD(d,-30,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate);
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

--PRINT @fromDate

EXEC dbo.upActivityLog 'Begin Severity Flags Diabetes',0,@day;


DELETE FROM SEVERITY_FLAG
WHERE DiseaseManagementId = 2;

DECLARE curFlag CURSOR FAST_FORWARD FOR
	SELECT DISTINCT 
		PatientId
	FROM PATIENT_FLAG
	WHERE FlagId = 2

OPEN curFlag

EXEC dbo.upActivityLog 'Fetch Severity Flags Diabetes',0
FETCH NEXT FROM curFlag INTO @pat

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		BEGIN TRANSACTION

		--Check Flags
			--Dispensing Events				
			SELECT @disp = COUNT
				(PrescriptionId)
			FROM DISPENSING_EVENT
			WHERE PatientId = @pat
			AND DiseaseManagementId = 2

			If(@disp = 0) 
			  BEGIN
				INSERT INTO SEVERITY_FLAG
				(PatientStatId,
				 PatientId,
				 DiseaseManagementId)	 
					Values (15, @pat, 2)					
			  End

			--ER 30 Days
			SELECT @er = COUNT
				(PatientEncounterId)
			FROM PATIENT_ENCOUNTER
			WHERE (PatientId = @pat)
			AND (AppointmentDateTime > @fromDate)
			AND HospitalLocationId = 174	

			If(@er > 0)
			  BEGIN 
				INSERT INTO	SEVERITY_FLAG
				(PatientStatId,
				 PatientId,
				 DiseaseManagementId)		
					Values(13, @pat, 2)
			  END

			--Hospitalized 30 days
			SELECT	@hosp =	count(PatientEncounterId)
			FROM        PATIENT_ENCOUNTER
			WHERE		(PatientId = @pat)
				AND  	(AppointmentDateTime > @fromDate)
				AND 	AdmissionDateTime is not null

			If(@hosp > 0)
			   BEGIN 
				INSERT INTO SEVERITY_FLAG
				(PatientStatId,
				 PatientId,
				 DiseaseManagementId)
					VALUES(9, @pat, 2)
			   END

			--No Diabetes-specific Labs Last year
			    SELECT @labs = count(PATIENTID)
				FROM PATIENT_FLAG
				WHERE PATIENTID NOT IN
						(SELECT			PatientId
						 FROM			DM_DIABETES_LAB_RESULTS)
				AND		FLAGID = 2

			If(@labs = 0)
			   BEGIN 
				INSERT INTO SEVERITY_FLAG
				(PatientStatId,
				 PatientId,
				 DiseaseManagementId)
					VALUES(17, @pat, 2)
			   END

			--No Diabetes-specific Encounters Last year
			    SELECT @enc = count(PATIENTID)
				FROM PATIENT_FLAG
				WHERE PATIENTID NOT IN
						(SELECT			PatientId
						 FROM			DM_DIABETES_ENCOUNTERS)
				AND		FLAGID = 2

			If(@enc = 0)
			   BEGIN 
				INSERT INTO SEVERITY_FLAG
				(PatientStatId,
				 PatientId,
				 DiseaseManagementId)
					VALUES(18, @pat, 2)
			   END

		FETCH NEXT FROM curFlag INTO @pat
		COMMIT
	END

END
CLOSE curFlag
DEALLOCATE curFlag

EXEC dbo.upActivityLog 'End Severity Flags Diabetes',0,@day;

