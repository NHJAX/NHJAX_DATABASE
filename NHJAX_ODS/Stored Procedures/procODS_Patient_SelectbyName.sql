

CREATE PROCEDURE [dbo].[procODS_Patient_SelectbyName]
	@pat varchar(32),
	@sex varchar(30) = ''
AS
BEGIN
	
	SET NOCOUNT ON;

IF @sex = ''
BEGIN
SELECT PAT.PatientId,
	PAT.FullName AS PatientName, 
	FamilyMemberPrefixCode AS FMP, 
	RIGHT(SponsorSSN,4) AS SSN, 
	ISNULL(PAT.Phone,'') AS HomePhone, 
	ISNULL(PAT.OfficePhone,'') as WorkPhone, 
	DOB, 
	DisplayAge AS Age, 
	ISNULL(MilitaryGradeRankCode,'') AS [Rank], 
	LEFT(Sex,1) AS Sex,
	PAT.PatientKey
FROM NHJAX_ODS.dbo.PATIENT AS PAT
	LEFT OUTER JOIN NHJAX_ODS.dbo.FAMILY_MEMBER_PREFIX AS FMP
	ON PAT.FamilyMemberPrefixId= FMP.FamilyMemberPrefixId
	LEFT OUTER JOIN NHJAX_ODS.dbo.MILITARY_GRADE_RANK AS RNK 
	ON PAT.MilitaryGradeRankId= RNK.MilitaryGradeRankId
where PAT.FullName LIKE '' + @pat + '%'  
ORDER BY PAT.FullName
END
ELSE
BEGIN
SELECT PAT.PatientId,
	PAT.FullName AS PatientName, 
	FamilyMemberPrefixCode AS FMP, 
	RIGHT(SponsorSSN,4) AS SSN, 
	ISNULL(PAT.Phone,'') AS HomePhone, 
	ISNULL(PAT.OfficePhone,'') as WorkPhone, 
	DOB, 
	DisplayAge AS Age, 
	ISNULL(MilitaryGradeRankCode,'') AS [Rank], 
	LEFT(Sex,1) AS Sex,
	PAT.PatientKey
FROM NHJAX_ODS.dbo.PATIENT AS PAT
	LEFT OUTER JOIN NHJAX_ODS.dbo.FAMILY_MEMBER_PREFIX AS FMP
	ON PAT.FamilyMemberPrefixId= FMP.FamilyMemberPrefixId
	LEFT OUTER JOIN NHJAX_ODS.dbo.MILITARY_GRADE_RANK AS RNK 
	ON PAT.MilitaryGradeRankId= RNK.MilitaryGradeRankId
where PAT.FullName LIKE '' + @pat + '%'  
AND PAT.Sex = @sex
ORDER BY PAT.FullName
END
END


