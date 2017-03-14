



CREATE PROCEDURE [dbo].[upODS_PHPatientSummary]
AS
	
	DECLARE @exists int

	DECLARE @pat bigint
	DECLARE @hosp int
	DECLARE @out int
	DECLARE @er int
	DECLARE @disp int
	DECLARE @src bigint
	DECLARE @min datetime
	DECLARE @max datetime
	DECLARE @a1c nvarchar(4)
	DECLARE	@ldl nvarchar(4)
	DECLARE @ret datetime
	
	DECLARE @patX bigint
	DECLARE @hospX int
	DECLARE @outX int
	DECLARE @erX int
	DECLARE @dispX int
	DECLARE @srcX bigint
	DECLARE @minX datetime
	DECLARE @maxX datetime
	Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0
	
EXEC dbo.upActivityLog 'Begin PH Asthma Patient Summary',0,@day;


DECLARE curSumm CURSOR FAST_FORWARD FOR
SELECT     
	PAT.PatientId, 
	PHA.Hospitalization,	
	PHA.Outpatient, 
	PHA.ERVisits, 
	PHA.Dispensing, 
	6 AS SourceSystemId, 
	vwSTG_MIN_DATE_ASTHMA.MinDate, 
	vwSTG_MAX_DATE_ASTHMA.MaxDate
FROM
	PATIENT AS PAT  
	INNER JOIN vwSTG_POP_HEALTH_ASTHMA AS PHA 
	ON PAT.PatientIdentifier = PHA.EDIPN
	CROSS JOIN vwSTG_MAX_DATE_ASTHMA 
	CROSS JOIN vwSTG_MIN_DATE_ASTHMA

OPEN curSumm

EXEC dbo.upActivityLog 'Fetch PH Asthma Patient Summ',0
FETCH NEXT FROM curSumm INTO @pat,@hosp,@out,@er,@disp,@src,@min,@max

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		BEGIN TRANSACTION
			--Hospital Visits - Asthma (2)
			Select 	@patX = PatientId
				FROM PATIENT_SUMMARY
				WHERE PatientId = @pat
				AND SourceSystemId = @src
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
						(@pat,@hosp,@src,2,@min,@max);
					END
				else
					BEGIN
						UPDATE PATIENT_SUMMARY
						SET
						StatValue = @hosp,
						MinDate = @min,
						MaxDate = @max,
						UpdatedDate = getdate()
						WHERE PatientId = @pat
						AND SourceSystemId = @src
						AND PatientStatId = 2;
					END

				--Outpatient Visits - Asthma (4)
			Select 	@patX = PatientId
				FROM PATIENT_SUMMARY
				WHERE PatientId = @pat
				AND SourceSystemId = @src
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
						(@pat,@out,@src,4,@min,@max);
					END
				else
					BEGIN
						UPDATE PATIENT_SUMMARY
						SET
						StatValue = @out,
						MinDate = @min,
						MaxDate = @max,
						UpdatedDate = getdate()
						WHERE PatientId = @pat
						AND SourceSystemId = @src
						AND PatientStatId = 4;
					END

				--ER Visits - Asthma (6)
			Select 	@patX = PatientId
				FROM PATIENT_SUMMARY
				WHERE PatientId = @pat
				AND SourceSystemId = @src
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
						(@pat,@er,@src,6,@min,@max);
					END
				else
					BEGIN
						UPDATE PATIENT_SUMMARY
						SET
						StatValue = @er,
						MinDate = @min,
						MaxDate = @max,
						UpdatedDate = getdate()
						WHERE PatientId = @pat
						AND SourceSystemId = @src
						AND PatientStatId = 6;
					END

				--Outpatient Visits - Asthma (8)
			Select 	@patX = PatientId
				FROM PATIENT_SUMMARY
				WHERE PatientId = @pat
				AND SourceSystemId = @src
				AND PatientStatId = 8;
				
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
						(@pat,@disp,@src,8,@min,@max);
					END
				else
					BEGIN
						UPDATE PATIENT_SUMMARY
						SET
						StatValue = @disp,
						MinDate = @min,
						MaxDate = @max,
						UpdatedDate = getdate()
						WHERE PatientId = @pat
						AND SourceSystemId = @src
						AND PatientStatId = 8;
					END
	
		FETCH NEXT FROM curSumm INTO @pat,@hosp,@out,@er,@disp,@src,@min,@max
		COMMIT
	END

END
CLOSE curSumm
DEALLOCATE curSumm

EXEC dbo.upActivityLog 'End PH Asthma Patient Summary',0;

--    *****BEGIN DIABETES SUMMARY******--------------------------------------

EXEC dbo.upActivityLog 'Begin PH Diabetes Patient Summary',0;


DECLARE curDiab CURSOR FAST_FORWARD FOR
SELECT     
	PAT.PatientId
	,isnull(DIA.Hospitalizations,0) as Hospitalizations
	,isnull(DIA.OutpatientVisits, 0) as OutPatientVisits
	,isnull(DIA.ERVisits,0) as ErVisits
	,isnull(DIA.RxCount, 0) As RxCount
	,6 AS SourceSystemId
	,isnull(DIA.LDLCertDate, '1/1/1900') as LastDate
	,DIA.A1CResult
	,left(DIA.LDL,4)
	,DIA.RetinalDate
	
FROM
	PATIENT AS PAT  
	INNER JOIN vwSTG_POP_HEALTH_DIABETES AS DIA 
	ON PAT.PatientIdentifier = DIA.EDIPN 
	

OPEN curDiab

