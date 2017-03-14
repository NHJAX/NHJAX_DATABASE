
CREATE PROCEDURE [dbo].[upODS_PHDiabetes_Lab_Result] AS

Declare @pat bigint
Declare @ord bigint
Declare @date datetime
declare @res varchar(19)

Declare @patX bigint
Declare @ordX bigint
Declare @dateX datetime
declare @resX varchar(19)

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin PH Diabetes Lab Results',0,@day;

--**********************************************************************************************
--INSERTS POP HEALTH DIABETES LAB RESULTS---------------------------
DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT 
	PATIENT.PatientId, 
	ORD.OrderId, 
	DIABETES.A1CDate AS CertifyDate,
	LTRIM(RTRIM(REPLACE(DIABETES.A1CResult,'=',''))) AS A1CResult
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_DIABETES AS DIABETES 
	ON PATIENT.PatientIdentifier = DIABETES.EDIPN
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND DIABETES.A1CDate = PE.AppointmentDateTime
	INNER JOIN PATIENT_ORDER AS ORD
	ON PE.PatientEncounterId = ORD.PatientEncounterId
WHERE (PE.SourceSystemId = 6) 
	AND (isdate(DIABETES.A1CDate) = 1)
	AND A1CResult IS NOT NULL
		
OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH A1C Results',0
FETCH NEXT FROM cur INTO @pat,@ord,@date,@res

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@patX = PatientId,
				@ordX = OrderId,
				@dateX = CertifyDate,
				@resX = Result
		FROM NHJAX_ODS.dbo.LAB_RESULT
		WHERE	OrderId = @ord
		AND		LabTestId = 3607

		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN

				INSERT INTO NHJAX_ODS.dbo.LAB_RESULT(
				PatientId,
				OrderId,
				CertifyDate,
				Result,
				LabTestId,
				AccessionTypeId
				)
				VALUES(@pat,@ord,@date,@res,3607,12);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @pat,@ord,@date,@res
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'PH A1C Results Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH A1C Results Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

--**********************************************************************************************
--INSERTS POP HEALTH DIABETES LDL LAB RESULTS---------------------------
DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT 
	PATIENT.PatientId, 
	ORD.OrderId, 
	DIABETES.LDLCertDate AS CertifyDate,
	DIABETES.LDL
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_DIABETES AS DIABETES 
	ON PATIENT.PatientIdentifier = DIABETES.EDIPN 
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND DIABETES.LDLCertDate = PE.AppointmentDateTime
	INNER JOIN PATIENT_ORDER AS ORD
	ON PE.PatientEncounterId = ORD.PatientEncounterId
WHERE (PE.SourceSystemId = 6) 
	AND (ISDATE(DIABETES.LDLCertDate) = 1)
	AND LDL IS NOT NULL
		
OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH LDL Results',0
FETCH NEXT FROM cur INTO @pat,@ord,@date,@res

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@patX = PatientId,
				@ordX = OrderId,
				@dateX = CertifyDate,
				@resX = Result
		FROM NHJAX_ODS.dbo.LAB_RESULT
		WHERE	OrderId = @ord
		AND		LabTestId = 3608
		
		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN

				INSERT INTO NHJAX_ODS.dbo.LAB_RESULT(
				PatientId,
				OrderId,
				CertifyDate,
				Result,
				LabTestId,
				AccessionTypeId
				)
				VALUES(@pat,@ord,@date,@res,3608,12);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @pat,@ord,@date,@res
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'PH LDL Results Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH LDL Results Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

--**********************************************************************************************
--INSERTS POP HEALTH DIABETES CHOL LAB RESULTS---------------------------
DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT 
	PATIENT.PatientId, 
	ORD.OrderId, 
	DIABETES.CHOLCertDate AS CertifyDate,
	DIABETES.CHOL
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_DIABETES AS DIABETES 
	ON PATIENT.PatientIdentifier = DIABETES.EDIPN 
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND DIABETES.CHOLCertDate = PE.AppointmentDateTime
	INNER JOIN PATIENT_ORDER AS ORD
	ON PE.PatientEncounterId = ORD.PatientEncounterId
