
CREATE PROCEDURE [dbo].[procODS_PATIENT_ENCOUNTER_CleanDuplicate20120418]

AS

DECLARE @pat bigint
DECLARE @pa numeric(14,3)
DECLARE @good bigint
DECLARE @bad bigint
DECLARE @ref bigint
DECLARE @cnt int
DECLARE @patkey numeric(13,3)

--%%%%%%%%%%%%
DECLARE curZ CURSOR FAST_FORWARD FOR
SELECT CAST(DemandKey AS numeric(13,3))
FROM    ON_DEMAND
WHERE OnDemandTypeId = 6

OPEN curZ
EXEC dbo.upActivityLog 'Fetch Clean Up',0,0;
FETCH NEXT FROM curZ INTO @patkey
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
				--!!!
				SELECT @pat = PatientId
				FROM PATIENT
				WHERE PatientKey = @patkey
				
				DECLARE curY CURSOR FAST_FORWARD FOR
				SELECT COUNT(PatientEncounterId),
					PatientAppointmentKey 
				FROM PATIENT_ENCOUNTER
				WHERE PatientId = @pat
				AND PatientAppointmentKey IS NOT NULL
				AND PatientAppointmentKey > 0
				GROUP BY PatientAppointmentKey

				OPEN curY
				--EXEC dbo.upActivityLog 'Fetch Clean Up2',0,@pat;
				FETCH NEXT FROM curY INTO @cnt, @pa
				if(@@FETCH_STATUS = 0)
				BEGIN
					WHILE(@@FETCH_STATUS = 0)
					BEGIN
					BEGIN TRANSACTION
						IF(@cnt > 1)
						BEGIN
							--SELECT @pa = PatientAppointmentKey FROM
							--PATIENT_ENCOUNTER
							--WHERE PatientId = @pat
							SET @good = 0
							SET @bad = 0

							SELECT @good = PatientEncounterId
							FROM PATIENT_ENCOUNTER
							WHERE PatientAppointmentKey = @pa
							AND EncounterKey > 0

							SELECT @bad = PatientEncounterId
							FROM PATIENT_ENCOUNTER
							WHERE PatientAppointmentKey = @pa
							AND (EncounterKey = 0 OR EncounterKey IS NULL)

							SELECT @ref = ReferralId
							FROM PATIENT_ENCOUNTER
							WHERE PatientAppointmentKey = @pa
							AND (EncounterKey = 0 OR EncounterKey IS NULL)

							IF(@good = 0 AND @bad > 0) --Zero/Null Enc key
							BEGIN
								SELECT @good = PatientEncounterId
								FROM PATIENT_ENCOUNTER
								WHERE PatientAppointmentKey = @pa
								AND EncounterKey = 0
								
								SELECT @bad = PatientEncounterId
								FROM PATIENT_ENCOUNTER
								WHERE PatientAppointmentKey = @pa
								AND EncounterKey IS NULL
							END --if g/b
							
							EXEC dbo.upActivityLog 'Clean Up',0,@pat;
							PRINT 'Patkey'
							PRINT @patkey
							PRINT 'Pat'
							PRINT @pat
							PRINT 'PA'
							PRINT @pa
							PRINT 'Count'
							PRINT @cnt
							PRINT 'Good'
							PRINT @good
							PRINT 'Bad'
							PRINT @bad
							PRINT 'Ref'
							PRINT @ref
							PRINT ''
							
							IF(@good > 0)
							BEGIN
								UPDATE PATIENT_ENCOUNTER
								SET ReferralId = @ref
								WHERE PatientEncounterId = @good

								DELETE FROM PATIENT_PROCEDURE
								WHERE PatientEncounterId = @bad

								UPDATE PATIENT_ORDER
								SET PatientEncounterId = @good
								WHERE PatientEncounterId = @bad

								DELETE FROM ENCOUNTER_DIAGNOSIS
								WHERE PatientEncounterId = @bad

								DELETE FROM PATIENT_ENCOUNTER_DETAIL_CODE
								WHERE PatientEncounterId = @bad

								UPDATE APPOINTMENT_AUDIT_TRAIL
								SET PatientEncounterId = @good
								WHERE PatientEncounterId = @bad

								IF (@bad > 0)
								BEGIN
								DELETE FROM PATIENT_ENCOUNTER
								WHERE PatientEncounterId = @bad
								END
							END --@good > 0
							
							SET @cnt = 0
							
							--@@@
						END --IF>1
					FETCH NEXT FROM curY INTO @cnt, @pa
					COMMIT
					END --while
				END --if
				CLOSE curY
				DEALLOCATE curY
				--****
				--SELECT @cnt = COUNT(PatientEncounterId) 
				--FROM PATIENT_ENCOUNTER
				--WHERE PatientId = @pat
				
	FETCH NEXT FROM curZ INTO @patkey
	COMMIT
	END --while patkey
END --fetch patkey status
CLOSE curZ
DEALLOCATE curZ
--&&&&&&&&&&&&&











