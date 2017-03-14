
CREATE PROCEDURE [dbo].[upODS_PatientSummary]
AS
	
	DECLARE @exists int

	DECLARE @pat bigint
	DECLARE @hosp1 int
	DECLARE @hosp2 int
	DECLARE @out3 int
	DECLARE @out4 int
	DECLARE @er5 int
	DECLARE @er6 int
	DECLARE @disp7 int

	DECLARE @patX bigint
	Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Patient Summary',0,@day;


DECLARE curSumm CURSOR FAST_FORWARD FOR
SELECT
	PatientId,
	Hosp1,
	Hosp2,
	Out3,
	Out4,
	ER5,
	ER6,
	Disp7
FROM
	vwODS_Patient_Activity_SelectStats
	
OPEN curSumm

EXEC dbo.upActivityLog 'Fetch Patient Summ',0
FETCH NEXT FROM curSumm INTO @pat,@hosp1,@hosp2,@out3,@out4,@er5,@er6,@disp7

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		BEGIN TRANSACTION
		--PRINT @pat
		--ADD/UPDATE summary data
			--Hospital Visits - Total (1)
			Select 	@patX = PatientId
				FROM PATIENT_SUMMARY
				WHERE PatientId = @pat
				AND SourceSystemId = 2
				AND PatientStatId = 1;
				
				SET @exists = @@RowCount
				If @exists = 0 
					BEGIN	
						INSERT INTO PATIENT_SUMMARY
						(
						PatientId,
						StatValue,
						SourceSystemId,
						PatientStatId,
						MinDate,
						MaxDate
						)
						VALUES
						(@pat,@hosp1,2,1,DATEADD(m,-24,getdate()),getdate());
					END
				else
					BEGIN
						UPDATE PATIENT_SUMMARY
						SET
						StatValue = @hosp1,
						MinDate = DATEADD(m,-24,getdate()),
						MaxDate = getdate(),
						UpdatedDate = getdate()
						WHERE PatientId = @pat
						AND SourceSystemId = 2
						AND PatientStatId = 1;
					END

			--Hospital Visits - Asthma (2)
			Select 	@patX = PatientId
				FROM PATIENT_SUMMARY
				WHERE PatientId = @pat
				AND SourceSystemId = 2
				AND PatientStatId = 2;
				
				SET @exists = @@RowCount
				If @exists = 0 
					BEGIN	
						INSERT INTO PATIENT_SUMMARY
						(
						PatientId,
						StatValue,
						SourceSystemId,
						PatientStatId,
						MinDate,
						MaxDate
						)
						VALUES
						(@pat,@hosp2,2,2,DATEADD(m,-24,getdate()),getdate());
					END
				else
					BEGIN
						UPDATE PATIENT_SUMMARY
						SET
						StatValue = @hosp2,
						MinDate = DATEADD(m,-24,getdate()),
						MaxDate = getdate(),
						UpdatedDate = getdate()
						WHERE PatientId = @pat
						AND SourceSystemId = 2
						AND PatientStatId = 2;
					END

			--Outpatient Visits - Total (3)
			Select 	@patX = PatientId
				FROM PATIENT_SUMMARY
				WHERE PatientId = @pat
				AND SourceSystemId = 2
				AND PatientStatId = 3;
				
				SET @exists = @@RowCount
				If @exists = 0 
					BEGIN	
						INSERT INTO PATIENT_SUMMARY
						(
						PatientId,
						StatValue,
						SourceSystemId,
						PatientStatId,
						MinDate,
						MaxDate
						)
						VALUES
						(@pat,@out3,2,3,DATEADD(m,-24,getdate()),getdate());
					END
				else
					BEGIN
						UPDATE PATIENT_SUMMARY
						SET
						StatValue = @out3,
						MinDate = DATEADD(m,-24,getdate()),
						MaxDate = getdate(),
						UpdatedDate = getdate()
						WHERE PatientId = @pat
						AND SourceSystemId = 2
						AND PatientStatId = 3;
					END

			--Outpatient Visits - Asthma (4)
			Select 	@patX = PatientId
				FROM PATIENT_SUMMARY
				WHERE PatientId = @pat
				AND SourceSystemId = 2
				AND PatientStatId = 4;
				
				SET @exists = @@RowCount
				If @exists = 0 
					BEGIN	
						INSERT INTO PATIENT_SUMMARY
						(
						PatientId,
						StatValue,
						SourceSystemId,
						PatientStatId,
						MinDate,
						MaxDate
						)
						VALUES
						(@pat,@out4,2,4,DATEADD(m,-24,getdate()),getdate());
					END
				else
					BEGIN
						UPDATE PATIENT_SUMMARY
						SET
						StatValue = @out4,
						MinDate = DATEADD(m,-24,getdate()),
						MaxDate = getdate(),
						UpdatedDate = getdate()
						WHERE PatientId = @pat
						AND SourceSystemId = 2
						AND PatientStatId = 4;
					END

			--ER Visits - Total (5)
			Select 	@patX = PatientId
				FROM PATIENT_SUMMARY
				WHERE PatientId = @pat
				AND SourceSystemId = 2
				AND PatientStatId = 5;
				
				SET @exists = @@RowCount
				If @exists = 0 
					BEGIN	
						INSERT INTO PATIENT_SUMMARY
						(
						PatientId,
						StatValue,
						SourceSystemId,
						PatientStatId,
						MinDate,
						MaxDate
						)
						VALUES
						(@pat,@er5,2,5,DATEADD(m,-24,getdate()),getdate());
					END
				else
					BEGIN
						UPDATE PATIENT_SUMMARY
						SET
						StatValue = @er5,
						MinDate = DATEADD(m,-24,getdate()),
						MaxDate = getdate(),
						UpdatedDate = getdate()
						WHERE PatientId = @pat
						AND SourceSystemId = 2
						AND PatientStatId = 5;
					END

			--ER Visits - Asthma (6)
			Select 	@patX = PatientId
				FROM PATIENT_SUMMARY
				WHERE PatientId = @pat
				AND SourceSystemId = 2
				AND PatientStatId = 6;
				
				SET @exists = @@RowCount
				If @exists = 0 
					BEGIN	
						INSERT INTO PATIENT_SUMMARY
						(
						PatientId,
						StatValue,
						SourceSystemId,
						PatientStatId,
						MinDate,
						MaxDate
						)
						VALUES
						(@pat,@er6,2,6,DATEADD(m,-24,getdate()),getdate());
					END
				else
					BEGIN
						UPDATE PATIENT_SUMMARY
						SET
						StatValue = @er6,
						MinDate = DATEADD(m,-24,getdate()),
						MaxDate = getdate(),
						UpdatedDate = getdate()
						WHERE PatientId = @pat
						AND SourceSystemId = 2
						AND PatientStatId = 6;
					END

				--Dispensing Events - Total (7)
			Select 	@patX = PatientId
				FROM PATIENT_SUMMARY
				WHERE PatientId = @pat
				AND SourceSystemId = 2
				AND PatientStatId = 7;
				
				SET @exists = @@RowCount
				If @exists = 0 
					BEGIN	
						INSERT INTO PATIENT_SUMMARY
						(
						PatientId,
						StatValue,
						SourceSystemId,
						PatientStatId,
						MinDate,
						MaxDate
						)
						VALUES
						(@pat,@disp7,2,7,DATEADD(m,-24,getdate()),getdate());
					END
				else
					BEGIN
						UPDATE PATIENT_SUMMARY
						SET
						StatValue = @disp7,
						MinDate = DATEADD(m,-24,getdate()),
						MaxDate = getdate(),
						UpdatedDate = getdate()
						WHERE PatientId = @pat
						AND SourceSystemId = 2
						AND PatientStatId = 7;
					END
	
		FETCH NEXT FROM curSumm INTO @pat,@hosp1,@hosp2,@out3,@out4,@er5,@er6,@disp7
		COMMIT
	END

