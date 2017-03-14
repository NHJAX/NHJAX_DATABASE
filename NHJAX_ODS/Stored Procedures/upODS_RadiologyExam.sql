
CREATE PROCEDURE [dbo].[upODS_RadiologyExam] AS

Declare @key numeric(15,3)
Declare @date datetime
Declare @status bigint
Declare @num varchar(8)
Declare @rad bigint
Declare @ord bigint
Declare @ordkey numeric(21,3)
Declare @pat bigint
Declare @loc bigint
Declare @pro bigint
Declare @unit money
Declare @tot numeric(9,3)
Declare @bar bit
Declare @ic bit
Declare @adate datetime
Declare @ddate varchar(16)
Declare @sdate varchar(16)
Declare @edate varchar(16)
Declare @port varchar(16)
Declare @mob varchar(30)
Declare @img bigint
Declare @tech bigint

Declare @keyX numeric(15,3)
Declare @dateX datetime
Declare @statusX bigint
Declare @numX varchar(8)
Declare @radX bigint
Declare @ordX bigint
Declare @ordkeyX numeric(21,3)
Declare @patX bigint
Declare @locX bigint
Declare @proX bigint
Declare @totX numeric(9,3)
Declare @barX bit
Declare @icX bit
Declare @adateX datetime
Declare @ddateX varchar(16)
Declare @sdateX varchar(16)
Declare @edateX varchar(16)
Declare @portX varchar(16)
Declare @mobX varchar(30)
Declare @imgX bigint
Declare @techX bigint

Declare @urow int
Declare @trow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @fromDate datetime
Declare @tempDate datetime
Declare @today datetime
Declare @exists int
Declare @unitX money
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Radiology Exam',0,@day;

SET @tempDate = DATEADD(d,-30,getdate()); --Default 30
SET @fromDate = dbo.StartOfDay(@tempDate); 

DECLARE	curRadExam CURSOR FAST_FORWARD FOR 
SELECT DISTINCT 
	dbo.vwMDE_RADIOLOGY_EXAM.KEY_RADIOLOGY_EXAM, 
	dbo.vwMDE_RADIOLOGY_EXAM.EXAM_DATE_TIME, 
	ISNULL(EXAM_STATUS.ExamStatusId, 0) AS Expr1, 
	dbo.vwMDE_RADIOLOGY_EXAM.EXAM_NO_, 
    RAD.RadiologyId, 
	dbo.vwMDE_RADIOLOGY_EXAM.ORDER_IEN_IEN, 
	ISNULL(ORD.OrderId, 0) AS OrderId, 
	ISNULL(PAT.PatientId, 0) AS PatientId, 
	HOSP.HospitalLocationId, 
    PRO.ProviderId,
	ISNULL(RAD.UnitCost,0),
	dbo.vwMDE_RADIOLOGY_EXAM.TOTAL_EXPOSURES,
	CASE dbo.vwMDE_RADIOLOGY_EXAM.WAS_BARIUM_USED_
		WHEN 'YES' THEN 1
		ELSE 0
	END,
	CASE dbo.vwMDE_RADIOLOGY_EXAM.INTRAVASCULAR_CONTRAST
		WHEN 'YES' THEN 1
		ELSE 0
	END,
	dbo.vwMDE_RADIOLOGY_EXAM.ARRIVAL_DATE_TIME,
	dbo.vwMDE_RADIOLOGY_EXAM.DEPARTURE_DATE_TIME,
	dbo.vwMDE_RADIOLOGY_EXAM.PORTABLE,
	dbo.vwMDE_RADIOLOGY_EXAM.PROCEDURE_START_DATE_TIME,
	dbo.vwMDE_RADIOLOGY_EXAM.PROCEDURE_STOP_DATE_TIME,
	dbo.vwMDE_RADIOLOGY_EXAM.PATIENT_MOBILITY_STATUS,
	ISNULL(IMG.ImagingTypeId,0),
	ISNULL(TECH.ProviderId,0)
