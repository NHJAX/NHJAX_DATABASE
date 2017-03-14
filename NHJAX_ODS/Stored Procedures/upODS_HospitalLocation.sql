
CREATE PROCEDURE [dbo].[upODS_HospitalLocation] AS
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
Declare @lockey numeric(12,4)
Declare @locname varchar(30)
Declare @desc varchar(31)
Declare @meprs bigint
Declare @div bigint
Declare @lockeyX numeric(12,4)
Declare @locnameX varchar(30)
Declare @descX varchar(31)
Declare @meprsX bigint
Declare @divX bigint
Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Hosp Loc',0,@day;
Select Identity(int,1,1) ID,
	H.KEY_HOSPITAL_LOCATION, 
	H.NAME, 
	H.DESCRIPTION,
	ISNULL(M.MeprsCodeId,0) AS MeprsCodeId,
	ISNULL(DIV.MedicalCenterDivisionId,0) AS MedicalCenterDivisionId
	into #Temp 
	FROM MEPRS_CODE M 
	RIGHT OUTER JOIN vwMDE_HOSPITAL_LOCATION H 
	ON M.MeprsCodeKey = H.MEPRS_CODE_IEN
	INNER JOIN MEDICAL_CENTER_DIVISION AS DIV 
	ON H.DIVISION_IEN = DIV.MedicalCenterDivisionKey
SET @loop = @@rowcount
SET @today = getdate()
SET @urow = 0
SET @irow = 0
SET @trow = 1
While @trow <= @loop
BEGIN
BEGIN TRANSACTION
	
	Select @lockey = KEY_HOSPITAL_LOCATION, 
	@locname = NAME, 
	@desc = DESCRIPTION,
	@meprs = MeprsCodeId,
	@div = MedicalCenterDivisionId
	from #Temp 
	Where ID = @trow
		
	Select @lockeyX = HospitalLocationKey, 
	@locnameX = HospitalLocationName, 
	@descX = HospitalLocationDesc,
	@meprsX = MeprsCodeId,
	@divX = MedicalCenterDivisionId
	from NHJAX_ODS.dbo.HOSPITAL_LOCATION 
	Where HospitalLocationKey = @lockey
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.HOSPITAL_LOCATION(HospitalLocationKey,
			HospitalLocationName, 
			HospitalLocationDesc,
			MeprsCodeId,
			MedicalCenterDivisionId) 
		VALUES(@lockey, 
			@locname, 
			@desc,
			@meprs,
			@div);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @locname <> @locnameX
		OR @desc <> @descX
		OR @meprs <> @meprsX
		OR @div <> @divX
		OR (@locname Is Not Null AND @locnameX Is Null)
		OR (@desc Is Not Null AND @descX Is Null)
		OR (@meprs Is Not Null AND @meprsX Is Null)
		OR (@div Is Not Null AND @divX Is Null)
			BEGIN
			UPDATE NHJAX_ODS.dbo.HOSPITAL_LOCATION
			SET HospitalLocationName = @locname,
			HospitalLocationDesc = @desc,
			MeprsCodeId = @meprs,
			MedicalCenterDivisionId = @div,
			UpdatedDate = @today
			WHERE HospitalLocationKey = @lockey;
			SET @urow = @urow + 1
			END
		END
	
	SET @trow = @trow + 1
COMMIT
END
SET @trow = @trow - 1
SET @surow = 'Hosp Loc Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Hosp Loc Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Hosp Loc Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Hosp Loc',0,@day;
Drop table #Temp
