

CREATE PROCEDURE [dbo].[upODS_PatientNDI_20090331]
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
Declare @benX bigint
Declare @phcX varchar(62)
Declare @ndiX int

EXEC dbo.upActivityLog 'Begin Patient NDI',0;
DECLARE curPatient CURSOR FAST_FORWARD FOR
SELECT	P.KEY_PATIENT, 
	CASE NDI.ELIGIBILITY_INDICATOR
		WHEN 'NO' THEN 0
		WHEN 'YES' THEN 1
		ELSE -1
	END AS NDIEligibility
FROM   vwMDE_PATIENT P 
	LEFT OUTER JOIN vwMDE_NDI_ELIGIBILITY AS NDI
	ON P.KEY_PATIENT = NDI.PATIENT_NAME_IEN
	
OPEN curPatient
SET @trow = 0
SET @irow = 0
SET @urow = 0
EXEC dbo.upActivityLog 'Fetch Patient NDI',0
FETCH NEXT FROM curPatient INTO @key_pat,@ndi
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
	@ndiX = NDIEligibility
	from NHJAX_ODS.dbo.PATIENT 
	Where PatientKey = @key_pat
	SET @exists = @@RowCount
	If @exists = 0
		BEGIN
			SET @irow = @irow + 1
		END
	ELSE
		BEGIN
		If @ndi <> @ndiX
		OR (@ndi Is Not Null AND @ndiX Is Null)
			BEGIN
			
			UPDATE NHJAX_ODS.dbo.PATIENT
			SET 
			NDIEligibility = @ndi
			WHERE PatientKey = @key_pat;
			SET @urow = @urow + 1
			END
		
		END
		SET @trow = @trow + 1
		FETCH NEXT FROM curPatient INTO @key_pat,@ndi
	COMMIT

	END

END
CLOSE curPatient
DEALLOCATE curPatient
SET @trow = @trow - 1
SET @surow = 'Patient NDI Updated: ' + CAST(@urow AS varchar(50))
SET @sirow = 'Patient NDI Inserted: ' + CAST(@irow AS varchar(50))
SET @strow = 'Patient NDI Total: ' + CAST(@trow AS varchar(50))
EXEC dbo.upActivityLog @surow,0;
EXEC dbo.upActivityLog @sirow,0;
EXEC dbo.upActivityLog @strow,0;
EXEC dbo.upActivityLog 'End NDI Patient',0;



