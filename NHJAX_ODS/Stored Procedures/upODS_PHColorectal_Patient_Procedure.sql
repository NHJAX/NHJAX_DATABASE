
CREATE PROCEDURE [dbo].[upODS_PHColorectal_Patient_Procedure] AS

Declare @cpt bigint
Declare @enc bigint
declare @proc bigint 
Declare @date datetime
declare @desc varchar(60)

Declare @cptX bigint
Declare @encX bigint
declare @procX bigint 
Declare @dateX datetime
declare @descX varchar(60)

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin PH Colorectal Procedures',0,@day;

--**********************************************************************************************
--INSERTS POP HEALTH COLONOSCOPY PROCEDURES---------------------------
DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT
	18753 AS CptId, 
	PE.PatientEncounterId, 
	4 AS ProcedureTypeId, 
	PE.AppointmentDateTime, 
	'POP HEALTH COLORECTAL SCREENING' AS ProcedureDesc
FROM PATIENT  
	INNER JOIN vwSTG_POP_HEALTH_COLON AS COL 
	ON PATIENT.PatientIdentifier = COL.EDIPN
	inner join Patient_Encounter As PE 
	on Patient.patientid = PE.PatientId
	AND COL.ColonoscopyDate = PE.AppointmentDateTime
WHERE     (PE.SourceSystemId = 6)
	AND ISDATE(COL.ColonoscopyDate) = 1
		
OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Colonoscopy Procedures',0
FETCH NEXT FROM cur INTO @cpt,@enc,@proc,@date,@desc

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@cptX = CPTId,
				@encX = PatientEncounterId,
				@procX = ProcedureTypeId,
				@dateX = ProcedureDatetime,
				@descX = ProcedureDesc
		FROM NHJAX_ODS.dbo.Patient_Procedure
		WHERE	patientencounterid = @enc

		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN


				INSERT INTO NHJAX_ODS.dbo.Patient_Procedure(
				CptId,
				PatientEncounterId,
				ProcedureTypeId,
				ProcedureDateTime,
				ProcedureDesc
				)
				VALUES(@cpt,@enc,@proc,@date,@desc);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @cpt,@enc,@proc,@date,@desc
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'PH Colonoscopy Procedure Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Colonoscopy Procedure Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

--**********************************************************************************************
--INSERTS POP HEALTH SIGMOID PROCEDURES---------------------------
DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT
	18754 AS CptId, 
	PE.PatientEncounterId, 
	4 AS ProcedureTypeId, 
	PE.AppointmentDateTime, 
	'POP HEALTH SIGMOID SCREENING' AS ProcedureDesc
FROM PATIENT  
	INNER JOIN vwSTG_POP_HEALTH_COLON AS COL 
	ON PATIENT.PatientIdentifier = COL.EDIPN
	inner join Patient_Encounter As PE 
	on Patient.patientid = PE.PatientId
	AND COL.FlexSigmoidDate = PE.AppointmentDateTime
WHERE     (PE.SourceSystemId = 6)
	AND ISDATE(COL.FlexSigmoidDate) = 1
		
OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Sigmoid Procedures',0
FETCH NEXT FROM cur INTO @cpt,@enc,@proc,@date,@desc

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@cptX = CPTId,
				@encX = PatientEncounterId,
				@procX = ProcedureTypeId,
				@dateX = ProcedureDatetime,
				@descX = ProcedureDesc
		FROM NHJAX_ODS.dbo.Patient_Procedure
		WHERE	patientencounterid = @enc

		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN


				INSERT INTO NHJAX_ODS.dbo.Patient_Procedure(
				CptId,
				PatientEncounterId,
				ProcedureTypeId,
				ProcedureDateTime,
				ProcedureDesc
				)
				VALUES(@cpt,@enc,@proc,@date,@desc);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @cpt,@enc,@proc,@date,@desc
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'PH Sigmoid Procedure Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Sigmoid Procedure Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

--**********************************************************************************************
--INSERTS POP HEALTH FOBT PROCEDURES---------------------------
--DECLARE	cur CURSOR FAST_FORWARD FOR 
--SELECT
--	18759 AS CptId, 
--	PE.PatientEncounterId, 
--	4 AS ProcedureTypeId, 
--	PE.AppointmentDateTime, 
--	'POP HEALTH FOBT SCREENING' AS ProcedureDesc
--FROM vwMDE_FAMILY_MEMBER_PREFIX AS FMP 
--	INNER JOIN vwMDE_PATIENT AS PAT 
--	ON FMP.KEY_FAMILY_MEMBER_PREFIX = PAT.FMP_IEN 
--	INNER JOIN vwSTG_POP_HEALTH_COLON AS COL 
--	ON FMP.FMP = COL.FMP 
--	AND PAT.SPONSOR_SSN = dbo.FormattedSSN(COL.SponsorSSN)
--	INNER JOIN PATIENT 
--	ON PAT.KEY_PATIENT = PATIENT.PatientKey 
--	inner join Patient_Encounter As PE 
--	on Patient.patientid = PE.PatientId
--	AND COL.FOBTDate = PE.AppointmentDateTime
--WHERE     (PE.SourceSystemId = 6)
--	AND ISDATE(COL.FOBTDate) = 1
		
--OPEN cur
--SET @trow = 0
--SET @irow = 0
--EXEC dbo.upActivityLog 'Fetch PH FOBT Procedures',0
--FETCH NEXT FROM cur INTO @cpt,@enc,@proc,@date,@desc

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
--		FETCH NEXT FROM cur INTO @cpt,@enc,@proc,@date,@desc
		
--	COMMIT	
--	END
--END

--CLOSE cur
--DEALLOCATE cur

--SET @sirow = 'PH FOBT Procedure Inserted: ' + CAST(@irow AS varchar(50))
--SET @strow = 'PH FOBT Procedure Total: ' + CAST(@trow AS varchar(50))

--EXEC dbo.upActivityLog @sirow,0;
--EXEC dbo.upActivityLog @strow,0;

--**********************************************************************************************
--INSERTS POP HEALTH DCBE PROCEDURES---------------------------
DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT
	18760 AS CptId, 
	PE.PatientEncounterId, 
	4 AS ProcedureTypeId, 
	PE.AppointmentDateTime, 
	'POP HEALTH DCBE SCREENING' AS ProcedureDesc
FROM PATIENT  
	INNER JOIN vwSTG_POP_HEALTH_COLON AS COL 
	ON PATIENT.PatientIdentifier = COL.EDIPN
	inner join Patient_Encounter As PE 
	on Patient.patientid = PE.PatientId
	AND COL.DCBEDate = PE.AppointmentDateTime
WHERE     (PE.SourceSystemId = 6)
	AND ISDATE(COL.DCBEDate) = 1
		
OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH DCBE Procedures',0
FETCH NEXT FROM cur INTO @cpt,@enc,@proc,@date,@desc

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@cptX = CPTId,
				@encX = PatientEncounterId,
				@procX = ProcedureTypeId,
				@dateX = ProcedureDatetime,
				@descX = ProcedureDesc
		FROM NHJAX_ODS.dbo.Patient_Procedure
		WHERE	patientencounterid = @enc

		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN


				INSERT INTO NHJAX_ODS.dbo.Patient_Procedure(
				CptId,
				PatientEncounterId,
				ProcedureTypeId,
				ProcedureDateTime,
				ProcedureDesc
				)
				VALUES(@cpt,@enc,@proc,@date,@desc);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @cpt,@enc,@proc,@date,@desc
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'PH DCBE Procedure Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH DCBE Procedure Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

EXEC dbo.upActivityLog 'End PH Colorectal Procedures',0,@day;