EXEC dbo.upActivityLog 'Fetch PH Diabetes Patient Summary',0
FETCH NEXT FROM curDiab INTO @pat,@hosp,@out,@er,@disp,@src,@max,@a1c,@ldl,@ret

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		BEGIN TRANSACTION
			--Hospital Visits - Diabetes (9)
			Select 	@patX = PatientId
				FROM PATIENT_SUMMARY
				WHERE PatientId = @pat
				AND SourceSystemId = @src
				AND PatientStatId = 9;
				
				SET @exists = @@RowCount
				If @exists = 0 
					BEGIN	
						INSERT INTO PATIENT_SUMMARY
						(
						PatientId,
						StatValue,
						SourceSystemId,
						PatientStatId,
						MaxDate
						)
						VALUES
						(@pat,@hosp,@src,9,@max);
					END
				else
					BEGIN
						UPDATE PATIENT_SUMMARY
						SET
						StatValue = @hosp,
						MaxDate = @max,
						UpdatedDate = getdate()
						WHERE PatientId = @pat
						AND SourceSystemId = @src
						AND PatientStatId = 9;
					END

				--Outpatient Visits - Diabetes (11)
			Select 	@patX = PatientId
				FROM PATIENT_SUMMARY
				WHERE PatientId = @pat
				AND SourceSystemId = @src
				AND PatientStatId = 11;
				
				SET @exists = @@RowCount
				If @exists = 0 
					BEGIN	
						INSERT INTO PATIENT_SUMMARY
						(
						PatientId,
						StatValue,
						SourceSystemId,
						PatientStatId,
						MaxDate
						)
						VALUES
						(@pat,@out,@src,11,@max);
					END
				else
					BEGIN
						UPDATE PATIENT_SUMMARY
						SET
						StatValue = @out,
						MaxDate = @max,
						UpdatedDate = getdate()
						WHERE PatientId = @pat
						AND SourceSystemId = @src
						AND PatientStatId = 11;
					END

				--ER Visits - Diabetes (13)
			Select 	@patX = PatientId
				FROM PATIENT_SUMMARY
				WHERE PatientId = @pat
				AND SourceSystemId = @src
				AND PatientStatId = 13;
				
				SET @exists = @@RowCount
				If @exists = 0 
					BEGIN	
						INSERT INTO PATIENT_SUMMARY
						(
						PatientId,
						StatValue,
						SourceSystemId,
						PatientStatId,
						MaxDate
						)
						VALUES
						(@pat,@er,@src,13,@max);
					END
				else
					BEGIN
						UPDATE PATIENT_SUMMARY
						SET
						StatValue = @er,
						MaxDate = @max,
						UpdatedDate = getdate()
						WHERE PatientId = @pat
						AND SourceSystemId = @src
						AND PatientStatId = 13;
					END

				--Dispensing Events - Diabetes (15)
			Select 	@patX = PatientId
				FROM PATIENT_SUMMARY
				WHERE PatientId = @pat
				AND SourceSystemId = @src
				AND PatientStatId = 15;
				
				SET @exists = @@RowCount
				If @exists = 0 
					BEGIN	
						INSERT INTO PATIENT_SUMMARY
						(
						PatientId,
						StatValue,
						SourceSystemId,
						PatientStatId,
						MaxDate
						)
						VALUES
						(@pat,@disp,@src,15,@max);
					END
				else
					BEGIN
						UPDATE PATIENT_SUMMARY
						SET
						StatValue = @disp,
						MaxDate = @max,
						UpdatedDate = getdate()
						WHERE PatientId = @pat
						AND SourceSystemId = @src
						AND PatientStatId = 15;
					END

				--No Disease-Specific Lab Results - Diabetes (17)

				Select @patX = PatientId
				FROM PATIENT_SUMMARY
				WHERE PatientId = @pat
				AND SourceSystemId = @src
				AND PatientStatId = 17;
				
				SET @exists = @@RowCount
			IF @a1c is null and @ldl is null
				If @exists = 0 
					BEGIN	
						INSERT INTO PATIENT_SUMMARY
						(
						PatientId,
						StatValue,
						SourceSystemId,
						PatientStatId
						)
						VALUES
						(@pat,0,@src,17);
					END
				else
					BEGIN
						UPDATE PATIENT_SUMMARY
						SET
						StatValue = 0,
						UpdatedDate = getdate()
						WHERE PatientId = @pat
						AND SourceSystemId = @src
						AND PatientStatId = 17;
					END
	     ELSE If @exists > 0 
			BEGIN
				DELETE FROM PATIENT_SUMMARY 
				WHERE PatientId = @pat
				and PatientStatId = 17
			END

				--No Disease-Specific Encounters - Diabetes (18)

		
			Select  @patX = PatientId
				FROM PATIENT_SUMMARY
				WHERE PatientId = @pat
				AND SourceSystemId = @src
				AND PatientStatId = 18;
				
				SET @exists = @@RowCount
			IF @ret is null
				If @exists = 0 
					BEGIN	
						INSERT INTO PATIENT_SUMMARY
						(
						PatientId,
						StatValue,
						SourceSystemId,
						PatientStatId						
						)
						VALUES
						(@pat,0,@src,18);
					END
				else
					BEGIN
						UPDATE PATIENT_SUMMARY
						SET
						StatValue = 0,
						UpdatedDate = getdate()
						WHERE PatientId = @pat
						AND SourceSystemId = @src
						AND PatientStatId = 18;
					END
	     ELSE If @exists > 0 
			BEGIN
				DELETE FROM PATIENT_SUMMARY 
				WHERE PatientId = @pat
				and PatientStatId = 18
			END
		
		FETCH NEXT FROM curDiab INTO @pat,@hosp,@out,@er,@disp,@src,@max,@a1c,@ldl,@ret
		COMMIT
	END

END
CLOSE curDiab
DEALLOCATE curDiab

EXEC dbo.upActivityLog 'End PH Diabetes Patient Summary',0,@day;