FROM RADIOLOGY RAD 
	INNER JOIN dbo.vwMDE_RADIOLOGY_EXAM  
	ON RAD.RadiologyKey = dbo.vwMDE_RADIOLOGY_EXAM.PROCEDURE_IEN 
	INNER JOIN HOSPITAL_LOCATION HOSP 
	ON dbo.vwMDE_RADIOLOGY_EXAM.REQ__WARD_CLINIC_IEN = HOSP.HospitalLocationKey 
	INNER JOIN PROVIDER PRO 
	ON dbo.vwMDE_RADIOLOGY_EXAM.REQUESTING_HCP_IEN = PRO.ProviderKey 
	LEFT OUTER JOIN PATIENT_ORDER ORD 
	ON dbo.vwMDE_RADIOLOGY_EXAM.ORDER_IEN_IEN = ORD.OrderKey 
	LEFT OUTER JOIN PATIENT PAT 
	ON dbo.vwMDE_RADIOLOGY_EXAM.NAME_IEN = PAT.PatientKey 
	LEFT OUTER JOIN EXAM_STATUS 
	ON dbo.vwMDE_RADIOLOGY_EXAM.EXAM_STATUS_IEN = EXAM_STATUS.ExamStatusKey
	LEFT OUTER JOIN IMAGING_TYPE AS IMG
	ON dbo.vwMDE_RADIOLOGY_EXAM.IMAGING_TYPE_IEN = IMG.ImagingTypeKey
	LEFT OUTER JOIN PROVIDER TECH 
	ON dbo.vwMDE_RADIOLOGY_EXAM.PERFORMING_TECHNICIAN_IEN = TECH.ProviderKey 
WHERE   (dbo.vwMDE_RADIOLOGY_EXAM.EXAM_DATE_TIME >= @fromDate)

OPEN curRadExam
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Radiology Exam',0

FETCH NEXT FROM curRadExam INTO @key,@date,@status,@num,@rad,@ordkey,
	@ord,@pat,@loc,@pro,@unit,@tot,@bar,@ic,@adate,@ddate,@port,@sdate,@edate,
	@mob,@img,@tech

if(@@FETCH_STATUS = 0)

BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@keyX = RadiologyExamKey,
			@dateX = ExamDateTime,
			@statusX = ExamStatusId,
			@numX = ExamNumber,
			@radX = RadiologyId,
			@ordX = OrderId,
			@ordkeyX = OrderKey,
			@patX = PatientId,
			@locX = HospitalLocationId,
			@proX = ProviderId,
			@unitX = UnitCost,
			@totX = TotalExposures,
			@barX = WasBariumUsed,
			@icX = IntravascularContrast,
			@adateX = ArrivalDateTime,
			@ddateX = DepartureDateTime,
			@portX = Portable,
			@sdateX = StartDateTime,
			@edateX = EndDateTime,
			@mobX = PatientMobilityStatus,
			@imgX = ImagingTypeId,
			@techX = PerformingTechnicianId
		FROM NHJAX_ODS.dbo.RADIOLOGY_EXAM
		WHERE RadiologyExamKey = @key
		
		SET @exists = @@RowCount
		
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.RADIOLOGY_EXAM(
				RadiologyExamKey,
				ExamDateTime,
				ExamStatusId,
				ExamNumber,
				RadiologyId,
				OrderId,
				OrderKey,
				PatientId,
				HospitalLocationId,
				ProviderId,
				UnitCost,
				TotalExposures,
				WasBariumUsed,
				IntravascularContrast,
				ArrivalDateTime,
				DepartureDateTime,
				Portable,
				StartDateTime,
				EndDateTime,
				PatientMobilityStatus,
				ImagingTypeId,
				PerformingTechnicianId)
				VALUES(@key,@date,@status,@num,@rad,@ord,@ordkey,@pat,
					@loc,@pro,@unit,@tot,@bar,@ic,@adate,@ddate,@port,@sdate,
					@edate,@mob,@img,@tech);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
		IF	@date <> @dateX
		OR	@status <> @statusX
		OR	@num <> @numX
		OR	@rad <> @radX
		OR	@ord <> @ordX
		OR	@ordkey <> @ordkeyX
		OR	@pat <> @patX
		OR	@loc <> @locX
		OR	@pro <> @proX
		OR	@unit <> @unitX
		OR 	(@date Is Not Null AND @dateX Is Null)
		OR 	(@status Is Not Null AND @statusX Is Null)
		OR 	(@num Is Not Null AND @numX Is Null)
		OR	(@rad Is Not Null AND @radX Is Null)
		OR	(@ord Is Not Null AND @ordX Is Null)
		OR	(@ordkey Is Not Null AND @ordkeyX Is Null)
		OR	(@pat Is Not Null AND @patX Is Null)
		OR	(@loc Is Not Null AND @locX Is Null)
		OR	(@pro Is Not Null AND @proX Is Null)
		OR	(@unit Is Not Null AND @unitX Is Null)
		
			BEGIN
			SET @today = getdate()
			UPDATE NHJAX_ODS.dbo.RADIOLOGY_EXAM
			SET 	ExamDateTime = @date,
				ExamStatusId = @status,
				ExamNumber = @num,
				RadiologyId = @rad,
				OrderId = @ord,
				OrderKey = @ordkey,
				PatientId = @pat,
				HospitalLocationId = @loc,
				ProviderId = @pro,
				UnitCost = @unit,
				UpdatedDate = @today
			WHERE RadiologyExamKey = @key;

			SET @urow = @urow + 1
			END
		END
		
		IF @tot <> @totX
			OR (@tot Is Not Null AND @totX Is Null)
			BEGIN
				UPDATE RADIOLOGY_EXAM
				SET TotalExposures = @tot,
					UpdatedDate = GETDATE()
				WHERE RadiologyExamKey = @key;
			END
			
		IF @bar <> @barX
			OR (@bar Is Not Null AND @barX Is Null)
			BEGIN
				UPDATE RADIOLOGY_EXAM
				SET WasBariumUsed = @bar,
					UpdatedDate = GETDATE()
				WHERE RadiologyExamKey = @key;
			END
			
		IF @ic <> @icX
			OR (@ic Is Not Null AND @icX Is Null)
			BEGIN
				UPDATE RADIOLOGY_EXAM
				SET IntravascularContrast = @ic,
					UpdatedDate = GETDATE()
				WHERE RadiologyExamKey = @key;
			END
			
		IF @adate <> @adateX
			OR (@adate Is Not Null AND @adateX Is Null)
			BEGIN
				UPDATE RADIOLOGY_EXAM
				SET ArrivalDateTime = @adate,
					UpdatedDate = GETDATE()
				WHERE RadiologyExamKey = @key;
			END
			
		IF	@ddate <> @ddateX
			OR	(@ddate Is Not Null AND @ddateX Is Null)
			BEGIN
				UPDATE RADIOLOGY_EXAM
				SET DepartureDateTime = @ddate,
					UpdatedDate = GETDATE()
				WHERE RadiologyExamKey = @key;
			END
			
		IF	@port <> @portX
			OR	(@port Is Not Null AND @portX Is Null)
			BEGIN
				UPDATE RADIOLOGY_EXAM
				SET Portable = @port,
					UpdatedDate = GETDATE()
				WHERE RadiologyExamKey = @key;
			END
			
		IF	@sdate <> @sdateX
			OR	(@sdate Is Not Null AND @sdateX Is Null)
			BEGIN
				UPDATE RADIOLOGY_EXAM
				SET StartDateTime = @ddate,
					UpdatedDate = GETDATE()
				WHERE RadiologyExamKey = @key;
			END
		
		IF	@edate <> @edateX
			OR	(@edate Is Not Null AND @edateX Is Null)
			BEGIN
				UPDATE RADIOLOGY_EXAM
				SET EndDateTime = @edate,
					UpdatedDate = GETDATE()
				WHERE RadiologyExamKey = @key;
			END
			
		IF	@mob <> @mobX
			OR	(@mob Is Not Null AND @mobX Is Null)
			BEGIN
				UPDATE RADIOLOGY_EXAM
				SET PatientMobilityStatus = @mob,
					UpdatedDate = GETDATE()
				WHERE RadiologyExamKey = @key;
			END	
			
		IF	@img <> @imgX
			OR	(@img Is Not Null AND @imgX Is Null)
			BEGIN
				UPDATE RADIOLOGY_EXAM
				SET ImagingTypeId = @img,
					UpdatedDate = GETDATE()
				WHERE RadiologyExamKey = @key;
			END
			
		IF	@tech <> @techX
			OR	(@tech Is Not Null AND @techX Is Null)
			BEGIN
				UPDATE RADIOLOGY_EXAM
				SET PerformingTechnicianId = @tech,
					UpdatedDate = GETDATE()
				WHERE RadiologyExamKey = @key;
			END		
		
		SET @trow = @trow + 1
		FETCH NEXT FROM curRadExam INTO @key,@date,@status,@num,@rad,
			@ordkey,@ord,@pat,@loc,@pro,@unit,@tot,@bar,@ic,@adate,@ddate,
			@port,@sdate,@edate,@mob,@img,@tech
		
	COMMIT
	END
END

CLOSE curRadExam
DEALLOCATE curRadExam

SET @surow = 'Radiology Exam Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Radiology Exam Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Radiology Exam Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Radiology Exam',0,@day;
