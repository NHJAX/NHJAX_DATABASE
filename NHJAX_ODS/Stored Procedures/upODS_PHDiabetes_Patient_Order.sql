
CREATE PROCEDURE [dbo].[upODS_PHDiabetes_Patient_Order] AS

Declare @pat bigint
Declare @enc bigint
Declare @date datetime
declare @desc varchar(60)

Declare @patX bigint
Declare @encX bigint
Declare @dateX datetime
declare @descX varchar(60)

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @ordnum numeric(14,3)
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin PH Diabetes Orders',0,@day;

--**********************************************************************************************
--INSERTS POP HEALTH DIABETES ORDERS---------------------------
DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT 
	PATIENT.PatientId, 
	PE.PatientEncounterId, 
	PE.AppointmentDateTime AS OrderDatetime
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_DIABETES AS DIABETES 
	ON PATIENT.PatientIdentifier = DIABETES.EDIPN
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND DIABETES.A1CDate = PE.AppointmentDateTime
WHERE (PE.SourceSystemId = 6) 
	AND (isdate(DIABETES.A1CDate) = 1)
UNION
SELECT DISTINCT 
	PATIENT.PatientId, 
	PE.PatientEncounterId, 
	PE.AppointmentDateTime AS OrderDatetime
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_DIABETES AS DIABETES 
	ON PATIENT.PatientIdentifier = DIABETES.EDIPN 
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND DIABETES.LDLCertDate = PE.AppointmentDateTime
WHERE (PE.SourceSystemId = 6) 
	AND (isdate(DIABETES.LDLCertDate) = 1)
UNION
SELECT DISTINCT 
	PATIENT.PatientId, 
	PE.PatientEncounterId, 
	PE.AppointmentDateTime AS OrderDatetime
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_DIABETES AS DIABETES 
	ON PATIENT.PatientIdentifier = DIABETES.EDIPN 
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND DIABETES.CHOLCertDate = PE.AppointmentDateTime
WHERE (PE.SourceSystemId = 6) 
	AND (isdate(DIABETES.CholCertDate) = 1)
UNION
SELECT DISTINCT 
	PATIENT.PatientId, 
	PE.PatientEncounterId, 
	PE.AppointmentDateTime AS OrderDatetime
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_DIABETES AS DIABETES 
	ON PATIENT.PatientIdentifier = DIABETES.EDIPN 
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND DIABETES.HDLCertDate = PE.AppointmentDateTime
WHERE (PE.SourceSystemId = 6) 
	AND (isdate(DIABETES.HDLCertDate) = 1)
		
OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH A1C Order',0
FETCH NEXT FROM cur INTO @pat,@enc,@date

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@patX = PatientId,
				@encX = PatientEncounterId,
				@dateX = OrderDatetime
		FROM NHJAX_ODS.dbo.PATIENT_ORDER
		WHERE	patientencounterid = @enc

		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN
			
				UPDATE GENERATOR SET LastNumber=LastNumber+1
				WHERE GeneratorTypeId = 2

				SET @ordnum = dbo.GenerateOrderKey(@pat)

				INSERT INTO PATIENT_ORDER(
				PatientId,
				PatientEncounterId,
				OrderDateTime,
				OrderTypeId,
				SourceSystemId,
				OrderKey
				)
				VALUES(@pat,@enc,@date,0,6,@ordnum);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @pat,@enc,@date
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'PH A1C Order Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH A1C Order Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

EXEC dbo.upActivityLog 'End PH Diabetes Orders',0,@day;

--**********************************************************************************************
--INSERTS POP HEALTH COLONOSCOPY ENCOUNTERS---------------------------
--DECLARE	curCOL CURSOR FAST_FORWARD FOR 
--SELECT		DISTINCT
--		18753 as cptid,
--		PE.PatientEncounterId,
--		4 as ProcedureTypeId,
--		PE.Appointmentdatetime as ProcedureDatetime,
--		'Pop Health Colonoscopy' as ProcedureDesc
			
--FROM        vwMDE_FAMILY_MEMBER_PREFIX AS FMP 
--	INNER JOIN vwMDE_PATIENT AS PAT 
--	ON FMP.KEY_FAMILY_MEMBER_PREFIX = PAT.FMP_IEN 
--	INNER JOIN vwSTG_POP_HEALTH_COLON AS COLON 
--	ON FMP.FMP = COLON.FMP 
--	AND PAT.SPONSOR_SSN = dbo.FormattedSSN(COLON.SponsorSSN)
--	INNER JOIN PATIENT 
--	ON PAT.KEY_PATIENT = PATIENT.PatientKey 
--	inner join Patient_Encounter As PE 
--	on Patient.patientid = PE.PatientId

--WHERE     (PE.SourceSystemId = 6)
		

--OPEN curCOL
--SET @trow = 0
--SET @irow = 0
--EXEC dbo.upActivityLog 'Fetch PH COLONOSCOPY Procedures',0
--FETCH NEXT FROM curProc INTO @cpt,@enc,@proc,@date,@desc

--if(@@FETCH_STATUS = 0)
--BEGIN
--	WHILE(@@FETCH_STATUS = 0)
--	BEGIN
--	BEGIN TRANSACTION
--		Select 	@cptX = CPTId,
--				@encX = PatientEncounterId,
--				@procX = ProcedureTypeId,
--				@dateX = ProcedureDatetime,
--				@descX = ProcedureDesc
--		FROM NHJAX_ODS.dbo.Patient_Procedure
--		WHERE	patientencounterid = @enc

--		SET		@exists = @@RowCount
--		If		@exists = 0 
			
--			BEGIN


----print 'EncounterId: '@enc
----print '#chars: ' len(@enc)


----SET @procstring = cast(cast(@enc as integer)as varchar(10)) + cast(day(@date)as varchar(5))
----SET @procnum = CAST(@procstring AS numeric(8,3)) 
----print 'Procedurekey: ' @procnum
----print '#chars: ' len(@procnum)
--				INSERT INTO NHJAX_ODS.dbo.Patient_Procedure(
--				CptId,
--				PatientEncounterId,
--				ProcedureTypeId,
--				ProcedureDateTime,
--				ProcedureDesc
--				)
--				VALUES(@cpt,@enc,@proc,@date,@desc);
--				SET @irow = @irow + 1
--			END
	
--		SET @trow = @trow + 1
--		FETCH NEXT FROM curCOL INTO @cpt,@enc,@proc,@date,@desc
		
--	COMMIT	
--	END
--END

--CLOSE curCOL
--DEALLOCATE curCOL

--SET @sirow = 'PH Colon Cancer Colonoscopy Procedure Inserted: ' + CAST(@irow AS varchar(50))
--SET @strow = 'PH Colon Cancer Colonoscopy Procedure Total: ' + CAST(@trow AS varchar(50))

--EXEC dbo.upActivityLog @sirow,0;
--EXEC dbo.upActivityLog @strow,0;



--EXEC dbo.upActivityLog 'End PH Colon Cancer Procedures',0;



