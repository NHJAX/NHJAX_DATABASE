


CREATE PROCEDURE [dbo].[upODS_SeverityFlags_BreastCancer_20090406]

AS
	DECLARE @tempDate datetime
	DECLARE @fromDate datetime
	DECLARE @loop int
	DECLARE @exists int

	DECLARE @pat bigint
	DECLARE @disp int
	DECLARE @er int
    DECLARE @hosp int
		
SET @tempDate = dbo.StartofDay(DATEADD(d,-30,getdate()));
SET @fromDate = dbo.StartOfDay(@tempDate);

--PRINT @fromDate

EXEC dbo.upActivityLog 'Begin Severity Flags Mammography',0;


DELETE FROM SEVERITY_FLAG
WHERE DiseaseManagementId = 4;

DECLARE curFlag CURSOR FAST_FORWARD FOR
	SELECT DISTINCT 
		PatientId
	FROM PATIENT_FLAG
	WHERE FlagId = 7

OPEN curFlag

EXEC dbo.upActivityLog 'Fetch Severity Flags Mammography',0
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
			AND DiseaseManagementId = 4

			If(@disp = 0) 
			  BEGIN
				INSERT INTO SEVERITY_FLAG
				(PatientStatId,
				 PatientId,
				 DiseaseManagementId)	 
					Values (16, @pat, 4)					
			  End

			--ER 30 Days
			SELECT @er = COUNT
				(PatientEncounterId)
			FROM PATIENT_ENCOUNTER
			WHERE (PatientId = @pat)
			AND (AppointmentDateTime > @tempDate)
			AND HospitalLocationId = 174	

			If(@er > 0)
			  BEGIN 
				INSERT INTO	SEVERITY_FLAG
				(PatientStatId,
				 PatientId,
				 DiseaseManagementId)		
					Values(14, @pat, 4)
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
					VALUES(10, @pat, 4)
			   END

		FETCH NEXT FROM curFlag INTO @pat
		COMMIT
	END

END
CLOSE curFlag
DEALLOCATE curFlag

EXEC dbo.upActivityLog 'End Severity Flags Mammography',0;

