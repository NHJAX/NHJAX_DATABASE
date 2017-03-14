
CREATE PROCEDURE [dbo].[procCP_DM_DIABETES_KEY_LAB_RESULTS] 
		
AS
BEGIN
		SET NOCOUNT ON;
    
DECLARE @pro bigint 
DECLARE @pat bigint
DECLARE @result nchar(50)
DECLARE @id int
DECLARE @date datetime
DECLARE @patX bigint
DECLARE @resultX nchar(50)
DECLARE @proX  nchar(50) 

TRUNCATE TABLE DM_DIABETES_KEY_LAB_RESULTS

BEGIN
DECLARE curpro CURSOR FAST_FORWARD FOR

SELECT  DISTINCT  P.CURRENTPCMID
FROM         PATIENT P
WHERE P.CURRENTPCMID IS NOT NULL
AND P.PATIENTID IN (SELECT PATIENTID FROM PATIENT_FLAG WHERE FLAGID = 2)
ORDER BY P.CURRENTPCMID 


OPEN CURPRO

FETCH NEXT FROM CURPRO INTO @PRO

IF (@@FETCH_STATUS = 0)
BEGIN
	WHILE (@@FETCH_STATUS = 0)
	BEGIN

		DECLARE curLabKey cursor fast_forward for

		SELECT DISTINCT  lR.PATIENTID
						
		FROM vwCP_PATIENT_PATIENT_FLAG P
		left JOIN
		DM_DIABETES_LAB_RESULTS LR
		ON LR.PATIENTID = P.PATIENTID
		
		WHERE p.providerid = @PRO
		AND TRACKED = 1
		AND		(lr.PATIENTID NOT IN (SELECT PATIENTID FROM clinical_portal.dbo.CUSTOM_PATIENT_TRACKING WHERE DMID = 2))
		ORDER BY LR.PATIENTID
				
		OPEN curlabkey

		FETCH NEXT FROM curlabkey INTO @pat --, @id, @result, @date

		IF (@@fetch_status = 0)
		BEGIN
			WHILE @@FETCH_STATUS = 0
				BEGIN
				BEGIN TRANSACTION
				 IF NOT EXISTS(SELECT PATIENTID FROM DM_DIABETES_KEY_lAB_RESULTS
							  WHERE PATIENTID = @pat)
					BEGIN
					INSERT INTO DM_DIABETES_KEY_LAB_RESULTS
							(
							 Providerid
							,Patientid
							)
							VALUES
							(
						     @pro
							,@pat
							);
					 END
					 
					FETCH NEXT FROM CURLABKEY INTO @pat --, @id, @result, @date
				  COMMIT
			END
		END
			
		close curlabkey
		deallocate curlabkey

		FETCH NEXT FROM CURPRO INTO @PRO
 
END
END
close curpro
deallocate curpro
END


DECLARE @pat2 bigint
declare @id2 int
declare @a1c nchar(50)
declare @ldl nchar(50)
declare @gfr nchar(50)
declare @date2 datetime
declare @a1cdate datetime
declare @gfrdate datetime
declare @ldldate datetime

DECLARE curPATLABS CURSOR FAST_FORWARD FOR

			SELECT PATIENTID
			FROM DM_DIABETES_KEY_LAB_RESULTS

	OPEN curPATLABS

	FETCH NEXT FROM curPATLABS INTO @pat2
IF @@FETCH_STATUS = 0
BEGIN
	WHILE @@FETCH_STATUS = 0
		BEGIN
			--BEGIN TRANSACTION

					BEGIN
							
						BEGIN TRANSACTION
							update DM_DIABETES_KEY_LAB_RESULTS
							set A1C = REPLACE(REPLACE(REPLACE(REPLACE(ISNULL(
								(SELECT TOP 1 Result							
									FROM  DM_DIABETES_LAB_RESULTS
									WHERE PATIENTID = @pat2
									AND DATETAKEN > DATEADD(M, -12, GETDATE())
									AND LABRESULTTYPEID = 1
									ORDER BY DATETAKEN DESC), '0'
									),'=',''),'<',''),'>',''),' ','')
								,A1cDate = (SELECT TOP 1 cast(DateTaken as nvarchar(25))							
									FROM  DM_DIABETES_LAB_RESULTS
									WHERE PATIENTID = @pat2
									AND DATETAKEN > DATEADD(M, -12, GETDATE())
									AND LABRESULTTYPEID = 1
									ORDER BY DATETAKEN DESC)
							where patientid = @pat2
						COMMIT
					END
					
					BEGIN
					--Replace blanks 20110223 band-aid patch SK
					UPDATE DM_DIABETES_KEY_LAB_RESULTS
					SET A1C = '0'
					WHERE A1C = ''
					END

					BEGIN
						BEGIN TRANSACTION
							update DM_DIABETES_KEY_LAB_RESULTS
							set GFR = ISNULL((SELECT TOP 1 Result
											 FROM  DM_DIABETES_LAB_RESULTS
											 WHERE PATIENTID = @pat2
											 AND DATETAKEN > DATEADD(M, -12, GETDATE())
											 AND LABRESULTTYPEID = 2
											 ORDER BY DATETAKEN DESC), '0'
											 )
							,GFRDate = (SELECT TOP 1 cast(DateTaken as nvarchar(25))
											FROM  DM_DIABETES_LAB_RESULTS
											WHERE PATIENTID = @pat2
											AND DATETAKEN > DATEADD(M, -12, GETDATE())
											AND LABRESULTTYPEID = 1
											ORDER BY DATETAKEN DESC)
							where patientid = @pat2
						COMMIT
					 END

					BEGIN
						BEGIN TRANSACTION
							update DM_DIABETES_KEY_LAB_RESULTS
							set LDL = ISNULL((SELECT TOP 1 Result
											  FROM DM_DIABETES_LAB_RESULTS
											  WHERE PATIENTID = @pat2
											  AND DATETAKEN > DATEADD(M, -12, GETDATE())
											  AND LABRESULTTYPEID = 3
											  ORDER BY DATETAKEN DESC), '0'
											  )
								,LDLDate = (SELECT TOP 1 cast(DateTaken as nvarchar(25))
											  FROM DM_DIABETES_LAB_RESULTS
											  WHERE PATIENTID = @pat2
											  AND DATETAKEN > DATEADD(M, -12, GETDATE())
											  AND LABRESULTTYPEID = 3
											  ORDER BY DATETAKEN DESC)
							where patientid = @pat2
						COMMIT
					 END
					 
				FETCH NEXT FROM curPATLABS INTO @PAT2
			
		END
	 END

CLOSE cuRPATLABS
DEALLOCATE curPATLABS
	END


