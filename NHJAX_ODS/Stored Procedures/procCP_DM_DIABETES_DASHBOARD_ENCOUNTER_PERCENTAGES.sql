CREATE PROCEDURE [dbo].[procCP_DM_DIABETES_DASHBOARD_ENCOUNTER_PERCENTAGES]
(
@enctype int
)
AS

BEGIN
	SET NOCOUNT ON;

DECLARE @patcnt as int
DECLARE @comp as numeric
declare @need as numeric
DECLARE @pro as bigint

DECLARE @patcntX as int
DECLARE @comppntX as numeric
declare @needpntX as numeric

declare @comppnt numeric
declare @needpnt numeric

DECLARE @exists as int
DECLARE @cnt int
DECLARE @totl int
DECLARE @irow int
DECLARE @sirow nvarchar(100)

Set @exists = 0
set @irow = 0

BEGIN

--EXEC DBO.upACTIVITYLOG 'Begin Foot Exam Dashboard Encounters', 0

DECLARE curPRO CURSOR FAST_FORWARD FOR
		SELECT DISTINCT P.CurrentPCMId
		FROM        PATIENT P INNER JOIN
					PATIENT_FLAG PF
					 ON P.PatientId = PF.PatientId
		WHERE		p.CURRENTPCMID IS NOT NULL
		
		order by P.CurrentPCMId
OPEN curPRO

--EXEC DBO.upACTIVITYLOG 'Fetch Foot Exam Dashboard Encounters', 0

FETCH NEXT FROM curPRO INTO @pro		

IF (@@fetch_status = 0)
BEGIN						
WHILE (@@fetch_status = 0)
		BEGIN 
					 -- GET PATIENT COUNT FOR PROVIDER
						SELECT	DISTINCT	@patcnt = count(p.patientid)
						FROM        PATIENT_FLAG PF
									inner join patient P
									on P.patientid = PF.Patientid

						where		p.currentpcmid = @pro --MAKE @PRO
						AND			PF.FLAGID = 2
						AND		(P.PATIENTID NOT IN (SELECT PATIENTID FROM CLINICAL_PORTAL.DBO.CUSTOM_PATIENT_TRACKING WHERE DMID = 2))
				--GET PATIENTS WHO HAVE HAD FOOT EXAM
						SELECT DISTINCT @comp = COUNT(Pf.PATIENTID)
						FROM PATIENT_FLAG PF
						INNER JOIN PATIENT P
						ON PF.PATIENTID = P.PATIENTID
							
						WHERE	Pf.FLAGID = 2
						AND		P.CURRENTPCMID = @pro --MAKE @PRO
												
						AND		PF.PATIENTID  IN (SELECT DISTINCT PATIENTID
												   FROM DM_DIABETES_ENCOUNTERS
												   WHERE ENCOUNTERTYPEID = @enctype)
						AND		(P.PATIENTID NOT IN (SELECT PATIENTID FROM CLINICAL_PORTAL.DBO.CUSTOM_PATIENT_TRACKING WHERE DMID = 2))
				 -- GET PATIENTS NEEDING FOOT EXAM
						SELECT DISTINCT  @need = COUNT(PF.PATIENTID)
						FROM PATIENT_FLAG PF
						INNER JOIN PATIENT P
						ON PF.PATIENTID = P.PATIENTID
							
						WHERE	PF.FLAGID = 2
						AND		P.CURRENTPCMID = @pro --MAKE @PRO
						AND		PF.PATIENTID NOT IN (SELECT DISTINCT PATIENTID
												   FROM DM_DIABETES_ENCOUNTERS
												   WHERE ENCOUNTERTYPEID = @enctype)
						AND		(P.PATIENTID NOT IN (SELECT PATIENTID FROM CLINICAL_PORTAL.DBO.CUSTOM_PATIENT_TRACKING WHERE DMID = 2))
				IF (@patcnt > 0)
					BEGIN						
						set @comppnt = (@comp/@patcnt) * 100							
						set @needpnt = (@need/@patcnt) * 100
					  INSERT INTO DM_DIABETES_DASHBOARD_ENCOUNTERS_PERCENTAGES
							(
							ProviderId
							,EncounterTypeId
							,PercentCompleted
							,PercentNeeded
							,PatientCount
							)
							values
							(
							@pro
							,@enctype
							,@comppnt
							,@needpnt
							,@patcnt
							);	
				
							SET @irow = @irow + 1
				END
				FETCH NEXT FROM curPRO INTO @pro			
		END
END
CLOSE curPRO
DEALLOCATE curPRO
SET @sirow = 'Total rows inserted: ' + CAST(@irow as nvarchar(5))
EXEC DBO.upACTIVITYLOG @sirow, 6
END
END

--Print 'ProviderId: ' + cast(@pro as nvarchar(10))
							--Print 'Patient Count: ' + cast(@patcnt as nvarchar(10))
