CREATE PROCEDURE [dbo].[procCP_DM_DIABETES_DASHBOARD_LAB_RESULT_AVERAGES]
(
@labtype int
)
AS

BEGIN
SET NOCOUNT ON;

DECLARE @avg as decimal(18,2)
DECLARE @pro as bigint

DECLARE @exists as int
DECLARE @res as nchar(5)
DECLARE @cnt decimal(4,0)
DECLARE @totl decimal(8,2)
DECLARE @irow int
DECLARE @sirow nvarchar(100)

Set @exists = 0
set @irow = 0

BEGIN
	
DECLARE curPRO CURSOR FAST_FORWARD FOR
SELECT DISTINCT PCM.[ProviderId]      
FROM	[NHJAX_ODS].[dbo].[PRIMARY_CARE_MANAGER]	PCM INNER JOIN
		[NHJAX_ODS].dbo.PATIENT_FLAG PF  ON PCM.PatientID = PF.PatientId INNER JOIN
		NHJAX_ODS.dbo.PATIENT P ON P.PatientId = PF.PatientId
WHERE	PCM.PCMId NOT IN (SELECT PCMExceptionId FROM NHJAX_ODS.dbo.PCM_EXCEPTION)
AND		P.CurrentPCMId IS NOT NULL
ORDER BY PCM.ProviderId
OPEN curPRO
FETCH NEXT FROM curPRO INTO @pro
IF (@@fetch_status = 0)
BEGIN						
WHILE (@@fetch_status = 0)
	BEGIN	
		DECLARE curLAB CURSOR FAST_FORWARD FOR
			SELECT	DISTINCT DLR.Result											
			FROM			PATIENT_FLAG PF
							INNER JOIN
							DM_DIABETES_LAB_RESULTS DLR
							ON PF.PatientId = DLR.PatientId
							INNER JOIN
							PATIENT P 
							ON PF.PatientId = P.PatientId

			where			PF.flagid = 2
			AND				DLR.LabResultTypeId = @labtype
			AND				p.currentpcmid = @pro
			AND				isnumeric(DLR.Result) = 1
			AND		(P.PATIENTID NOT IN (SELECT PATIENTID FROM CLINICAL_PORTAL.DBO.CUSTOM_PATIENT_TRACKING WHERE DMID = 2))
						set @cnt = 0
						set @avg = 0
						set @totl = 0

			Open curLAB

			FETCH NEXT FROM curLAB into @res
			IF (@@FETCH_STATUS = 0)
			BEGIN
				WHILE (@@FETCH_STATUS = 0)
					BEGIN
						set @avg = @avg + @res
						set @cnt = @cnt + 1
												
						FETCH NEXT FROM curLAB into @res						
					END
			END

			BEGIN TRANSACTION
			IF (@cnt > 0)
				BEGIN
					set @totl = @avg/@cnt
--print @res
--print @avg
--print @cnt
--print @totl
--print ' ' 
					
					INSERT INTO DM_DIABETES_DASHBOARD_LAB_RESULTS_AVERAGES
						(
						 AvgResult
						,ProviderId
						,LabResultTypeId
						,PatientCount
						)
						values
						(
						@totl
						,@pro
						,@labtype
						,@cnt
						);	
				END
			COMMIT	
			
			CLOSE curLAB
			DEALLOCATE curLAB

SET @irow = @irow + 1

FETCH NEXT FROM curPRO INTO @pro
	END
END
CLOSE curPRO
DEALLOCATE curPRO

SET @sirow = 'Total rows inserted: ' + CAST(@irow as nvarchar(5))
EXEC DBO.upACTIVITYLOG @sirow, 6

END
END

