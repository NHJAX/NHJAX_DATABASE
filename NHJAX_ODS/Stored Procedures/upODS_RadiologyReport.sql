
CREATE PROCEDURE [dbo].[upODS_RadiologyReport] AS


Declare @rpt numeric(13,3)
Declare @pat bigint
Declare @date datetime
Declare @exam datetime
Declare @res bigint
Declare @txt varchar(8000)
Declare @ver datetime

Declare @rptX numeric(13,3)
Declare @patX bigint
Declare @dateX datetime
Declare @examX datetime
Declare @resX bigint
Declare @txtX varchar(8000)
Declare @verX datetime

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
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Radiology Report',0,@day;
SET @tempDate = DATEADD(d,-60,getdate());
SET @fromDate = dbo.StartOfDay(@tempDate); 

DECLARE curRpt CURSOR FAST_FORWARD FOR
SELECT	RPT.KEY_RADIOLOGY_REPORTS, 
	RPT.DATE_TIME_CREATED, 
	PAT.PatientId, 
	RPT.EXAM_DATE_TIME, 
	ISNULL(RES.ResultCategoryId, 0) AS ResultCategoryId, 
    REPLACE(RTRIM(LTRIM(CAST(REPORT_TEXT AS Varchar(8000)))), '     ', ' ') AS ReportText,
	RPT.VERIFIED_DATE
FROM    vwMDE_RADIOLOGY_REPORTS RPT 
	INNER JOIN PATIENT PAT 
	ON RPT.PATIENT_NAME_IEN = PAT.PatientKey 
	LEFT OUTER JOIN RESULT_CATEGORY RES 
	ON RPT.RESULT_CODE_IEN = RES.ResultCategoryKey
WHERE   (RPT.EXAM_DATE_TIME >= @fromDate) 

OPEN curRpt
SET @trow = 0
SET @irow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch Radiology Report',0

FETCH NEXT FROM curRpt INTO @rpt,@date,@pat,@exam,@res,@txt,@ver
if(@@FETCH_STATUS = 0)
BEGIN
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
		Select 	@dateX = CreatedDateTime,
			@patX = PatientId,
			@examX = ExamDateTime,
			@resX = ResultCategoryId,
			@txtX = ReportText,
			@verX = VerifyDate
		FROM NHJAX_ODS.dbo.RADIOLOGY_REPORT
		WHERE RadiologyReportKey = @rpt
		SET @exists = @@RowCount
		If @exists = 0 
			BEGIN
				INSERT INTO NHJAX_ODS.dbo.RADIOLOGY_REPORT(
				RadiologyReportKey,
				CreatedDateTime,
				PatientId,
				ExamDateTime,
				ResultCategoryId,
				ReportText,
				VerifyDate)
				VALUES(@rpt,@date,@pat,@exam,@res,@txt,@ver);
				SET @irow = @irow + 1
			END
		ELSE
			BEGIN
				IF	@date <> @dateX
				OR	@pat <> @patX
				OR	@exam <> @examX
				OR	@res <> @resX
				OR	@txt <> @txtX
				OR	(@date Is Not Null AND @dateX Is Null)
				OR	(@pat Is Not Null AND @patX Is Null)
				OR	(@exam Is Not Null AND @examX Is Null)
				OR	(@res Is Not Null AND @resX Is Null)
				OR	(@txt Is Not Null AND @txtX Is Null)
					BEGIN
					UPDATE NHJAX_ODS.dbo.RADIOLOGY_REPORT
					SET 	CreatedDateTime = @date,
						PatientId = @pat,
						ExamDateTime = @exam,
						ResultCategoryId = @res,
						ReportText = @txt,
						UpdatedDate = @today
					WHERE RadiologyReportKey = @rpt;
					SET @urow = @urow + 1
					END
				
				IF @ver <> @verX
				OR (@ver IS NOT NULL AND @verX IS NULL)
				BEGIN
					UPDATE NHJAX_ODS.dbo.RADIOLOGY_REPORT
					SET VerifyDate = @ver,
						UpdatedDate = GetDate()
					WHERE RadiologyReportKey = @rpt;

					SET @urow = @urow + 1
				END
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curRpt INTO @rpt,@date,@pat,@exam,@res,@txt,@ver
	COMMIT
	END
END
CLOSE curRpt
DEALLOCATE curRpt
SET @surow = 'Radiology Report Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Radiology Report Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Radiology Report Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Radiology Report',0,@day;
