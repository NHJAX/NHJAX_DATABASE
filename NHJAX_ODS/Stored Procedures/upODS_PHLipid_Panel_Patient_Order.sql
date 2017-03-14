
CREATE PROCEDURE [dbo].[upODS_PHLipid_Panel_Patient_Order] AS

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

EXEC dbo.upActivityLog 'Begin PH Lipid Panel Orders',0,@day;

--**********************************************************************************************
--INSERTS POP HEALTH Lipid Panel ORDERS---------------------------
DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT 
	PATIENT.PatientId, 
	PE.PatientEncounterId, 
	PE.AppointmentDateTime AS OrderDatetime
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_LIPID_PANEL AS LP 
	ON PATIENT.PatientIdentifier = LP.EDIPN  
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND LP.[LDL CertDate] = PE.AppointmentDateTime
WHERE (PE.SourceSystemId = 6) 
	AND (ISDATE(LP.[LDL CertDate]) = 1)
UNION
SELECT DISTINCT 
	PATIENT.PatientId, 
	PE.PatientEncounterId, 
	PE.AppointmentDateTime AS OrderDatetime
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_LIPID_PANEL AS LP 
	ON PATIENT.PatientIdentifier = LP.EDIPN 
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND LP.[CHOL CertDate] = PE.AppointmentDateTime
WHERE (PE.SourceSystemId = 6) 
	AND (ISDATE(LP.[Chol CertDate]) = 1)
UNION
SELECT DISTINCT 
	PATIENT.PatientId, 
	PE.PatientEncounterId, 
	PE.AppointmentDateTime AS OrderDatetime
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_LIPID_PANEL AS LP 
	ON PATIENT.PatientIdentifier = LP.EDIPN 
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND LP.[HDL CertDate] = PE.AppointmentDateTime
WHERE (PE.SourceSystemId = 6) 
	AND (ISDATE(LP.[HDL CertDate]) = 1)
		
OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Lipid Panel Order',0
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

				INSERT INTO NHJAX_ODS.dbo.PATIENT_ORDER(
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

SET @sirow = 'PH Lipid Panel Order Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Lipid Panel Order Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

EXEC dbo.upActivityLog 'End PH Lipid Panel Orders',0,@day;

