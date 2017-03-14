

CREATE PROCEDURE [dbo].[procODS_Patient_SelectbyFMPSSN]
	@fmp varchar(30),
	@ssn varchar(15),
	@sex varchar(30) = ''
AS
BEGIN
	
	SET NOCOUNT ON;

--format ssn
IF LEN(@ssn) > 6
BEGIN
SET @ssn = dbo.FormattedSSN(@ssn)
END


--without fmp
IF @fmp = ''
BEGIN
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
	where PAT.SponsorSSN LIKE '%' + @ssn + ''  
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
	where PAT.SponsorSSN LIKE '%' + @ssn + ''  
	AND PAT.Sex = @sex
	ORDER BY PAT.FullName
	END
END
ELSE
BEGIN
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
		LEFT(Sex,1) AS Sex
	FROM NHJAX_ODS.dbo.PATIENT AS PAT
		LEFT OUTER JOIN NHJAX_ODS.dbo.FAMILY_MEMBER_PREFIX AS FMP
		ON PAT.FamilyMemberPrefixId= FMP.FamilyMemberPrefixId
		LEFT OUTER JOIN NHJAX_ODS.dbo.MILITARY_GRADE_RANK AS RNK 
		ON PAT.MilitaryGradeRankId= RNK.MilitaryGradeRankId
	where FMP.FamilyMemberPrefixCode = @fmp
	AND PAT.SponsorSSN LIKE '%' + @ssn + ''  
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
		LEFT(Sex,1) AS Sex
	FROM NHJAX_ODS.dbo.PATIENT AS PAT
		LEFT OUTER JOIN NHJAX_ODS.dbo.FAMILY_MEMBER_PREFIX AS FMP
		ON PAT.FamilyMemberPrefixId= FMP.FamilyMemberPrefixId
		LEFT OUTER JOIN NHJAX_ODS.dbo.MILITARY_GRADE_RANK AS RNK 
		ON PAT.MilitaryGradeRankId= RNK.MilitaryGradeRankId
	where FMP.FamilyMemberPrefixCode = @fmp
	AND PAT.SponsorSSN LIKE '%' + @ssn + ''  
	AND PAT.Sex = @sex
	ORDER BY PAT.FullName
	END
END


END
