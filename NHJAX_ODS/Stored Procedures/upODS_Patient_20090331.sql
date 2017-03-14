

create PROCEDURE [dbo].[upODS_Patient_20090331]
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
Declare @city varchar(20)
Declare @state bigint
Declare @zip varchar(10)
Declare @phone varchar(15)
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
Declare @recloc bigint
Declare @ben bigint
DECLARE @phc varchar(62)
Declare @ndi int

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
Declare @cityX varchar(20)
Declare @stateX bigint
Declare @zipX varchar(10)
Declare @phoneX varchar(15)
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
Declare @reclocX bigint
Declare @benX bigint
Declare @phcX varchar(62)
Declare @ndiX int

EXEC dbo.upActivityLog 'Begin Patient',0;
DECLARE curPatient CURSOR FAST_FORWARD FOR
SELECT	P.KEY_PATIENT, 
	NP.KEY_NED_PATIENT, 
	P.NAME, 
	P.SEX, 
	P.DOB, 
	P.DISPLAY_AGE, 
	P.SSN, 
	ISNULL(PSEUDO.PseudoPatientId, 0) AS PseudoPatientId, 
	P.STREET_ADDRESS, 
	P.STREET_ADDRESS_2, 
	P.STREET_ADDRESS_3, 
	P.CITY, 
	GEO.GeographicLocationId, 
	P.ZIP_CODE, 
	P.PHONE, 
	P.OFFICE_PHONE, 
	BOS.BranchofServiceId, 
	P.SPONSOR_SSN, 
	FMP.FamilyMemberPrefixId, 
	MIL.MilitaryGradeRankId, 
	P.DEERS_ELIGIBILITY_END_DATE, 
	ACV.AlternateCareValueId, 
	DMIS.DMISId, 
	PRO.ProviderId, 
	ISNULL(RACE.RaceId, 4) AS RaceId, 
	ISNULL(MAR.MaritalStatusId, 7) AS MaritalStatusId, 
	P.AGE, 
	P.NED_PATIENT_LAST_NAME, 
	P.NED_PATIENT_FIRST_NAME, 
	P.NED_PATIENT_MIDDLE_NAME, 
	ISNULL(PC.PatientCategoryId, 0) AS PatientCategoryId, 
	ISNULL(PCO.PatientCoverageId, 0) AS PatientCoverageId, 
	CASE ISNULL(P.REGISTRATION_INCOMPLETE, '0') 
		WHEN '0' 
			THEN 0 
		ELSE 
		CASE P.REGISTRATION_INCOMPLETE
			WHEN 'REGISTRATION IS COMPLETE'
				THEN 0
			ELSE 1
		END 
	END AS RegistrationComplete,
	HOSP.HospitalLocationId, 
	IsNull(BENEFITS_CATEGORY.BenefitsCategoryId,0) As BenefitsCategoryId,
	IsNull(PHP.PHARMACY_COMMENT, '') AS PharmacyComment
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
	RIGHT OUTER JOIN vwMDE_PATIENT P 
	LEFT OUTER JOIN ALTERNATE_CARE_VALUE ACV 
	ON P.ACV_IEN = ACV.AlternateCareValueKey 
	LEFT OUTER JOIN BRANCH_OF_SERVICE BOS 
	ON P.BRANCH_OF_SERVICE_LAST_IEN = BOS.BranchofServiceKey 
	LEFT OUTER JOIN RACE 
	ON P.RACE_IEN = RACE.RaceKey 
	LEFT OUTER JOIN MARITAL_STATUS MAR 
	ON P.MARITAL_STATUS_IEN = MAR.MaritalStatusKey 
	LEFT OUTER JOIN DMIS 
	ON P.DMIS_ID_IEN = DMIS.DMISKey 
	LEFT OUTER JOIN FAMILY_MEMBER_PREFIX FMP 
	ON P.FMP_IEN = FMP.FamilyMemberPrefixKey 
	LEFT OUTER JOIN GEOGRAPHIC_LOCATION GEO 
	ON P.STATE_IEN = GEO.GeographicLocationKey 
	INNER JOIN vwSTG_STG_PATIENT_ACTIVITY PA
	ON P.KEY_PATIENT = PA.PATIENT_IEN 
	LEFT OUTER JOIN HOSPITAL_LOCATION HOSP 
	ON dbo.RecordLocation(P.OUTPATIENT_RECORD_LOCATION_IEN) = HOSP.HospitalLocationKey 
	LEFT OUTER JOIN PATIENT_CATEGORY PC 
	ON P.PATIENT_CATEGORY_IEN = PC.PatientCategoryKey 
	ON PSEUDO.PseudoPatientDesc = P.PSEUDO_PATIENT 
	LEFT OUTER JOIN MILITARY_GRADE_RANK MIL 
	ON P.MILITARY_GRADE_RANK_IEN = MIL.MilitaryGradeRankKey 
	ON NP.PATIENT_NAME_IEN = P.KEY_PATIENT
	LEFT OUTER JOIN vwMDE_PHARMACY_PATIENT PHP
	ON P.KEY_PATIENT = PHP.NAME_IEN
	
