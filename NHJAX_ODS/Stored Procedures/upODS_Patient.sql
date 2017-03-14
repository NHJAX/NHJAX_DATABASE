

CREATE PROCEDURE [dbo].[upODS_Patient]
AS
Declare @trow int
Declare @urow int
Declare @irow int
Declare @surow varchar(50)
Declare @sirow varchar(50)
Declare @strow varchar(50)
Declare @today datetime
Declare @loop int
Declare @exists int

Declare @pat bigint
Declare @key_pat decimal
Declare @ned decimal
Declare @name varchar(32)
Declare @sex varchar(30)
Declare @dob datetime
Declare @age varchar(15)
Declare @ssn varchar(30)
Declare @pseudo int
Declare @add1 varchar(38)
Declare @add2 varchar(36)
Declare @add3 varchar(30)
Declare @city varchar(30)
Declare @state bigint
Declare @zip varchar(10)
Declare @phone varchar(25)
Declare @ophone varchar(19)
Declare @branch bigint
Declare @spssn varchar(15)
Declare @fmp bigint
Declare @grade bigint
Declare @DeersEgEndDt varchar(30)
Declare @acv bigint
Declare @dmis bigint
Declare @pcm bigint
Declare @race bigint
Declare @mar bigint
Declare @page int
Declare @nedlast varchar(30)
Declare @nedfirst varchar(30)
Declare @nedmid varchar(25)
Declare @pcat bigint
Declare @pcov bigint
Declare @reg bit
Declare @ben bigint
DECLARE @phc varchar(62)
Declare @ndi int
Declare @hcdp int
Declare @id varchar(50)
Declare @uic bigint
Declare @loc varchar(64)
Declare @isnum bit
Declare @regt bigint
Declare @ad tinyint
Declare @neddmis bigint

Declare @patX bigint
Declare @key_patX decimal
Declare @nedX decimal
Declare @nameX varchar(32)
Declare @sexX varchar(30)
Declare @dobX datetime
Declare @ageX varchar(15)
Declare @ssnX varchar(30)
Declare @pseudoX int
Declare @add1X varchar(38)
Declare @add2X varchar(36)
Declare @add3X varchar(30)
Declare @cityX varchar(30)
Declare @stateX bigint
Declare @zipX varchar(10)
Declare @phoneX varchar(25)
Declare @ophoneX varchar(19)
Declare @branchX bigint
Declare @spssnX varchar(15)
Declare @fmpX bigint
Declare @gradeX bigint
Declare @DeersEgEndDtX varchar(30)
Declare @acvX bigint
Declare @dmisX bigint
Declare @pcmX bigint
Declare @raceX bigint
Declare @marX bigint
Declare @pageX int
Declare @nedlastX varchar(30)
Declare @nedfirstX varchar(30)
Declare @nedmidX varchar(25)
Declare @pcatX bigint
Declare @pcovX bigint
Declare @regX bit
Declare @benX bigint
Declare @phcX varchar(62)
Declare @ndiX int
Declare @hcdpX int
Declare @idX varchar(50)
Declare @uicX bigint
Declare @locX bigint
Declare @day int
Declare @regtX bigint
Declare @adX tinyint
Declare @neddmisX bigint

SELECT @day = ActivityCount 
FROM ACTIVITY_COUNT 
WHERE ActivityCountId = 0

