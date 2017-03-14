
CREATE PROCEDURE [dbo].[upODS_PHChlamydia_Patient_Procedure] AS

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

EXEC dbo.upActivityLog 'Begin PH Chlamydia Procedure',0,@day;

DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT		DISTINCT
	19821 as cptid,
	PE.PatientEncounterId,
	4 as ProcedureTypeId,
	PE.Appointmentdatetime as ProcedureDatetime,
	'Pop Health Chlamydia' as ProcedureDesc		
FROM PATIENT  
	INNER JOIN vwSTG_POP_HEALTH_CHLAMYDIA AS CHLAM 
	ON PATIENT.PatientIdentifier = CHLAM.EDIPN  
	INNER JOIN Patient_Encounter As PE 
	ON PATIENT.Patientid = PE.PatientId
	AND CHLAM.[Last Exam Date] = PE.AppointmentDateTime
WHERE     (PE.SourceSystemId = 6)
	AND ISDATE(CHLAM.[Last Exam Date]) = 1

OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Chlamydia Procedure',0
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
		WHERE	PatientEncounterId = @enc

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

SET @sirow = 'PH Chlamydia Procedure Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Chlamydia Procedure Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PH Chlamydia Procedure',0,@day;



