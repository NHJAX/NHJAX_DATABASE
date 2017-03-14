
CREATE PROCEDURE [dbo].[procODS_CREATE_TABLE_DM_ICS_SABA_DETAILS]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @start datetime
DECLARE @end datetime
SET		@start = dbo.StartOfDay(DATEADD(MM,-12,GETDATE()))
SET		@end = dbo.EndOfDay(GETDATE())

TRUNCATE TABLE DM_ASTHMA_ISC_SABA_DETAILS

DECLARE @patid bigint 
		,@patname nvarchar(50)
		,@dob datetime
		,@fmp int
		,@spnssn nvarchar(11)
		,@age nvarchar(3)
		,@pcmid bigint
		,@pcmname nvarchar(50)
		,@hosps int
		,@opv int
		,@erv int
		,@disp int
		,@iscid bigint
		,@ics nvarchar(41)
		,@icscnt int
		,@icsfill datetime
		,@sabaid bigint
		,@saba nvarchar(41)
		,@sabacnt int
		,@sabafill datetime

DECLARE curPAT CURSOR FAST_FORWARD FOR

	SELECT		P.PATIENTID
				,P.FULLNAME
				,P.DOB
				,YEAR(GETDATE()) -YEAR(P.DOB) AS AGE
				,FMP.FamilyMemberPrefixnumber
				,P.SPONSORSSN
				,PCM.PROVIDERID
				,PRO.PROVIDERNAME
	FROM		[NHJAX_ODS].DBO.PATIENT P LEFT JOIN
				[NHJAX_ODS].DBO.FAMILY_MEMBER_PREFIX FMP ON FMP.FamilyMemberPrefixid = P.FamilyMemberPrefixid LEFT JOIN
				[NHJAX_ODS].DBO.PRIMARY_CARE_MANAGER PCM ON PCM.PATIENTID = P.PATIENTID LEFT JOIN
				[NHJAX_ODS].DBO.PROVIDER PRO ON PRO.PROVIDERID = PCM.PROVIDERID 
	WHERE		P.PATIENTID IN (SELECT PATIENTID FROM [NHJAX_ODS].DBO.PATIENT_FLAG WHERE FLAGID = 1)
	AND			P.PATIENTID NOT IN (SELECT PATIENTID FROM [CLINICAL_PORTAL].DBO.CUSTOM_PATIENT_TRACKING)
	ORDER BY	P.FULLNAME
	OPEN curPAT
	FETCH NEXT FROM curPAT INTO @patid, @patname, @dob, @age, @fmp, @spnssn, @pcmid, @pcmname
	IF (@@FETCH_STATUS = 0)
		BEGIN
			WHILE (@@FETCH_STATUS = 0)
			BEGIN				
				BEGIN TRANSACTION
			--***************get last ics rx******************
					SELECT TOP 1		@iscid = PRE.DrugId
										,@ics = drug.DrugDesc
										,@icsfill = PFD.FILLDATE										
					FROM				NHJAX_ODS.dbo.DRUG DRUG LEFT JOIN
										NHJAX_ODS.DBO.PRESCRIPTION PRE ON DRUG.DrugId = PRE.DrugId  LEFT JOIN							
										NHJAX_ODS.DBO.PRESCRIPTION_FILL_DATE PFD ON PRE.PRESCRIPTIONID = PFD.PRESCRIPTIONID					
					WHERE				PRE.DrugId IN (SELECT ICSDRUGID FROM DM_ASTHMA_ISC_DRUG_LOOKUP)
					AND					PFD.FILLDATE BETWEEN @start AND @end
					AND					PFD.PRESCRIPTIONACTIONID = 2
					AND					PRE.PatientId = @patid
					ORDER BY			PFD.FillDate DESC
					
			--**************get last saba rx*******************		
					SELECT TOP 1		@sabaid = PRE.DrugId
										,@saba = drug.DrugDesc
										,@sabafill = PFD.FILLDATE										
					FROM				NHJAX_ODS.dbo.DRUG DRUG LEFT JOIN
										NHJAX_ODS.DBO.PRESCRIPTION PRE ON DRUG.DrugId = PRE.DrugId  RIGHT JOIN							
										NHJAX_ODS.DBO.PRESCRIPTION_FILL_DATE PFD ON PRE.PRESCRIPTIONID = PFD.PRESCRIPTIONID					
					WHERE				PRE.DrugId IN (SELECT SABADrugId FROM DM_ASTHMA_SABA_DRUG_LOOKUP)
					AND					PFD.FILLDATE BETWEEN @start AND @end
					AND					PFD.PRESCRIPTIONACTIONID = 2
					AND					PRE.PatientId = @patid
					ORDER BY			PFD.FillDate DESC
					
			--**************get hospitalization count***********	
					SELECT DISTINCT		@hosps = COUNT(pa.PATIENTADMISSIONID)
					FROM				[NHJAX_ODS].[dbo].[PATIENT_ADMISSION] PA RIGHT JOIN
										[NHJAX_ODS].DBO.PATIENT_ENCOUNTER PE ON PA.PatientId = PE.PatientId
					WHERE				PE.ADMISSIONDATETIME BETWEEN @start AND @end
					AND					PE.PatientId = @patid
					ORDER BY			COUNT(PATIENTADMISSIONID) DESC
			
			--**************get outpatient visit count*********
					SELECT DISTINCT		@opv = COUNT(PATIENTENCOUNTERID)
					FROM				NHJAX_ODS.DBO.PATIENT_ENCOUNTER PE
					WHERE				PE.APPOINTMENTSTATUSID = 2
					AND					PE.ADMISSIONDATETIME IS NULL
					AND					PE.HOSPITALLOCATIONID <> 174
					AND					PE.APPOINTMENTDATETIME BETWEEN @start AND @end
					AND					PE.PatientId = @patid
					ORDER BY			COUNT(PATIENTENCOUNTERID) DESC
					
			--**************get er visit count*****************
					SELECT DISTINCT		@erv = COUNT(PATIENTENCOUNTERID)
					FROM				NHJAX_ODS.DBO.PATIENT_ENCOUNTER PE
					WHERE				PE.APPOINTMENTSTATUSID = 2
					AND					PE.ADMISSIONDATETIME IS NULL
					AND					PE.HOSPITALLOCATIONID <> 174
					AND					PE.APPOINTMENTDATETIME BETWEEN @start AND @end
					AND					PE.AccessToCareId = 1					
					AND					PE.PatientId = @patid
					ORDER BY			COUNT(PATIENTENCOUNTERID) DESC
			
			--**************get ics count**********************
					SELECT	DISTINCT 	@icscnt = COUNT(PrescriptionFillDateId)
					FROM				NHJAX_ODS.DBO.PRESCRIPTION PRE LEFT JOIN
										NHJAX_ODS.DBO.PRESCRIPTION_FILL_DATE PFD ON PRE.PRESCRIPTIONID = PFD.PRESCRIPTIONID
					WHERE				PRE.DrugId IN (SELECT ICSDRUGid FROM DM_ASTHMA_ISC_DRUG_LOOKUP)
					AND					PFD.FILLDATE BETWEEN @start AND @end
					AND					PFD.PRESCRIPTIONACTIONID = 2
					AND					PRE.PatientId = @patid
					
			--**************get saba count**********************
					SELECT	DISTINCT	@sabacnt = COUNT(PrescriptionFillDateId)
					FROM				NHJAX_ODS.DBO.PRESCRIPTION PRE LEFT JOIN
										NHJAX_ODS.DBO.PRESCRIPTION_FILL_DATE PFD ON PRE.PRESCRIPTIONID = PFD.PRESCRIPTIONID
					WHERE				PRE.DrugId IN (SELECT SABADrugId FROM DM_ASTHMA_SABA_DRUG_LOOKUP)
					AND					PFD.FILLDATE BETWEEN @start AND @end
					AND					PFD.PRESCRIPTIONACTIONID = 2
					AND					PRE.PatientId = @patid
					
			--**************get dispensing events***************
					SELECT	DISTINCT @disp = COUNT(PrescriptionFillDateId)     
					FROM				NHJAX_ODS.DBO.PRESCRIPTION PRE  LEFT JOIN
										NHJAX_ODS.DBO.PRESCRIPTION_FILL_DATE PFD ON PRE.PRESCRIPTIONID = PFD.PRESCRIPTIONID
					WHERE				PFD.FILLDATE BETWEEN @start AND @end
					AND					PFD.PRESCRIPTIONACTIONID = 2
					AND					PRE.PatientId = @patid							
				INSERT INTO DM_ASTHMA_ISC_SABA_DETAILS
				(
					PATIENTID
					,FULLNAME
					,DOB
					,FMP
					,SPONSORSSN
					,AGE
					,PCMID
					,PCMNAME
					,HOSPITALIZATIONS
					,OUTPATIENTVISITS
					,ERVISITS
					,DISPENSINGEVENTS
					,ICSID
					,ControlICSDesc
					,ICSLASTFILL
					,ICSCOUNT
					,SABAID
					,SABADESC
					,SABALASTFILL
					,SABACOUNT				
				)
				VALUES
				(
					@patid
					,@patname
					,@dob
					,@fmp
					,@spnssn
					,@age
					,@pcmid
					,@pcmname
					,@hosps
					,@opv
					,@erv
					,@disp
					,@iscid
					,@ics
					,@icsfill
					,@icscnt
					,@sabaid
					,@saba
					,@sabafill
					,@sabacnt					
				)				
				COMMIT
					SET		@hosps = NULL
					SET		@opv = NULL
					SET		@erv = NULL
					SET		@disp = NULL
					SET		@iscid = NULL
					SET		@ics = NULL
					SET		@icscnt = NULL
					SET		@icsfill = NULL
					SET		@sabaid = NULL
					SET		@saba = NULL
					SET		@sabacnt = NULL
					SET		@sabafill = NULL
				FETCH NEXT FROM curPAT INTO @patid, @patname, @dob, @age, @fmp, @spnssn, @pcmid, @pcmname
			END
		END		
CLOSE curPAT
DEALLOCATE curPAT
ALTER INDEX ALL ON DM_ASTHMA_ISC_SABA_DETAILS
REBUILD;
END
