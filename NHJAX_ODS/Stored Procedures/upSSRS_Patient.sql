
CREATE PROCEDURE [dbo].[upSSRS_Patient]
	(
		@pat bigint
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
	ISNULL(PAT.Phone, 'UNKNOWN') AS Phone, 
	ISNULL(PAT.OfficePhone, 'UNKNOWN') AS OfficePhone, 
	UPPER(ISNULL(PAT.StreetAddress1, 'UNKNOWN')) AS StreetAddress1, 
	UPPER(ISNULL(PAT.StreetAddress2, 'UNKNOWN')) AS StreetAddress2, 
	UPPER(ISNULL(PAT.StreetAddress3, 'UNKNOWN')) AS StreetAddress3, 
	UPPER(ISNULL(PAT.City, 'UNKNOWN')) AS City, 
	UPPER(ISNULL(LOC.GeographicLocationAbbrev, '')) AS GeographicLocation, 
	ISNULL(replace(PAT.ZipCode,'-',' '), 'UNKNOWN') AS Zip, 
	ISNULL(PAT.SSN, 'UNKNOWN') AS SSN, 
	ISNULL(RIGHT(PAT.SSN, 4), 'UNK') AS LastFour, 
	ISNULL(PAT.Sex, 'UNK') AS Sex,
	PAT.DOB, 
	ISNULL(PAT.DisplayAge, 'UNK') AS DisplayAge, 
	ISNULL(PAT.SponsorSSN, 'UNKNOWN') AS SponsorSSN, 
	ISNULL(FMP.FamilyMemberPrefixCode, 'NA') AS FamilyMemberPrefix, 
	ISNULL(RANK.MilitaryGradeRankDesc, 'UNKNOWN') AS MilitaryGradeRank, 
	ISNULL(PAT.PharmacyComment, 'NA') AS PharmacyComment, 
	PAT.CreatedDate, 
	PAT.UpdatedDate, 
	PAT.NedFName
FROM         
	nhjax_ods.dbo.PATIENT AS PAT 
	LEFT OUTER JOIN nhjax_ods.dbo.GEOGRAPHIC_LOCATION AS LOC 
	ON PAT.StateId = LOC.GeographicLocationId 
	LEFT OUTER JOIN nhjax_ods.dbo.FAMILY_MEMBER_PREFIX AS FMP 
	ON PAT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId 
	LEFT OUTER JOIN nhjax_ods.dbo.MILITARY_GRADE_RANK AS RANK 
	ON PAT.MilitaryGradeRankId = RANK.MilitaryGradeRankId
WHERE
	PAT.PatientId = @pat
END
