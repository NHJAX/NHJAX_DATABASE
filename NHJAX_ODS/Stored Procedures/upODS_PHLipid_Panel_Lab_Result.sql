
CREATE PROCEDURE [dbo].[upODS_PHLipid_Panel_Lab_Result] AS

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

EXEC dbo.upActivityLog 'Begin PH Lipid Panel Lab Results',0,@day;

--**********************************************************************************************
--INSERTS POP HEALTH Lipid Panel LDL LAB RESULTS---------------------------
DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT 
	PATIENT.PatientId, 
	ORD.OrderId, 
	LP.[LDL CertDate] AS CertifyDate,
	LTRIM(RTRIM(REPLACE(LP.LDL,'=',''))) AS LDL
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_LIPID_PANEL AS LP 
	ON PATIENT.PatientIdentifier = LP.EDIPN  
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND LP.[LDL CertDate] = PE.AppointmentDateTime
	INNER JOIN PATIENT_ORDER AS ORD
	ON PE.PatientEncounterId = ORD.PatientEncounterId
WHERE (PE.SourceSystemId = 6) 
	AND (ISDATE(LP.[LDL CertDate]) = 1)
	AND LDL IS NOT NULL
		
OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Lipid Panel LDL Results',0
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

SET @sirow = 'PH Lipid Panel LDL Results Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Lipid Panel LDL Results Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

--**********************************************************************************************
--INSERTS POP HEALTH Lipid Panel CHOL LAB RESULTS---------------------------
DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT 
	PATIENT.PatientId, 
	ORD.OrderId, 
	LP.[CHOL CertDate] AS CertifyDate,
	LP.CHOL
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_LIPID_PANEL AS LP 
	ON PATIENT.PatientIdentifier = LP.EDIPN 
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND LP.[CHOL CertDate] = PE.AppointmentDateTime
	INNER JOIN PATIENT_ORDER AS ORD
	ON PE.PatientEncounterId = ORD.PatientEncounterId
WHERE (PE.SourceSystemId = 6) 
	AND (ISDATE(LP.[CHOL CertDate]) = 1)
	AND CHOL IS NOT NULL
		
OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Lipid Panel CHOL Results',0
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

SET @sirow = 'PH Lipid Panel CHOL Results Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Lipid Panel CHOL Results Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

--**********************************************************************************************
--INSERTS POP HEALTH Lipid Panel HDL LAB RESULTS---------------------------
DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT 
	PATIENT.PatientId, 
	ORD.OrderId, 
	LP.[HDL CertDate] AS CertifyDate,
	LP.HDL
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_LIPID_PANEL AS LP 
	ON PATIENT.PatientIdentifier = LP.EDIPN 
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND LP.[HDL CertDate] = PE.AppointmentDateTime
	INNER JOIN PATIENT_ORDER AS ORD
	ON PE.PatientEncounterId = ORD.PatientEncounterId
WHERE (PE.SourceSystemId = 6) 
	AND (ISDATE(LP.[HDL CertDate]) = 1)
	AND HDL IS NOT NULL
		
OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Lipid Panel HDL Results',0
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

SET @sirow = 'PH Lipid Panel HDL Results Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Lipid Panel HDL Results Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

--**********************************************************************************************
--INSERTS POP HEALTH Lipid Panel CHOL/HDL RATIO LAB RESULTS---------------------------
DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT 
	PATIENT.PatientId, 
	ORD.OrderId, 
	LP.[HDL CertDate] AS CertifyDate,
	LP.[Chol-HDL Ratio]
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_LIPID_PANEL AS LP 
	ON PATIENT.PatientIdentifier = LP.EDIPN 
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND LP.[HDL CertDate] = PE.AppointmentDateTime
	INNER JOIN PATIENT_ORDER AS ORD
	ON PE.PatientEncounterId = ORD.PatientEncounterId
WHERE (PE.SourceSystemId = 6) 
	AND (ISDATE(LP.[HDL CertDate]) = 1)
	AND [CHOL-HDL Ratio] IS NOT NULL
		
OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Lipid Panel CHOL/HDL Ratio Results',0
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

SET @sirow = 'PH Lipid Panel CHOL/HDL Ratio Results Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Lipid Panel CHOL/HDL Ratio Results Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

EXEC dbo.upActivityLog 'End PH Lipid Panel Results',0,@day;

