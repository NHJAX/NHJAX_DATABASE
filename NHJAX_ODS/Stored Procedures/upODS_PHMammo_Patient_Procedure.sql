
CREATE PROCEDURE [dbo].[upODS_PHMammo_Patient_Procedure] AS

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

--Declare @procstring as varchar(25)
--declare @procnum numeric(8,3)

EXEC dbo.upActivityLog 'Begin PH Mammography Procedure',0,@day;


DECLARE	curMammoProc CURSOR FAST_FORWARD FOR 
SELECT		DISTINCT
	17811 as cptid,
	PE.PatientEncounterId,
	4 as ProcedureTypeId,
	PE.Appointmentdatetime as ProcedureDatetime,
	'Pop Health Mammogram' as ProcedureDesc		
FROM PATIENT
	INNER JOIN vwSTG_POP_HEALTH_MAMMOGRAPHY AS MAMMO 
	ON PATIENT.PatientIdentifier = MAMMO.EDIPN 
	inner join Patient_Encounter As PE 
	on Patient.patientid = PE.PatientId
	AND MAMMO.LastExamDate = PE.AppointmentDateTime
WHERE     (PE.SourceSystemId = 6)
	AND ISDATE(MAMMO.LastExamDate) = 1

OPEN curMammoProc
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Mammography Procedure',0
FETCH NEXT FROM curMammoProc INTO @cpt,@enc,@proc,@date,@desc

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
		FETCH NEXT FROM curMammoProc INTO @cpt,@enc,@proc,@date,@desc
		
	COMMIT	
	END
END

CLOSE curMammoProc
DEALLOCATE curMammoProc

SET @sirow = 'PH Mammography Procedure Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Mammography Procedure Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PH Mammography Procedure',0,@day;



