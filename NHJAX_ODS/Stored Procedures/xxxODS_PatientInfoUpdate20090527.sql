CREATE PROCEDURE [dbo].[xxxODS_PatientInfoUpdate20090527] AS

Declare @spon varchar(50) = '127-30-1483'
Declare @fmp varchar(3) = '20'
Declare @chcskey numeric(13,3) = 0
Declare @id bigint = 0

SELECT @id = PAT.PatientId, 
	@chcskey = PAT.PatientKey
FROM PATIENT AS PAT 
	INNER JOIN FAMILY_MEMBER_PREFIX AS FMP 
	ON PAT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId
WHERE (PAT.SponsorSSN = @spon) 
	AND (FMP.FamilyMemberPrefixKey = Cast(@fmp as numeric(8,3)))

PRINT @id
	
IF @id = 0
BEGIN
--Lookup in staging for add
BEGIN TRANSACTION
	INSERT INTO PATIENT
		(
		FullName,
		Sex,
		DOB,
		SSN,
		StreetAddress1,
		StreetAddress2,
		City,
		ZipCode,
		Phone,
		OfficePhone,
		SponsorSSN,
		FamilyMemberPrefixId,
		SourceSystemId,
		SourceSystemKey,
		ODSFName,
		ODSMName,
		ODSLName,
		PatientKey
		)
	SELECT     
		GPAT.LastName + ',' + GPAT.FirstName + ' ' + GPAT.MiddleName AS FullName, 
		ISNULL(SPAT.SEX, GPAT.Gender) AS Sex, 
		ISNULL(SPAT.DOB, GPAT.DOB) AS DOB, 
		ISNULL(SPAT.SSN, GPAT.SSN) AS SSN, 
		ISNULL(SPAT.STREET_ADDRESS, GPAT.StreetAddress1) AS StreetAddress1, 
		ISNULL(SPAT.STREET_ADDRESS_2, GPAT.StreetAddress2) AS StreetAddress2, 
		ISNULL(SPAT.CITY, GPAT.City) AS City, 
		ISNULL(SPAT.ZIP_CODE, GPAT.Zip) AS Zip, 
		ISNULL(SPAT.PHONE, GPAT.Phone) AS Phone, 
		ISNULL(SPAT.OFFICE_PHONE, GPAT.OfficePhone) AS OfficePhone, 
		GPAT.SponsorSSN, 
		ISNULL(SFMP.FamilyMemberPrefixId, 
		GFMP.FamilyMemberPrefixId) AS FamilyMemberPrefixId, 
		12 AS SourceSystemId, 
		GPAT.PatientKey AS SourceSystemKey,
		GPAT.FirstName,
		ISNULL(GPAT.MiddleName,'') AS MiddleName,
		GPAT.LastName,
		SPAT.Key_Patient
	FROM FAMILY_MEMBER_PREFIX AS GFMP 
		INNER JOIN vwXXX_Patient20090522 AS GPAT 
		ON GFMP.FamilyMemberPrefixKey = CAST(GPAT.FMP AS numeric(8, 3)) 
		LEFT OUTER JOIN FAMILY_MEMBER_PREFIX AS SFMP 
		INNER JOIN [NHJAX-CACHE].staging.dbo.PATIENT AS SPAT 
		ON SFMP.FamilyMemberPrefixKey = SPAT.FMP_IEN 
		ON GPAT.SponsorSSN = SPAT.SPONSOR_SSN 
		AND CAST(GPAT.FMP AS numeric(8, 3)) = SPAT.FMP_IEN
	WHERE (GPAT.PatientId IS NULL)
		AND GPAT.SponsorSSN = @spon
		AND GPAT.FMP = @fmp
	COMMIT
	
	PRINT @spon
	PRINT @fmp
	
	Declare @newid bigint = 0
	Declare @newkey numeric(13,3) = 0
	--repeat search for newly inserted record.
	SELECT @newid = PAT.PatientId, 
		@newkey = ISNULL(PAT.PatientKey,0)
	FROM PATIENT AS PAT 
		INNER JOIN FAMILY_MEMBER_PREFIX AS FMP 
		ON PAT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId
	WHERE (PAT.SponsorSSN = @spon) 
		AND (FMP.FamilyMemberPrefixKey = CAST(@fmp as numeric(8,3)))
	
	PRINT 'newkey: ' + @newkey
	IF @newkey = 0
	BEGIN
		DELETE FROM PATIENT 
		WHERE PatientId = @newid
		AND SourceSystemId = 12;
		
		DELETE FROM vwXXX_Patient20090522
		WHERE SponsorSSN = @spon
		AND FMP = @fmp;
		PRINT 'Deleted'
	END
	ELSE
	BEGIN
		UPDATE vwXXX_Patient20090522
		SET PatientId = @newid,
		CHCSKey = @newkey
		WHERE SponsorSSN = @spon
		AND FMP = @fmp;
		PRINT 'Updated1'
	END

END
ELSE
BEGIN
	UPDATE vwXXX_Patient20090522
	SET PatientId = @id,
	CHCSKey = @chcskey
	WHERE SponsorSSN = @spon
	AND FMP = @fmp;
	Print 'Updated2'
END
	



