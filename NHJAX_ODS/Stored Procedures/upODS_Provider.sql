

CREATE PROCEDURE [dbo].[upODS_Provider] AS
Declare @trow int
Declare @urow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @loop int
Declare @exists int

Declare @pro bigint
Declare @key_pro decimal
Declare @name varchar(30)
Declare @class bigint
Declare @code varchar(30)
Declare @ssn varchar(30)
Declare @term datetime
Declare @inac datetime
Declare @loc bigint
Declare @grade bigint
Declare @clinic bigint
Declare @dept bigint
Declare @flag bit
Declare @ph varchar(18)
Declare @pg varchar(18)
Declare @npi varchar(20) --numeric(16,3)
Declare @enet int
Declare @eloc bigint
Declare @edi varchar(30)
Declare @pcode int
Declare @mdate datetime

Declare @key_proX decimal
Declare @nameX varchar(30)
Declare @classX bigint
Declare @codeX varchar(30)
Declare @ssnX varchar(30)
Declare @termX datetime
Declare @inacX datetime
Declare @locX bigint
Declare @gradeX bigint
Declare @clinicX bigint
Declare @deptX bigint
Declare @flagX bit
Declare @phX varchar(18)
Declare @pgX varchar(18)
Declare @npiX varchar(20) --numeric(16,3)
Declare @mdateX datetime
--20091119--Add check to ENet for ENetId
Declare @enetX int 
Declare @elocX bigint
Declare @ediX varchar(30)
Declare @pcodeX int

Declare @day int

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Provider',0,@day;
DECLARE curProvider CURSOR FAST_FORWARD FOR
SELECT
	PRO.KEY_PROVIDER, 
	PRO.NAME, 
	CLS.ProviderClassId, 
	PRO.PROVIDER_ID, 
	PRO.SSN, 
	PRO.TERMINATION_DATE, 
	PRO.ORDER_ENTRY_INACTIVATION_DATE, 
        	LOC1.HospitalLocationId, 
	GRD.MilitaryGradeRankId, 
	LOC2.HospitalLocationId AS ClinicId, 
	DEPT.DepartmentId, 
	CASE PRO.PROVIDER_FLAG
		WHEN 'PROVIDER' THEN 1
		ELSE 0
	END AS PROVIDER_FLAG,
	PRO.DUTY_PHONE_1,
	PRO.PAGER_#,
	PRO.NPI_ID,
	PRO.EDI_PN
FROM vwMDE_PROVIDER PRO 
LEFT OUTER JOIN vwSTG_STG_PROVIDER_ACTIVITY PA
ON PRO.KEY_PROVIDER = PA.PROVIDER_IEN 
LEFT OUTER JOIN DEPARTMENT DEPT 
ON PRO.DEPARTMENT_ID_CODE_IEN = DEPT.DepartmentKey 
LEFT OUTER JOIN HOSPITAL_LOCATION LOC2 
ON PRO.CLINIC_ID_IEN = LOC2.HospitalLocationKey 
LEFT OUTER JOIN HOSPITAL_LOCATION LOC1 
ON PRO.LOCATION_IEN = LOC1.HospitalLocationKey 
LEFT OUTER JOIN MILITARY_GRADE_RANK GRD 
ON PRO.RANK_IEN = GRD.MilitaryGradeRankKey 
LEFT OUTER JOIN PROVIDER_CLASS CLS 
ON PRO.CLASS_IEN = CLS.ProviderClassKey
--WHERE PRO.NAME LIKE 'McQuade,J%'
	 
