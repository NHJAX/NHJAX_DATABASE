
CREATE PROCEDURE [dbo].[procODS_PATIENT_Insert]
	@pat decimal,
	@name varchar(32),
	@age varchar(15),
	@spon varchar(15),
	@ssn varchar(4),
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
	@dmis bigint = 0,
	@ss bigint = 0
AS
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO PATIENT
		( 
		PatientKey, 
		FullName, 
		DisplayAge, 
		SponsorSSN, 
		SSN,
		FamilyMemberPrefixId,
		DOB,
		SEX,
		PatientIdentifier,
		PatientCategoryId,
		StreetAddress1,
		StreetAddress2,
		CITY,
		StateId,
		ZipCode,
		Phone,
		DMISId,
		SourceSystemId
		)
	VALUES
		(
		@pat,
		@name,
		@age,
		@spon,
		@ssn,
		@fmp,
		@dob,
		@sex,
		@pi,
		@cat,
		@add,
		@add2,
		@city,
		@st,
		@zip,
		@ph,
		@dmis,
		@ss
		);
SELECT SCOPE_IDENTITY();
END

