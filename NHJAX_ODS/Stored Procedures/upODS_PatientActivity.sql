





CREATE PROCEDURE [dbo].[upODS_PatientActivity]
AS

	DECLARE @exists int

	DECLARE @pat bigint
	DECLARE @patX bigint
	Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0
	
EXEC dbo.upActivityLog 'Begin Patient Activity',0,@day;

DECLARE curAct CURSOR FAST_FORWARD FOR
SELECT     
	PAT.PatientId
FROM         
	PATIENT AS PAT 
	INNER JOIN vwSTG_STG_PATIENT_ACTIVITY AS PACT 
	ON PAT.PatientKey = PACT.Patient_Ien

OPEN curAct

EXEC dbo.upActivityLog 'Fetch Patient Activity',0
FETCH NEXT FROM curAct INTO @pat

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		BEGIN TRANSACTION

			Select 	@patX = PatientId
				FROM PATIENT_ACTIVITY
				WHERE PatientId = @pat;
				
				SET @exists = @@RowCount
				If @exists = 0 
					BEGIN	
						INSERT INTO PATIENT_ACTIVITY
						(
						PatientId
						)
						VALUES
						(@pat);
					END
				else
					BEGIN
						UPDATE PATIENT_ACTIVITY
						SET UpdatedDate = getdate()
						WHERE PatientId = @pat;
					END
	
		FETCH NEXT FROM curAct INTO @pat
		COMMIT
	END

END
CLOSE curAct
DEALLOCATE curAct

EXEC dbo.upActivityLog 'Delete Patient Activity',0;

DELETE FROM PATIENT_ACTIVITY
WHERE UpdatedDate < DATEADD(d,-1,getdate())

EXEC dbo.upActivityLog 'End Patient Activity',0,@day;



