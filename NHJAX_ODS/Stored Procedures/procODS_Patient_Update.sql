

CREATE PROCEDURE [dbo].[procODS_Patient_Update]
	@pat decimal,
	@name varchar(32),
	@age varchar(15),
	@spon varchar(15),
	@fmp bigint,
	@dob datetime,
	@sex varchar(30),
	@pi varchar(50),
	@cat bigint,
	@add varchar(50),
	@add2 varchar(36),
	@city varchar(30),
	@st bigint,
	@zip varchar(10),
	@ph varchar(25),
	@dmis bigint = 0
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE PATIENT
	SET 
		FullName = @name,
		DisplayAge = @age,
		SponsorSSN = @spon,
		FamilyMemberPrefixId = @fmp,
		DOB = @dob,
		SEX = @sex,
		PatientIdentifier = @pi,
		PatientCategoryId = @cat,
		StreetAddress1 = @add,
		StreetAddress2 = @add2,
		CITY = @city,
		StateId = @st,
		ZipCode = @zip,
		PHONE = @ph,
		DMISId = @dmis,
		UpdatedDate = GetDate()
	WHERE PatientKey = @pat
END