EXEC dbo.upActivityLog 'Begin Patient',0,@day;
DECLARE curPatient CURSOR FAST_FORWARD FOR
SELECT	vwMDE_PATIENT.KEY_PATIENT, 
	NP.KEY_NED_PATIENT, 
	vwMDE_PATIENT.NAME, 
	vwMDE_PATIENT.SEX, 
	vwMDE_PATIENT.DOB, 
	vwMDE_PATIENT.DISPLAY_AGE, 
	vwMDE_PATIENT.SSN, 
	ISNULL(PSEUDO.PseudoPatientId, 0) AS PseudoPatientId, 
	vwMDE_PATIENT.STREET_ADDRESS, 
	vwMDE_PATIENT.STREET_ADDRESS_2, 
	vwMDE_PATIENT.STREET_ADDRESS_3, 
	vwMDE_PATIENT.CITY, 
	GEO.GeographicLocationId, 
	vwMDE_PATIENT.ZIP_CODE, 
	vwMDE_PATIENT.PHONE, 
	vwMDE_PATIENT.OFFICE_PHONE, 
	BOS.BranchofServiceId, 
	vwMDE_PATIENT.SPONSOR_SSN, 
	FMP.FamilyMemberPrefixId, 
	MIL.MilitaryGradeRankId, 
	vwMDE_PATIENT.DEERS_ELIGIBILITY_END_DATE, 
	ACV.AlternateCareValueId, 
	DMIS.DMISId, 
	PRO.ProviderId, 
	ISNULL(RACE.RaceId, 4) AS RaceId, 
	ISNULL(MAR.MaritalStatusId, 7) AS MaritalStatusId, 
	vwMDE_PATIENT.AGE, 
	vwMDE_PATIENT.NED_PATIENT_LAST_NAME, 
	vwMDE_PATIENT.NED_PATIENT_FIRST_NAME, 
	vwMDE_PATIENT.NED_PATIENT_MIDDLE_NAME, 
	ISNULL(PC.PatientCategoryId, 0) AS PatientCategoryId, 
	ISNULL(PCO.PatientCoverageId, 0) AS PatientCoverageId, 
	CASE ISNULL(vwMDE_PATIENT.REGISTRATION_INCOMPLETE, '0') 
		WHEN '0' 
			THEN 0 
		ELSE 
		CASE vwMDE_PATIENT.REGISTRATION_INCOMPLETE
			WHEN 'REGISTRATION IS COMPLETE'
				THEN 0
			ELSE 1
		END 
	END AS RegistrationComplete, 
	IsNull(BENEFITS_CATEGORY.BenefitsCategoryId,0) As BenefitsCategoryId,
	IsNull(PHP.PHARMACY_COMMENT, '') AS PharmacyComment,
	CASE NDI.ELIGIBILITY_INDICATOR
		WHEN 'N' THEN 0
		WHEN 'Y' THEN 1
		ELSE -1
	END AS NDIEligibility,
	ISNULL(HCDP.HCDPCoverageId,0) AS HCDPCoverageId,
	vwMDE_PATIENT.PATIENT_IDENTIFIER,
	UIC.UICId,
	vwMDE_PATIENT.OUTPATIENT_RECORD_LOCATION_IEN,
	ISNULL(RTYP.RegistrationTypeId, 0) AS RegistrationTypeId,
	CASE vwMDE_PATIENT.ACTIVE_DUTY
		WHEN 'NO' THEN 0
		WHEN 'YES' THEN 1
		ELSE 2
	END AS ActiveDuty,
	ISNULL(DMIS2.DMISId,2011)
