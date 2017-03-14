


CREATE PROCEDURE [dbo].[upODS_SeverityFlags_Asthma]

AS
	DECLARE @tempDate datetime
	DECLARE @fromDate datetime
	DECLARE @dispdate datetime
	DECLARE @loop int
	DECLARE @exists int

	DECLARE @pat bigint
	DECLARE @disp int
	DECLARE @er int
    DECLARE @hosp int
		
SET @tempDate = dbo.StartofDay(DATEADD(d,-30,getdate()));
SET @dispDate = dbo.StartofDay(DATEADD(d,-90,getdate()));
SET @fromDate = dbo.StartOfDay(@tempDate);
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

--PRINT @fromDate

EXEC dbo.upActivityLog 'Begin Severity Flags Asthma',0,@day;


DELETE FROM SEVERITY_FLAG
WHERE DiseaseManagementId = 1;

DECLARE curFlag CURSOR FAST_FORWARD FOR
	SELECT DISTINCT 
		PatientId
	FROM PATIENT_FLAG
	WHERE FlagId = 1

OPEN curFlag

EXEC dbo.upActivityLog 'Fetch Severity Flags Asthma',0
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
			AND DiseaseManagementId = 1
			and maxfilldate <=  @dispdate

			If(@disp = 0) 
			  BEGIN
				INSERT INTO SEVERITY_FLAG
				(PatientStatId,
				 PatientId,
				 DiseaseManagementId)	 
					Values (8, @pat, 1)					
			  End

			--ER 30 Days
			SELECT @er = COUNT
				(PatientEncounterId)
			FROM PATIENT_ENCOUNTER
			WHERE (PatientId = @pat)
			AND (AppointmentDateTime > @tempDate)
			AND HospitalLocationId = 174
			and appointmenttypeid = 547	

			If(@er > 0)
			  BEGIN 
				INSERT INTO	SEVERITY_FLAG
				(PatientStatId,
				 PatientId,
				 DiseaseManagementId)		
					Values(6, @pat, 1)
			  END

			--Hospitalized 30 days
			SELECT	@hosp =	count(PatientEncounterId)
			FROM        PATIENT_ENCOUNTER
			WHERE		(PatientId = @pat)
				AND  	(AppointmentDateTime > @tempDate)
				AND 	AdmissionDateTime is not null

			If(@hosp > 0)
			   BEGIN 
				INSERT INTO SEVERITY_FLAG
				(PatientStatId,
				 PatientId,
				 DiseaseManagementId)
					VALUES(2, @pat, 1)
			   END

		FETCH NEXT FROM curFlag INTO @pat
		COMMIT
	END

END
CLOSE curFlag
DEALLOCATE curFlag

EXEC dbo.upActivityLog 'End Severity Flags Asthma',0,@day;