OPEN curProvider
SET @trow = 0
SET @irow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch Provider',0
FETCH NEXT FROM curProvider INTO @key_pro,@name,@class,@code,@ssn,@term,@inac,@loc,@grade,@clinic,@dept,
	@flag,@ph,@pg,@npi,@edi

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
	SELECT @key_proX = ProviderKey,
	@nameX = ProviderName, 
	@classX = ProviderClassId, 
	@codeX = ProviderCode, 
	@ssnX = ProviderSSN,
	@termX = TerminationDate,
	@inacX = InactivationDate, 
	@locX = LocationId, 
	@gradeX = MilitaryGradeRankId, 
	@clinicX = ClinicId, 
	@deptX = DepartmentId, 
    @flagX = ProviderFlag,
	@phX = DutyPhone,
	@pgX = PagerNumber,
	@npiX = NPIKey,
	@enetX = ENetId,
	@elocX = ENetLocationId,
	@ediX = DoDEDI
	from NHJAX_ODS.dbo.PROVIDER 
	Where ProviderKey = @key_pro
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.PROVIDER(ProviderKey,
			ProviderName,
			ProviderClassId, 
			ProviderCode, 
			ProviderSSN,
			TerminationDate,
			InactivationDate, 
			LocationId,
			MilitaryGradeRankId,
			ClinicId,
			DepartmentId,
			ProviderFlag,
			DutyPhone,
			PagerNumber,
			NPIKey,
			DoDEDI) 
		VALUES(@key_pro,
			@name, 
			@class, 
			@code,
			@ssn,
			@term,
			@inac,
			@loc,
			@grade,
			@clinic,
			@dept,
			@flag,
			@ph,
			@pg,
			@npi,
			@edi);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @name <> @nameX
		OR @class <> @classX
		OR @code <> @codeX
		OR @ssn <> @ssnX
		OR @term <> @termX
		OR @inac <> @inacX
		OR @loc <> @locX
		OR @grade <> @gradeX
		OR @clinic <> @clinicX
		OR @dept <> @deptX
		OR @flag <> @flagX
		OR @ph <> @phX
		OR @pg <> @pgX
		OR (@name Is Not Null AND @nameX Is Null)
		OR (@class Is Not Null AND @classX Is Null)
		OR (@code Is Not Null AND @codeX Is Null)
		OR (@ssn Is Not Null AND @ssnX Is Null)
		OR (@term Is Not Null AND @termX Is Null)
		OR (@inac Is Not Null AND @inacX Is Null)
		OR (@loc Is Not Null AND @locX Is Null)
		OR (@grade Is Not Null AND @gradeX Is Null)
		OR (@clinic Is Not Null AND @clinicX Is Null)
		OR (@dept Is Not Null AND @deptX Is Null)
		OR (@flag Is Not Null AND @flagX Is Null)
		OR (@ph Is Not Null AND @phX Is Null)
		OR (@pg Is Not Null AND @pgX Is Null)
			BEGIN
			SET @today = getdate()
			UPDATE NHJAX_ODS.dbo.PROVIDER
			SET ProviderName = @name,
			ProviderClassId = @class,
			ProviderCode = @code,
			ProviderSSN = @ssn,
			TerminationDate =@term,
			InactivationDate = @inac,
			LocationId = @loc,
			MilitaryGradeRankId = @grade,
			ClinicId = @clinic,
			DepartmentId = @dept,
			ProviderFlag = @flag,
			DutyPhone = @ph,
			PagerNumber = @pg,
			UpdatedDate = @today
			WHERE ProviderKey = @key_pro;
			SET @urow = @urow + 1
			END
			IF @npi <> @npiX
			OR (@npi Is Not Null AND @npiX Is Null)
			BEGIN
				UPDATE NHJAX_ODS.dbo.PROVIDER
				SET NPIKey = @npi,
				UpdatedDate = GETDATE()
				WHERE ProviderKey = @key_pro
				SET @urow = @urow + 1
			END
			IF @edi <> @ediX
			OR (@edi Is Not Null AND @ediX Is Null)
			BEGIN
				UPDATE NHJAX_ODS.dbo.PROVIDER
				SET DoDEDI = @edi,
				UpdatedDate = GETDATE()
				WHERE ProviderKey = @key_pro
				SET @urow = @urow + 1
			END
		END
		SET @trow = @trow + 1
						
		--20091119--Add check to ENet for ENetId
		SET @enet = 0
		SET @eloc = 0
		IF @enetX < 1
		BEGIN
			SELECT @enet = UserId
			FROM [NHJAX-SQL-1A].ENET.dbo.TECHNICIAN
			WHERE SSN = @ssn
			
			IF @enet > 0
			BEGIN
			UPDATE PROVIDER
			SET ENetId = @enet
			WHERE ProviderSSN = @ssn
			END
		END
		
		BEGIN
			SELECT @eloc = AudienceId
			FROM [NHJAX-SQL-1A].ENET.dbo.TECHNICIAN
			WHERE SSN = @ssn
			
			IF @eloc > 0
			BEGIN
			UPDATE PROVIDER
			SET ENetLocationId = @eloc
			WHERE ProviderSSN = @ssn
			END
		END
		
		FETCH NEXT FROM curProvider INTO @key_pro,@name,@class,@code,@ssn,@term,@inac,
		@loc,@grade,@clinic,@dept,@flag,@ph,@pg,@npi,@edi
	COMMIT
	END