FROM   vwMDE_NED_PATIENT NP 
	LEFT OUTER JOIN PATIENT_COVERAGE PCO 
	RIGHT OUTER JOIN vwSTG_STG_PATIENT_PROVIDER PP 
	INNER JOIN PROVIDER PRO 
	ON PP.PCM_IEN = PRO.ProviderKey 
	LEFT OUTER JOIN BENEFITS_CATEGORY 
	ON PP.BENEFICIARY_CATEGORY_IEN = BENEFITS_CATEGORY.BenefitsCategoryKey 
	ON PCO.PatientCoverageKey = PP.HCDP_CONTRACTOR_COVERAGE_CODE_IEN 
	ON NP.KEY_NED_PATIENT = PP.KEY_NED_PATIENT 
	RIGHT OUTER JOIN PSEUDO_PATIENT PSEUDO 
	RIGHT OUTER JOIN vwMDE_PATIENT 
	LEFT OUTER JOIN ALTERNATE_CARE_VALUE ACV 
	ON vwMDE_PATIENT.ACV_IEN = ACV.AlternateCareValueKey 
	LEFT OUTER JOIN BRANCH_OF_SERVICE BOS 
	ON vwMDE_PATIENT.BRANCH_OF_SERVICE_LAST_IEN = BOS.BranchofServiceKey 
	LEFT OUTER JOIN RACE 
	ON vwMDE_PATIENT.RACE_IEN = RACE.RaceKey 
	LEFT OUTER JOIN MARITAL_STATUS MAR 
	ON vwMDE_PATIENT.MARITAL_STATUS_IEN = MAR.MaritalStatusKey 
	LEFT OUTER JOIN DMIS 
	ON vwMDE_PATIENT.DMIS_ID_IEN = DMIS.DMISKey 
	LEFT OUTER JOIN FAMILY_MEMBER_PREFIX FMP 
	ON vwMDE_PATIENT.FMP_IEN = FMP.FamilyMemberPrefixKey 
	LEFT OUTER JOIN GEOGRAPHIC_LOCATION GEO 
	ON vwMDE_PATIENT.STATE_IEN = GEO.GeographicLocationKey 
	INNER JOIN vwSTG_STG_PATIENT_ACTIVITY PA
	ON vwMDE_PATIENT.KEY_PATIENT = PA.PATIENT_IEN 
	LEFT OUTER JOIN PATIENT_CATEGORY PC 
	ON vwMDE_PATIENT.PATIENT_CATEGORY_IEN = PC.PatientCategoryKey 
	ON PSEUDO.PseudoPatientDesc = vwMDE_PATIENT.PSEUDO_PATIENT 
	LEFT OUTER JOIN MILITARY_GRADE_RANK MIL 
	ON vwMDE_PATIENT.MILITARY_GRADE_RANK_IEN = MIL.MilitaryGradeRankKey 
	ON NP.PATIENT_NAME_IEN = vwMDE_PATIENT.KEY_PATIENT
	LEFT OUTER JOIN vwMDE_PHARMACY_PATIENT PHP
	ON vwMDE_PATIENT.KEY_PATIENT = PHP.NAME_IEN
	LEFT OUTER JOIN vwMDE_NDI_ELIGIBILITY AS NDI
	ON vwMDE_PATIENT.KEY_PATIENT = NDI.PATIENT_NAME_IEN
	LEFT OUTER JOIN HCDP_COVERAGE AS HCDP
	ON PP.HCDP_CONTRACTOR_COVERAGE_CODE_IEN = HCDP.HCDPCoverageKey
	LEFT OUTER JOIN UIC
	ON vwMDE_PATIENT.UNIT_SHIP_ID_IEN = UIC.UICKey
	LEFT OUTER JOIN REGISTRATION_TYPE AS RTYP
	ON vwMDE_PATIENT.REGISTRATION_TYPE = RTYP.RegistrationTypeDesc
	LEFT OUTER JOIN vwMDE_NED_PATIENT$ENROLLMENT_HISTORY AS NEDE
	ON vwMDE_PATIENT.KEY_PATIENT = NEDE.KEY_NED_PATIENT
	LEFT OUTER JOIN DMIS AS DMIS2
	ON NEDE.DMIS_ID_IEN = DMIS2.DMISKey
OPEN curPatient
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Patient',0
FETCH NEXT FROM curPatient INTO @key_pat,@ned,@name,@sex,@dob,@age,@ssn,@pseudo,
	@add1,@add2,@add3,@city,@state,@zip,@phone,@ophone,@branch,@spssn,
	@fmp,@grade,@DeersEgEndDt,@acv,@dmis,@pcm,@race,@mar,@page,@nedlast,
	@nedfirst,@nedmid,@pcat,@pcov,@reg,@ben,@phc,@ndi,@hcdp,@id,@uic,@loc,
	@regt,@ad,@neddmis
