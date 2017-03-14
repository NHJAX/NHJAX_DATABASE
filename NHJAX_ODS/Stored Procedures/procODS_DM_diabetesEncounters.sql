
CREATE procedure [dbo].[procODS_DM_diabetesEncounters] as 

BEGIN
--**********************************************************************************
--* UPDATE LOG
--* 5-15-2013 R Evans Updated Eye Exam to only look for CPT S3000 per Dr McQuade
--*
--*
--**********************************************************************************
DECLARE @pat bigint
DECLARE @desc nvarchar(30)
DECLARE @date datetime
DECLARE @enc int
DECLARE @cpt nchar(10)
DECLARE @src int

DECLARE @irow int
DECLARE @sirow nvarchar(50)

truncate table DM_DIABETES_ENCOUNTERS

EXEC dbo.upActivityLog 'Begin Diabetes Encounters',0

DECLARE curDBEnc CURSOR FAST_FORWARD FOR

SELECT  distinct  P.PatientId
				, PP.ProcedureDesc
				, PP.PROCEDUREDATETIME as ProcedureDateTime
				, 2 as EncounterType
				, CPT.CPTID
				,pp.sourcesystemid

FROM			PATIENT P INNER JOIN
				PATIENT_PROCEDURE PP INNER JOIN
                PATIENT_ENCOUNTER PE ON PP.PatientEncounterId = PE.PatientEncounterId ON 
                P.PatientId = PE.PatientId
				INNER JOIN CPT ON PP.CptId = CPT.CptId
		
	--cpt codes for eye exams 
	
where pp.cptid in (16392) --(8807,8808,8809,8810,18761) --***** UPDATED TO CPT S3000 5-15-2013 REE

AND		P.PatientId in (SELECT PatientId FROM nhjax_ods.dbo.PATIENT_FLAG WHERE FLAGID = 2)
and pp.proceduredatetime >= dateadd(m,-12,getdate())
and isdate(pp.proceduredatetime)  = 1
and pp.proceduredesc not like '%e&m%'

UNION

SELECT  distinct  P.PatientId				
				, PP.ProcedureDesc
				, PP.PROCEDUREDATETIME as ProcedureDateTime
				, 3 as EncounterType
				, CPT.CPTID
				, pp.sourcesystemid
	
FROM			PATIENT P INNER JOIN
				PATIENT_PROCEDURE PP INNER JOIN
                PATIENT_ENCOUNTER PE ON PP.PatientEncounterId = PE.PatientEncounterId ON 
                P.PatientId = PE.PatientId INNER JOIN
                CPT ON PP.CptId = CPT.CptId

--cpt codes for NUTRITIONAL CONSULTS
where CPT.CPTCODE in (
					'97802','97803','97804'
					  )

and pp.proceduredatetime >= dateadd(m,-12,getdate())
and isdate(pp.proceduredatetime)  = 1
AND		P.PatientId in (
						SELECT PatientId
						FROM nhjax_ods.dbo.PATIENT_FLAG
						WHERE FLAGID = 2
						)

UNION

SELECT  distinct  P.PatientId
				, PP.ProcedureDesc
				, PP.PROCEDUREDATETIME as ProcedureDateTime
				, 5 as EncounterType
				, CPT.CPTID
				, pp.sourcesystemid
	
FROM			PATIENT P INNER JOIN
				PATIENT_PROCEDURE PP INNER JOIN
                PATIENT_ENCOUNTER PE ON PP.PatientEncounterId = PE.PatientEncounterId ON 
                P.PatientId = PE.PatientId inner join
				encounter_diagnosis ED on ED.patientencounterid = PE.patientencounterid
				INNER JOIN CPT ON PP.CPTID = CPT.CPTID
	

--cpt codes for pneumovax shots
where ed.diagnosisid in (
					'12668','12666'
					  )

and pp.proceduredatetime >= dateadd(m,-60,getdate())
and isdate(pp.proceduredatetime)  = 1
AND		P.PatientId in (
						SELECT PatientId
						FROM nhjax_ods.dbo.PATIENT_FLAG
						WHERE FLAGID = 2
						)

UNION 

SELECT  distinct  P.PatientId
				, PP.ProcedureDesc
				, PP.PROCEDUREDATETIME as ProcedureDateTime
				, 4 as EncounterType	
				, CPT.CPTID
				, pp.sourcesystemid

FROM			PATIENT P INNER JOIN
				PATIENT_PROCEDURE PP INNER JOIN
                PATIENT_ENCOUNTER PE ON PP.PatientEncounterId = PE.PatientEncounterId ON 
                P.PatientId = PE.PatientId
				INNER JOIN CPT ON PP.CptId = CPT.CptId

--cpt codes for Foot Exams
where PP.CPTID in (
					'17909' -- FOR CPTCODE 2028F
					,'15283' -- FOR CPTCODE G0247
					  )

and pp.proceduredatetime >= dateadd(m,-12,getdate())
and isdate(pp.proceduredatetime)  = 1
AND		P.PatientId in (
						SELECT PatientId
						FROM nhjax_ods.dbo.PATIENT_FLAG
						WHERE FLAGID = 2
						)

UNION 

SELECT  distinct  P.PatientId				
				, PP.ProcedureDesc
				, PP.PROCEDUREDATETIME as ProcedureDateTime
				, 1 as EncounterType	
				, CPT.CPTID
				, pp.sourcesystemid

FROM			PATIENT P INNER JOIN
				PATIENT_PROCEDURE PP INNER JOIN
                PATIENT_ENCOUNTER PE ON PP.PatientEncounterId = PE.PatientEncounterId ON 
                P.PatientId = PE.PatientId	
				INNER JOIN CPT ON CPT.CPTID=PP.CPTID

--cpt codes for Flushots
where pp.cptid in (
					13118 --for cpt code 90658
					,13119 -- for cpt code 90660
					  )

and pp.proceduredatetime >= dateadd(m,-12,getdate())
and isdate(pp.proceduredatetime)  = 1
AND		P.PatientId in (
						SELECT PatientId
						FROM nhjax_ods.dbo.PATIENT_FLAG
						WHERE FLAGID = 2
						)

order by patientid

set @irow = 0

OPEN curDBEnc

EXEC dbo.upActivityLog 'Fetch Diabetes Encounters' , 0

FETCH NEXT FROM curDBEnc INTO @pat,@desc,@date,@enc,@cpt,@src

IF (@@FETCH_STATUS = 0)
	BEGIN
		WHILE @@FETCH_STATUS = 0
			BEGIN
				BEGIN TRANSACTION
					INSERT INTO DM_DIABETES_ENCOUNTERS
					(
						PatientId
						,ProcedureDesc
						,ProcedureDate
						,EncounterTypeId
						,SourceSystemId
						,CPTCODE						
					)
					VALUES
					(
						@pat
						,@desc
						,@date
						,@enc
						,@src
						,@cpt
					);
					set @irow = @irow +1
			
			FETCH NEXT FROM curDBEnc INTO @pat,@desc,@date,@enc,@cpt,@src
			COMMIT
		END
	END
CLOSE curDBEnc
DEALLOCATE curDBEnc

set @sirow = 'Diabetes Encounters Inserted: ' + cast(@irow as nvarchar(50))

EXEC upActivityLog @sirow,0
EXEC upActivityLog 'End Diabetes Encounters',0




END			