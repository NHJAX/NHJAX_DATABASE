

CREATE PROCEDURE [dbo].[procODS_PATIENT_SelectbyKey]
	@pat decimal
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT 
    PAT.PatientId,
    PAT.PatientKey,
	PAT.FullName,
	PAT.DisplayAge,
	PAT.SponsorSSN,
	PAT.FamilyMemberPrefixId,
	PAT.DOB,
	PAT.SEX,
	PAT.PatientIdentifier,
	PAT.PatientCategoryId,
	PAT.StreetAddress1,
	PAT.StreetAddress2,
	PAT.CITY,
	PAT.StateId,
	PAT.ZipCode,
	PAT.PHONE,
	PAT.UpdatedDate,
	PAT.DMISId,
	GEO.GeographicLocationAbbrev,
	CAT.PatientCategoryDesc,
	COV.PatientCoverageDesc,
	ISNULL(DMIS.DMISCode,'0999') AS DMISCode,
	GEO.GeographicLocationKey,
	CAT.PatientCategoryKey,
	FMP.FamilyMemberPrefixKey,
	ISNULL(DMIS.DMISKey,1018) AS DMISKey,
	ISNULL(RNK.MilitaryGradeRankKey,0) AS MilitaryGradeRankKey,
	ISNULL(HCDP.HcdpCoverageCode,'UNK') AS HCDPCoverageCode
	FROM PATIENT AS PAT
	LEFT OUTER JOIN GEOGRAPHIC_LOCATION AS GEO
	ON PAT.StateId = GEO.GeographicLocationId
	INNER JOIN PATIENT_CATEGORY AS CAT
	ON PAT.PatientCategoryId = CAT.PatientCategoryId
	LEFT OUTER JOIN PATIENT_COVERAGE AS COV
	ON PAT.PatientCoverageId = COV.PatientCoverageId
	LEFT OUTER JOIN DMIS AS DMIS
	ON PAT.DMISId = DMIS.DMISId
	LEFT OUTER JOIN FAMILY_MEMBER_PREFIX AS FMP
	ON PAT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId
	LEFT OUTER JOIN MILITARY_GRADE_RANK AS RNK
	ON PAT.MilitaryGradeRankId = RNK.MilitaryGradeRankId
	LEFT OUTER JOIN HCDP_COVERAGE AS HCDP
	ON PAT.HCDPCoverageId = HCDP.HCDPCoverageId
	WHERE PAT.PatientKey = @pat
END