WHERE (PE.SourceSystemId = 6) 
	AND (ISDATE(DIABETES.CHOLCertDate) = 1)
	AND CHOL IS NOT NULL
		
OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH CHOL Results',0
FETCH NEXT FROM cur INTO @pat,@ord,@date,@res

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@patX = PatientId,
				@ordX = OrderId,
				@dateX = CertifyDate,
				@resX = Result
		FROM NHJAX_ODS.dbo.LAB_RESULT
		WHERE	OrderId = @ord
		AND		LabTestId = 3609

		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN

				INSERT INTO NHJAX_ODS.dbo.LAB_RESULT(
				PatientId,
				OrderId,
				CertifyDate,
				Result,
				LabTestId,
				AccessionTypeId
				)
				VALUES(@pat,@ord,@date,@res,3609,12);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @pat,@ord,@date,@res
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'PH CHOL Results Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH CHOL Results Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

--**********************************************************************************************
--INSERTS POP HEALTH DIABETES HDL LAB RESULTS---------------------------
DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT 
	PATIENT.PatientId, 
	ORD.OrderId, 
	DIABETES.HDLCertDate AS CertifyDate,
	DIABETES.HDL
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_DIABETES AS DIABETES 
	ON PATIENT.PatientIdentifier = DIABETES.EDIPN 
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND DIABETES.HDLCertDate = PE.AppointmentDateTime
	INNER JOIN PATIENT_ORDER AS ORD
	ON PE.PatientEncounterId = ORD.PatientEncounterId
WHERE (PE.SourceSystemId = 6) 
	AND (ISDATE(DIABETES.HDLCertDate) = 1)
	AND HDL IS NOT NULL
		
OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH HDL Results',0
FETCH NEXT FROM cur INTO @pat,@ord,@date,@res

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@patX = PatientId,
				@ordX = OrderId,
				@dateX = CertifyDate,
				@resX = Result
		FROM NHJAX_ODS.dbo.LAB_RESULT
		WHERE	OrderId = @ord
		AND		LabTestId = 3610

		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN

				INSERT INTO NHJAX_ODS.dbo.LAB_RESULT(
				PatientId,
				OrderId,
				CertifyDate,
				Result,
				LabTestId,
				AccessionTypeId
				)
				VALUES(@pat,@ord,@date,@res,3610,12);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @pat,@ord,@date,@res
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'PH HDL Results Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH HDL Results Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

--**********************************************************************************************
--INSERTS POP HEALTH DIABETES CHOL/HDL RATIO LAB RESULTS---------------------------
DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT 
	PATIENT.PatientId, 
	ORD.OrderId, 
	DIABETES.HDLCertDate AS CertifyDate,
	DIABETES.[Chol-HDLRatio]
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_DIABETES AS DIABETES 
	ON PATIENT.PatientIdentifier = DIABETES.EDIPN 
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND DIABETES.HDLCertDate = PE.AppointmentDateTime
	INNER JOIN PATIENT_ORDER AS ORD
	ON PE.PatientEncounterId = ORD.PatientEncounterId
WHERE (PE.SourceSystemId = 6) 
	AND (ISDATE(DIABETES.HDLCertDate) = 1)
	AND [CHOL-HDLRatio] IS NOT NULL
		
OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH CHOL/HDL Ratio Results',0
FETCH NEXT FROM cur INTO @pat,@ord,@date,@res

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@patX = PatientId,
				@ordX = OrderId,
				@dateX = CertifyDate,
				@resX = Result
		FROM NHJAX_ODS.dbo.LAB_RESULT
		WHERE	OrderId = @ord
		AND		LabTestId = 3611

		SET		@exists = @@RowCount
		If		@exists = 0 
			
			BEGIN

				INSERT INTO NHJAX_ODS.dbo.LAB_RESULT(
				PatientId,
				OrderId,
				CertifyDate,
				Result,
				LabTestId,
				AccessionTypeId
				)
				VALUES(@pat,@ord,@date,@res,3611,12);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @pat,@ord,@date,@res
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'PH CHOL/HDL Ratio Results Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH CHOL/HDL Ratio Results Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

EXEC dbo.upActivityLog 'End PH Diabetes Results',0,@day;