END
CLOSE curProvider
DEALLOCATE curProvider



SET @trow = @trow - 1
SET @surow = 'Provider Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Provider Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Provider Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Provider',0,@day;

--Add-on for NDI Eligibility 2014-10-15
--KSK

EXEC dbo.upActivityLog 'Begin NDI Provider',0,@day;
DECLARE curNDIProvider CURSOR FAST_FORWARD FOR
SELECT   DISTINCT   
NDI.PCM_ID, 
PCM_NAME, 
CASE PCM_CODE
	WHEN 'DIRECT CARE' THEN 1
	WHEN 'CIVILIAN' THEN 2
END AS PCMCode,
MNDI.MaxDate
FROM  vwMDE_NDI_ELIGIBILITY AS NDI
	INNER JOIN DMIS
	ON NDI.PCM_DMIS_IEN = DMIS.DMISKey
	INNER JOIN vwMDE_NDI_ELIGIBILITY_MaxResponse AS MNDI
	ON NDI.PCM_ID = MNDI.PCM_ID
	AND NDI.DATE_TIME_OF_RESPONSE = MNDI.MaxDate
--WHERE PCM_NAME LIKE 'McQuade,J%'
	 
OPEN curNDIProvider
SET @trow = 0
SET @irow = 0
SET @urow = 0

EXEC dbo.upActivityLog 'Fetch NDI Provider',0
FETCH NEXT FROM curNDIProvider INTO @npi,@name,@pcode,@mdate

if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		BEGIN TRANSACTION

		SELECT @npiX = NPIKey,
			@nameX = ProviderName, 
			@pcodeX = PCMCodeId,
			@mdateX = UpdatedDate
		FROM NHJAX_ODS.dbo.PROVIDER 
		WHERE NPIKey = @npi
		OR NPIKey = @npi + '.000'
		SET @exists = @@RowCount
		IF @exists = 0
		BEGIN
			INSERT INTO NHJAX_ODS.dbo.PROVIDER(ProviderKey,
				ProviderName,
				NPIKey, 
				PCMCodeId,
				SourceSystemId) 
			VALUES(-2,
				@name, 
				@npi,
				@pcode,
				15);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
			IF @mdate > @mdateX
			BEGIN
				IF @name <> @nameX
				BEGIN
					UPDATE PROVIDER
					SET ProviderName = @name
					WHERE NPIKey = @npi
				END 
				IF @pcode <> @pcodeX
				BEGIN
					UPDATE PROVIDER
					SET PCMCodeId = @pcode
					WHERE NPIKey = @npi
				END 
			END
		END
		SET @trow = @trow + 1

		FETCH NEXT FROM curNDIProvider INTO @npi,@name,@pcode,@mdate
	COMMIT
	END

END
CLOSE curNDIProvider
DEALLOCATE curNDIProvider

SET @trow = @trow - 1
SET @surow = 'NDI Provider Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'NDI Provider Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'NDI Provider Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End NDI Provider',0,@day;