END
CLOSE curSumm
DEALLOCATE curSumm

EXEC dbo.upActivityLog 'End Patient Summary',0,@day;



/*
			--Hospital Visits - Total (1)
			SELECT @hosp1 = HospitalVisits
			FROM vwODS_PATIENT_ENCOUNTER_SelectHospitalVisits
			WHERE PatientId = @pat;

			SET @exists = @@RowCount
			If @exists = 0
				BEGIN
					SET @hosp1 = 0
				END

			--Hospital Visits - Asthma (2)
			SELECT @hosp2 = HospitalVisits
			FROM vwODS_PATIENT_ENCOUNTER_SelectHospitalVisits_Asthma
			WHERE PatientId = @pat;

			SET @exists = @@RowCount
			If @exists = 0
				BEGIN
					SET @hosp2 = 0
				END

			--Outpatient Visits - Total (3)
			SELECT @out3 = OutpatientVisits
			FROM vwODS_PATIENT_ENCOUNTER_SelectOutpatientVisits
			WHERE PatientId = @pat;

			SET @exists = @@RowCount
			If @exists = 0
				BEGIN
					SET @out3 = 0
				END

			--Outpatient Visits - Asthma (4)
			SELECT @out4 = OutpatientVisits
			FROM vwODS_PATIENT_ENCOUNTER_SelectOutpatientVisits_Asthma
			WHERE PatientId = @pat;

			SET @exists = @@RowCount
			If @exists = 0
				BEGIN
					SET @out4 = 0
				END

			--ER Visits - Total (5)
			SELECT @er5 = ERVisits
			FROM vwODS_PATIENT_ENCOUNTER_SelectERVisits
			WHERE PatientId = @pat;

			SET @exists = @@RowCount
			If @exists = 0
				BEGIN
					SET @er5 = 0
				END

			--ER Visits - Asthma (6)
			SELECT @er6 = ERVisits
			FROM vwODS_PATIENT_ENCOUNTER_SelectERVisits_Asthma
			WHERE PatientId = @pat;

			SET @exists = @@RowCount
			If @exists = 0
				BEGIN
					SET @er6 = 0
				END

			--Dispensing Events - Total (7)
			SELECT @disp7 = DispensingEvents
			FROM vwODS_PRESCRIPTION_SelectDispensingEvents
			WHERE PatientId = @pat;

			SET @exists = @@RowCount
			If @exists = 0
				BEGIN
					SET @disp7 = 0
				END
			*/

