
CREATE PROCEDURE [dbo].[upODS_PHDiabetes_Micro_Patient_Order] AS

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

EXEC dbo.upActivityLog 'Begin PH Diabetes Micro Orders',0,@day;

--**********************************************************************************************
--INSERTS POP HEALTH DIABETES Micro ORDERS---------------------------
DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT 
	PATIENT.PatientId, 
	PE.PatientEncounterId, 
	PE.AppointmentDateTime AS OrderDatetime
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_DIABETES_MICROALBUMINS AS DIABETES 
	ON PATIENT.PatientIdentifier = DIABETES.EDIPN 
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND DIABETES.testDate = PE.AppointmentDateTime
WHERE (PE.SourceSystemId = 6) 
	AND (ISDATE(DIABETES.testDate) = 1)
	AND	Result IS NOT NULL
		
OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Diabetes Micro Order',0
FETCH NEXT FROM cur INTO @pat,@enc,@date

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@patX = PatientId,
				@encX = PatientEncounterId,
				@dateX = OrderDatetime
		FROM PATIENT_ORDER
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

SET @sirow = 'PH Diabetes Micro Order Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Diabetes Micro Order Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

EXEC dbo.upActivityLog 'End PH Diabetes Micro Orders',0,@day;


