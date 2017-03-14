
CREATE PROCEDURE [dbo].[upODS_PHDiabetes_Patient_Encounters] AS

Declare @pat bigint
Declare @date datetime
Declare @src bigint

Declare @patX bigint
Declare @dateX datetime
Declare @srcX bigint

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int

Declare @encstring as varchar(25)
Declare @encnum as numeric(13,3)
Declare @gen bigint
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin PH Diabetes Encounter',0,@day;


DECLARE	curDiabEnc CURSOR FAST_FORWARD FOR 
SELECT  	PATIENT.PatientId,
			diab.RetinalDate AS Appointmentdatetime,
			6 AS SourceSystemId			
FROM        PATIENT
			INNER JOIN vwSTG_POP_HEALTH_DIABETES AS DIAB 
			ON PATIENT.PatientIdentifier = DIAB.EDIPN 
WHERE     (isdate(diab.RetinalDate) = 1)
UNION
SELECT  	PATIENT.PatientId,
			diab.A1CDate AS Appointmentdatetime,
			6 AS SourceSystemId			
FROM        PATIENT
			INNER JOIN vwSTG_POP_HEALTH_DIABETES AS DIAB 
			ON PATIENT.PatientIdentifier = DIAB.EDIPN
WHERE     (isdate(diab.A1CDate) = 1)
UNION
SELECT  	PATIENT.PatientId,
			diab.LDLCertDate AS Appointmentdatetime,
			6 AS SourceSystemId			
FROM        PATIENT
			INNER JOIN vwSTG_POP_HEALTH_DIABETES AS DIAB 
			ON PATIENT.PatientIdentifier = DIAB.EDIPN
WHERE     (isdate(diab.LDLCertDate) = 1)
UNION
SELECT  	PATIENT.PatientId,
			diab.CHOLCertDate AS Appointmentdatetime,
			6 AS SourceSystemId			
FROM        PATIENT
			INNER JOIN vwSTG_POP_HEALTH_DIABETES AS DIAB 
			ON PATIENT.PatientIdentifier = DIAB.EDIPN
WHERE     (isdate(diab.CHOLCertDate) = 1)
UNION
SELECT  	PATIENT.PatientId,
			diab.HDLCertDate AS Appointmentdatetime,
			6 AS SourceSystemId			
FROM        PATIENT
			INNER JOIN vwSTG_POP_HEALTH_DIABETES AS DIAB 
			ON PATIENT.PatientIdentifier = DIAB.EDIPN
WHERE     (isdate(diab.HDLCertDate) = 1)

OPEN curDiabEnc
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Diabetes Encounter',0
FETCH NEXT FROM curDiabEnc INTO @pat,@date,@src

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@patX = PatientId,
				@dateX = AppointmentDatetime,
				@srcX = SourceSystemId
		FROM NHJAX_ODS.dbo.Patient_Encounter
		WHERE	PatientId = @pat
			AND SourceSystemId = @src
			AND AppointmentDatetime = @date
		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN

			UPDATE GENERATOR SET LastNumber=LastNumber+1
			WHERE GeneratorTypeId = 1
			
			--SELECT @gen = LastNumber 
			--FROM GENERATOR
			
			SET @encnum = dbo.GenerateEncounterKey(@pat)

		--COMMENT------------------
/*@ENCSTRING TAKES THE PATIENT ID, CONVERTS IT TO A STRING, THEN ADDS IT TO A RANDOM NUMBER DIVIDED BY THE RANDOMIZED ENCOUNTER DAY
 AS A STRING FOR THE ENCOUNTER KEY FIELD.*/
--cast(cast(@pat as integer) as varchar(10)) + cast(@gen as varchar(10))

--declare @test as varchar(20)
--declare @test2 as numeric(13,3)
--set @test = 
--set @test2 = 
--print @test2
--print 'patient #: ' + cast(@pat as varchar(25))
--set @encstring = cast(cast(@pat/2 as integer) as varchar(15)) + cast(cast(@gen/2 as integer) as varchar(10))
--set @encnum = cast(substring(@encstring, 1, 9) as numeric(13,3))
--print 'Generated #: ' + cast(@gen as varchar(10))
--print 'Generated key: ' + cast(@encstring as varchar(25))
--print 'Encounterkey: ' + cast(@encnum as varchar(25))
--print '#chars: ' + cast(len(@encnum) as varchar(25))

				INSERT INTO NHJAX_ODS.dbo.Patient_Encounter(
				PatientId,
				AppointmentDatetime,
				SourceSystemId,
				EncounterKey)
				VALUES(@pat,@date,@src,@encnum);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM curDiabEnc INTO @pat,@date,@src
		
	COMMIT	
	END
END

CLOSE curDiabEnc
DEALLOCATE curDiabEnc

SET @sirow = 'PH Diabetes Encounter Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Diabetes Encounter Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End PH Diabetes Encounter',0,@day;
