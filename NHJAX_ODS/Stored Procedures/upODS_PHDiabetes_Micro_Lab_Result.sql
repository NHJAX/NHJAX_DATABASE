
CREATE PROCEDURE [dbo].[upODS_PHDiabetes_Micro_Lab_Result] AS

Declare @pat bigint
Declare @ord bigint
Declare @date datetime
declare @res varchar(19)
Declare @test bigint

Declare @patX bigint
Declare @ordX bigint
Declare @dateX datetime
declare @resX varchar(19)
Declare @testX bigint

Declare @trow int
Declare @irow int
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @exists int
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin PH Diabetes Micro Lab Results',0,@day;

--**********************************************************************************************
--INSERTS POP HEALTH DIABETES Micro LAB RESULTS---------------------------
DECLARE	cur CURSOR FAST_FORWARD FOR 
SELECT DISTINCT 
	PATIENT.PatientId, 
	ORD.OrderId, 
	DIABETES.testDate AS CertifyDate,
	DIABETES.Result,
	CASE DIABETES.Test
		WHEN 'MICROALBUMIN' THEN 3612
		WHEN 'MICROALBUMIN UA' THEN 3613
		WHEN 'MICROALBUMIN/CR RATIO' THEN 3618
		WHEN 'MICROALBUMIN 24H' THEN 3615
		WHEN 'MICROALBUMIN/CR' THEN 3614
	END AS Test
FROM PATIENT 
	INNER JOIN vwSTG_POP_HEALTH_DIABETES_MICROALBUMINS AS DIABETES 
	ON PATIENT.PatientIdentifier = DIABETES.EDIPN 
	INNER JOIN PATIENT_ENCOUNTER AS PE 
	ON PATIENT.PatientId = PE.PatientId 
	AND DIABETES.testDate = PE.AppointmentDateTime
	INNER JOIN PATIENT_ORDER AS ORD
	ON PE.PatientEncounterId = ORD.PatientEncounterId
WHERE (PE.SourceSystemId = 6) 
	AND (ISDATE(DIABETES.testDate) = 1)
	AND Result IS NOT NULL
		
OPEN cur
SET @trow = 0
SET @irow = 0
EXEC dbo.upActivityLog 'Fetch PH Diabetes Micro Results',0
FETCH NEXT FROM cur INTO @pat,@ord,@date,@res,@test

if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@patX = PatientId,
				@ordX = OrderId,
				@dateX = CertifyDate,
				@resX = Result,
				@testX = LabTestId
		FROM NHJAX_ODS.dbo.LAB_RESULT
		WHERE	OrderId = @ord
		AND		LabTestId = @test

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
				VALUES(@pat,@ord,@date,@res,@test,12);
				SET @irow = @irow + 1
			END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM cur INTO @pat,@ord,@date,@res,@test
		
	COMMIT	
	END
END

CLOSE cur
DEALLOCATE cur

SET @sirow = 'PH Diabetes Micro Results Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'PH Diabetes Micro Results Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;

EXEC dbo.upActivityLog 'End PH Diabetes Micro Results',0,@day;