if(@@FETCH_STATUS = 0)
BEGIN

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
	BEGIN TRANSACTION
	Select @key_patX = PatientKey,
	@nedX = NedPatientIEN, 
	@nameX = FullName, 
	@sexX = Sex, 
	@dobX = DOB,
	@ageX = DisplayAge,
	@ssnX = SSN, 
	@pseudoX = PseudoPatientId, 
	@add1X = StreetAddress1, 
	@add2X = StreetAddress2, 
	@add3X = StreetAddress3, 
    @cityX = City, 
	@stateX = StateId,
	@zipX = ZipCode, 
	@phoneX = Phone, 
	@ophoneX = OfficePhone,
	@branchX = LastBranchofServiceId, 
	@spssnX = SponsorSSN,
	@fmpX = FamilyMemberPrefixId,
	@gradeX = MilitaryGradeRankId, 
	@DeersEgEndDtX = DeersEligibilityEndDate, 
	@acvX = AlternateCareValueId, 
	@dmisX = DMISId,
	@pcmX = CurrentPCMId,
	@raceX = RaceId,
	@marX = MaritalStatusId,
	@pageX = PatientAge,
	@nedlastX = NedLName,
	@nedfirstX = NedFName,
	@nedmidX = NedMName,
	@pcatX = PatientCategoryId,
	@pcovX = PatientCoverageId,
	@regX = RegistrationIncomplete,
	@benX = BenefitsCategoryId,
	@phcX = PharmacyComment,
	@ndiX = NDIEligibility,
	@hcdpX = HCDPCoverageId,
	@idX = PatientIdentifier,
	@uicX = UICId,
	@regtX = RegistrationTypeId,
	@adX = ActiveDuty,
	@neddmisX = NEDPatientDMISId
	from NHJAX_ODS.dbo.PATIENT 
	Where PatientKey = @key_pat
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
		INSERT INTO NHJAX_ODS.dbo.PATIENT(PatientKey,
			NedPatientIEN,
			FullName, 
			Sex, 
			DOB,
			DisplayAge,
			SSN, 
			PseudoPatientId,
			StreetAddress1,
			StreetAddress2,
			StreetAddress3,
			City,
			StateId,
			ZipCode,
			Phone,
			OfficePhone,
			LastBranchofServiceid,
			SponsorSSN,
			FamilyMemberPrefixId,
			MilitaryGradeRankId,
			DeersEligibilityEndDate,
			AlternateCareValueId,
			DMISId,
			CurrentPCMId,
			RaceId,
			MaritalStatusId,
			PatientAge,
			NedLName,
			NedFName,
			NedMName,
			PatientCategoryId,
			PatientCoverageId,
			RegistrationIncomplete,
			BenefitsCategoryId,
			PharmacyComment,
			NDIEligibility,
			HCDPCoverageId,
			SourceSystemKey,
			PatientIdentifier,
			UICId,
			RegistrationTypeId,
			ActiveDuty,
			NEDPatientDMISId) 
		VALUES(@key_pat,
			@ned, 
			@name, 
			@sex, 
			@dob,
			@age,
			@ssn,
			@pseudo,
			@add1,
			@add2,
			@add3,
			@city,
			@state,
			@zip,
			@phone,
			@ophone,
			@branch,
			@spssn,
			@fmp,
			@grade,
			@deersegenddt,
			@acv,
			@dmis,
			@pcm,
			@race,
			@mar,
			@page,
			@nedlast,
			@nedfirst,
			@nedmid,
			@pcat,
			@pcov,
			@reg,
			@ben,
			@phc,
			@ndi,
			@hcdp,
			@key_pat,
			@id,
			@uic,
			@regt,
			@ad,
			@neddmis);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @ned <> @nedX
		OR @name <> @nameX
		OR @dob <> @dobX
		OR @age <> @ageX
		OR @ssn <> @ssnX
		OR @pseudo <> @pseudoX
		OR @add1 <> @add1X
		OR @add2 <> @add2X
		OR @add3 <> @add3X
		OR @city <> @cityX
		OR @state <> @stateX
		OR @zip <> @zipX
		OR @phone <> @phoneX
		OR @ophone <> @ophoneX
		OR @branch <> @branchX
		OR @spssn <> @spssnX
		OR @fmp <> @fmpX
		OR @grade <> @gradeX
		OR @deersegenddt <> @deersegenddtX
		OR @acv <> @acvX
		OR @dmis <> @dmisX
		OR @pcm <> @pcmX
		OR @race <> @raceX
		OR @mar <> @marX
		OR @page <> @pageX
		OR @nedlast <> @nedlastX
		OR @nedfirst <> @nedfirstX
		OR @nedmid <> @nedmidX
		OR @pcat <> @pcatX
		OR @pcov <> @pcovX
		OR @reg <> @regX
		OR @ndi <> @ndiX
		OR @ben <> @benX
		OR @phc <> @phcX
		OR @hcdp <> @hcdpX
		OR @id <> @idX
		OR (@ned Is Not Null AND @nedX Is Null)
		OR (@name Is Not Null AND @nameX Is Null)
		OR (@dob Is Not Null AND @dobX Is Null)
		OR (@age Is Not Null AND @ageX Is Null)
		OR (@ssn Is Not Null AND @ssnX Is Null)
		OR (@pseudo Is Not Null AND @pseudoX Is Null)
		OR (@add1 Is Not Null AND @add1X Is Null)
		OR (@add2 Is Not Null AND @add2X Is Null)
		OR (@add3 Is Not Null AND @add3X Is Null)
		OR (@city Is Not Null AND @cityX Is Null)
		OR (@state Is Not Null AND @stateX Is Null)
		OR (@zip Is Not Null AND @zipX Is Null)
		OR (@phone Is Not Null AND @phoneX Is Null)
		OR (@ophone Is Not Null AND @ophoneX Is Null)
		OR (@branch Is Not Null AND @branchX Is Null)
		OR (@spssn Is Not Null AND @spssnX Is Null)
		OR (@fmp Is Not Null AND @fmpX Is Null)
		OR (@grade Is Not Null AND @gradeX Is Null)
		OR (@deersegenddt Is Not Null AND @deersegenddtX Is Null)
		OR (@acv Is Not Null AND @acvX Is Null)
		OR (@dmis Is Not Null AND @dmisX Is Null)
		OR (@pcm Is Not Null AND @pcmX Is Null)
		OR (@race Is Not Null AND @raceX Is Null)
		OR (@mar Is Not Null AND @marX Is Null)
		OR (@page Is Not Null AND @pageX Is Null)
		OR (@nedlast Is Not Null AND @nedlastX Is Null)
		OR (@nedfirst Is Not Null AND @nedlastX Is Null)
		OR (@nedmid Is Not Null AND @nedmidX Is Null)
		OR (@pcat Is Not Null AND @pcatX Is Null)
		OR (@pcov Is Not Null AND @pcovX Is Null)
		OR (@reg Is Not Null AND @regX Is Null)
		OR (@ndi Is Not Null AND @ndiX Is Null)
		OR (@ben Is Not Null AND @benX Is Null)
		OR (@phc Is Not Null AND @phcX Is Null)
		OR (@hcdp Is Not Null AND @hcdpX Is Null)
		OR (@id Is Not Null AND @idX Is Null)
			BEGIN
			SET @today = getdate()
			UPDATE NHJAX_ODS.dbo.PATIENT
			SET NedPatientIEN = @ned,
			FullName = @name,
			DOB = @dob,
			DisplayAge = @age,
			SSN = @ssn,
			PseudoPatientId =@pseudo,
			StreetAddress1 = @add1,
			StreetAddress2 = @add2,
			StreetAddress3 = @add3,
			City = @city,
			StateId = @state,
			ZipCode = @zip,
			Phone = @phone,
			OfficePhone = @ophone,
			LastBranchofServiceId = @branch,
			SponsorSSN = @spssn,
			FamilyMemberPrefixId = @fmp,
			MilitaryGradeRankId = @grade,
			DeersEligibilityEndDate = @deersegenddt,
			AlternateCareValueId = @acv,
			DMISId = @dmis,
			CurrentPCMId = @pcm,
			RaceId = @race,
			MaritalStatusId = @mar,
			PatientAge = @page,
			NedLName = @nedlast,
			NedFName = @nedfirst,
			NedMName = @nedmid,
			PatientCategoryId = @pcat,
			PatientCoverageId = @pcov,
			RegistrationIncomplete = @reg,
			NDIEligibility = @ndi,
			BenefitsCategoryId = @ben,
			PharmacyComment =@phc,
			HCDPCoverageId = @hcdp,
			PatientIdentifier = @id,
			UpdatedDate = @today
			WHERE PatientKey = @key_pat;
			SET @urow = @urow + 1
			END
		
		If (@sex <> @sexX AND @sex <> 'UNKNOWN')
			OR (@sex Is NOT Null AND @sexX Is Null)
		BEGIN
			UPDATE PATIENT
			SET Sex = @sex,
			UpdatedDate = GETDATE()
			WHERE PatientKey = @key_pat
		END
			
		If @uic <> @uicX
		OR (@uic Is Not Null AND @uicX Is Null)
		BEGIN
			UPDATE PATIENT
			SET UICId = @uic,
			UpdatedDate = GETDATE()
			WHERE PatientKey = @key_pat
		END
		
		If @regt <> @regtX
		OR (@regt IS NOT NULL AND @regtX Is Null)
		BEGIN
			UPDATE PATIENT
			SET RegistrationTypeId = @regt,
			UpdatedDate = GETDATE()
			WHERE PatientKey = @key_pat
		END
		
		IF (@ad <> @adX) 
		OR (@ad IS NOT NULL AND @adX IS NULL)
		BEGIN
			UPDATE PATIENT
			SET ActiveDuty = @ad,
			UpdatedDate = GETDATE()
			WHERE PatientKey = @key_pat
		END
		
		IF (@neddmis <> @neddmisX) AND @neddmis <> 2011
		BEGIN
			UPDATE PATIENT
			SET NEDPatientDMISId = @neddmis,
			UpdatedDate = GETDATE()
			WHERE PatientKey = @key_pat
		END
		
		--20111101 KSK: Manual update to RecordLocationId
		--Not always numeric from source.
		SELECT @isnum = ISNUMERIC(@loc)
		IF @isnum = 1
		BEGIN
			--SET @loc = 0
			SELECT @locX = HospitalLocationId
			FROM HOSPITAL_LOCATION
			WHERE HospitalLocationKey = CAST(@loc AS numeric(12,4))
			
			UPDATE PATIENT
			SET RecordLocationId = @locX
			WHERE PatientKey = @key_pat
		END
		ELSE
		BEGIN
			UPDATE PATIENT
			SET RecordLocationId = 0
			WHERE PatientKey = @key_pat
		END
		
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curPatient INTO @key_pat,@ned,@name,@sex,@dob,@age,@ssn,@pseudo,
		@add1,@add2,@add3,@city,@state,@zip,@phone,@ophone,@branch,@spssn,
		@fmp,@grade,@DeersEgEndDt,@acv,@dmis,@pcm,@race,@mar,@page,@nedlast,@nedfirst,
		@nedmid,@pcat,@pcov,@reg,@ben,@phc,@ndi,@hcdp,@id,@uic,@loc,@regt,@ad,@neddmis
	COMMIT

	END

