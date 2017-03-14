
CREATE PROCEDURE [dbo].[upODS_Diagnosis] AS
if exists(SELECT * FROM dbo.sysobjects WHERE name = '#Temp')
BEGIN
DROP TABLE #Temp;
END

Declare @trow int
Declare @urow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @loop int
Declare @exists int

Declare @diagkey decimal
Declare @diagcode varchar(30)
Declare @diagdesc varchar(250)
Declare @relative decimal
Declare @diagname varchar(30)
Declare @type bit

Declare @diagkeyX decimal
Declare @diagcodeX varchar(30)
Declare @diagdescX varchar(250)
Declare @relativeX decimal
Declare @diagnameX varchar(30)
Declare @typeX bit
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Diagnosis',0,@day;

DECLARE curDiagnosis CURSOR FAST_FORWARD FOR
	SELECT
	KEY_DIAGNOSTIC_RELATED_GROUP AS DiagnosisKey, 
	DRG_CODE As DiagnosisCode, 
	DRG_DESCRIPTION AS DiagnosisDesc,
	RELATIVE_WEIGHT AS RelativeWeight,
	NULL AS DiagnosisName,
	1 AS DiagnosisType
	FROM vwMDE_DIAGNOSTIC_RELATED_GROUP
	
	UNION SELECT     
	KEY_ICD_DIAGNOSIS AS DiagnosisKey, 
	CODE_NUMBER AS DiagnosisCode, 
	DESCRIPTION AS DiagnosisDesc, 
	0 AS RelativeWeight, 
        	DIAGNOSIS AS DiagnosisName, 
	2 AS DiagnosisType
FROM   vwMDE_ICD_DIAGNOSIS

OPEN curDiagnosis

SET @today = getdate()

SET @urow = 0
SET @irow = 0
SET @trow = 1

FETCH NEXT FROM curDiagnosis INTO @diagkey,@diagcode,@diagdesc,@relative,@diagname,@type

if(@@FETCH_STATUS = 0)

BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
	Select @diagkeyX = DiagnosisKey, 
	@diagcodeX = DiagnosisCode, 
	@diagdescX = DiagnosisDesc,
	@relativeX = RelativeWeight,
	@diagnameX = DiagnosisName,
	@typeX = DiagnosisType
	from NHJAX_ODS.dbo.DIAGNOSIS 
	Where DiagnosisKey = @diagkey
	And DiagnosisType = @type
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.DIAGNOSIS(DiagnosisKey,
			DiagnosisCode,
			DiagnosisDesc,
			RelativeWeight,
			DiagnosisName,
			DiagnosisType) 
		VALUES(@diagkey, 
			@diagcode, 
			@diagdesc,
			@relative,
			@diagname,
			@type);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @diagcode <> @diagcodeX
		OR @diagdesc <> @diagdescX
		OR @relative <> @relativeX
		OR @diagname <> @diagnameX
		OR (@diagcode Is Not Null AND @diagcodeX Is Null)
		OR (@diagdesc Is Not Null AND @diagdescX Is Null)
		OR (@relative Is Not Null AND @relativeX Is Null)
		OR (@diagname Is Not Null AND @diagnameX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.DIAGNOSIS
			SET DiagnosisCode = @diagcode,
			DiagnosisDesc = @diagdesc,
			RelativeWeight = @relative,
			DiagnosisName = @diagname,
			UpdatedDate = @today
			WHERE DiagnosisKey = @diagkey
			AND DiagnosisType = @type;

			SET @urow = @urow + 1
			END
		END
	
		SET @trow = @trow + 1
		FETCH NEXT FROM curDiagnosis INTO @diagkey,@diagcode,@diagdesc,@relative,@diagname,@type
	COMMIT
	END
END

CLOSE curDiagnosis
DEALLOCATE curDiagnosis

SET @surow = 'Diagnosis Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Diagnosis Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Diagnosis Total: ' + CAST(@trow AS varchar(50))

EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Diagnosis',0,@day;