OPEN curPatient
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Patient',0
FETCH NEXT FROM curPatient INTO @key_pat,@ned,@name,@sex,@dob,@age,@ssn,@pseudo,
	@add1,@add2,@add3,@city,@state,@zip,@phone,@ophone,@branch,@spssn,
	@fmp,@grade,@DeersEgEndDt,@acv,@dmis,@pcm,@race,@mar,@page,@nedlast,
	@nedfirst,@nedmid,@pcat,@pcov,@reg,@recloc,@ben, @phc
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
	@reclocX = RecordLocationId,
	@benX = BenefitsCategoryId,
	@phcX = PharmacyComment
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
			RecordLocationId,
			BenefitsCategoryId,
			PharmacyComment) 
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
			@recloc,
			@ben,
			@phc);
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @ned <> @nedX
		OR @name <> @nameX
		OR @sex <> @sexX
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
		OR @recloc <> @reclocX
		OR @ben <> @benX
		OR @phc <> @phcX
		OR (@ned Is Not Null AND @nedX Is Null)
		OR (@name Is Not Null AND @nameX Is Null)
		OR (@sex Is Not Null AND @sexX Is Null)
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
		OR (@recloc Is Not Null AND @reclocX Is Null)
		OR (@ben Is Not Null AND @benX Is Null)
		OR (@phc Is Not Null AND @phcX Is Null)
			BEGIN
			SET @today = getdate()
			UPDATE NHJAX_ODS.dbo.PATIENT
			SET NedPatientIEN = @ned,
			FullName = @name,
			Sex = @sex,
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
			RecordLocationId = @recloc,
			BenefitsCategoryId = @ben,
			PharmacyComment =@phc,
			UpdatedDate = @today
			WHERE PatientKey = @key_pat;
			SET @urow = @urow + 1
			END
		
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curPatient INTO @key_pat,@ned,@name,@sex,@dob,@age,@ssn,@pseudo,
		@add1,@add2,@add3,@city,@state,@zip,@phone,@ophone,@branch,@spssn,
		@fmp,@grade,@DeersEgEndDt,@acv,@dmis,@pcm,@race,@mar,@page,@nedlast,@nedfirst,
		@nedmid,@pcat,@pcov,@reg,@recloc,@ben, @phc
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
EXEC dbo.upActivityLog 'End Patient',0;

EXEC dbo.upActivityLog 'Begin Validate Patient',0;

	DECLARE curPat CURSOR FAST_FORWARD FOR
	SELECT	P.KEY_PATIENT
	FROM vwMDE_PATIENT P

	OPEN curPat

EXEC dbo.upActivityLog 'Fetch Validate Patient',0;
	FETCH NEXT FROM curPat INTO @key_pat
		
	if(@@FETCH_STATUS = 0)
	BEGIN

	WHILE(@@FETCH_STATUS = 0)
		BEGIN
			BEGIN TRANSACTION

			UPDATE PATIENT
			SET ValidateDate = getdate()
			WHERE PatientKey = @key_pat;
			FETCH NEXT FROM curPat INTO @key_pat
			COMMIT

		END

	END
	CLOSE curPat
	DEALLOCATE curPat
EXEC dbo.upActivityLog 'End Validate Patient',0;