END
CLOSE curPatient
DEALLOCATE curPatient
SET @trow = @trow - 1
SET @surow = 'Patient Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Patient Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Patient Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End Patient',0,@day;

EXEC dbo.upActivityLog 'Begin Validate Patient',0,@day;

UPDATE PATIENT
SET ValidateDate = getdate()
WHERE PatientKey IN
	(
		SELECT	KEY_PATIENT
		FROM vwMDE_PATIENT
	)
	
--20120813 KSK - moved deceased flag to Patient
UPDATE PATIENT
SET PatientDeceased = 1
WHERE PatientId IN
(
	SELECT DISTINCT ENC.PatientId
	FROM ENCOUNTER_DIAGNOSIS AS DENC
	INNER JOIN DIAGNOSIS AS DIAG
	ON DENC.DiagnosisId = DIAG.DiagnosisId
	INNER JOIN PATIENT_ENCOUNTER AS ENC
	ON DENC.PatientEncounterId = ENC.PatientEncounterId
	WHERE diag.diagnosiscode in
		(
			'761.6','768.1','798.1','798.9','798.0','798.2'
		)
)
AND PatientDeceased = 0

--	DECLARE curPat CURSOR FAST_FORWARD FOR
--	SELECT	P.KEY_PATIENT
--	FROM vwMDE_PATIENT P

--	OPEN curPat

--EXEC dbo.upActivityLog 'Fetch Validate Patient',0;
--	FETCH NEXT FROM curPat INTO @key_pat
		
--	if(@@FETCH_STATUS = 0)
--	BEGIN

--	WHILE(@@FETCH_STATUS = 0)
--		BEGIN
--			BEGIN TRANSACTION

--			UPDATE PATIENT
--			SET ValidateDate = getdate()
--			WHERE PatientKey = @key_pat;
--			FETCH NEXT FROM curPat INTO @key_pat
--			COMMIT

--		END

--	END
--	CLOSE curPat
--	DEALLOCATE curPat
EXEC dbo.upActivityLog 'End Validate Patient',0,@day;

