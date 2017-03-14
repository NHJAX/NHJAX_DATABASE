
CREATE PROCEDURE [dbo].[upSSRS_Patient_letters]
	(
		@tech int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     
	PAT.PatientId, 
	UPPER(PAT.FullName) AS FULLNAME, 
	UPPER(ISNULL(PAT.Phone, '')) AS Phone, 
	ISNULL(PAT.OfficePhone, '') AS OfficePhone, 
	UPPER(ISNULL(PAT.StreetAddress1, '')) AS StreetAddress1, 
	UPPER(ISNULL(PAT.StreetAddress2, '')) AS StreetAddress2, 
	UPPER(ISNULL(PAT.StreetAddress3, '')) AS StreetAddress3, 
	UPPER(ISNULL(PAT.City, '')) AS City, 
	UPPER(ISNULL(LOC.GeographicLocationAbbrev, '')) AS GeographicLocation, 
	UPPER(ISNULL(replace(PAT.ZipCode,'-',' '), '')) AS Zip, 
	ISNULL(PAT.SSN, '') AS SSN, 
	ISNULL(RIGHT(PAT.SSN, 4), '') AS LastFour, 
	ISNULL(PAT.Sex, '') AS Sex, PAT.DOB, 
	ISNULL(PAT.DisplayAge, '') AS DisplayAge, 
	ISNULL(PAT.SponsorSSN, '') AS SponsorSSN, 
	UPPER(ISNULL(FMP.FamilyMemberPrefixCode, '')) AS FamilyMemberPrefix, 
	UPPER(ISNULL(RANK.MilitaryGradeRankDesc, '')) AS MilitaryGradeRank, 
	ISNULL(PAT.PharmacyComment, '') AS PharmacyComment, 
	PAT.CreatedDate, 
	PAT.UpdatedDate, 	
	UPPER(PAT.ODSFName) AS NEDFNAME,
	UPPER(PAT.ODSLName) AS NEDLNAME,
	--UPPER(LTRIM(RTRIM(SubString(LTRIM(RTRIM(Pat.Fullname)), CharIndex(',', LTRIM(RTRIM(Pat.Fullname))) + 1, len(LTRIM(RTRIM(Pat.Fullname))) - Len(Right(LTRIM(RTRIM(Pat.Fullname)), CharIndex(' ', reverse(LTRIM(RTRIM(Pat.Fullname)))))) - 3)))) AS NEDFNAME,
	--UPPER(LTRIM(RTRIM(Left(LTRIM(RTRIM(Pat.Fullname)), CharIndex(',', LTRIM(RTRIM(Pat.Fullname))) - 1)))) AS NEDLNAME,	
	UPPER(PAT.NedMName) AS NedMName
FROM         
	nhjax_ods.dbo.PATIENT AS PAT 
	LEFT OUTER JOIN nhjax_ods.dbo.GEOGRAPHIC_LOCATION AS LOC 
	ON PAT.StateId = LOC.GeographicLocationId 
	LEFT OUTER JOIN nhjax_ods.dbo.FAMILY_MEMBER_PREFIX AS FMP 
	ON PAT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId 
	LEFT OUTER JOIN nhjax_ods.dbo.MILITARY_GRADE_RANK AS RANK 
	ON PAT.MilitaryGradeRankId = RANK.MilitaryGradeRankId
WHERE
	PAT.PatientId in(select patientid
					 from vwSSRS_Sess_PATIENT_LETTER_PRINT 
					 where techid= @tech
					)
END



