




CREATE PROCEDURE [dbo].[upCDSS_PatientFindByID20070417]
(
	@patientID	numeric(15,0)
)
AS
	SELECT  P.FullName,
            P.DOB,
			P.SEX,
			P.SPONSORSSN,
			FMP.FamilyMemberPrefixKey,
			B.BranchofServiceDesc AS BRANCH_OF_SERVICE_LAST,
			G.MilitaryGradeRankDesc AS MILITARY_GRADE_RANK,
			G.MilitaryGradeRankPAYGRADE,
			F.IsAsthmatic,
			F.IsDiabetic,
			F.IsHyperlipidemic,
			F.IsWalkin,
			CAST(ISNULL(PR.ProviderKey, 0) AS int) AS ProviderID,
			ISNULL(PR.ProviderName, '') AS ProviderName,
			P.StreetAddress1,
			P.StreetAddress2,
			P.StreetAddress3,
			P.CITY,
			L.GeographicLocationDesc AS STATE,
			P.ZIPCODE,
			P.PatientKey,
			CAST('1/1/1900 12:00:00 AM' AS DateTime) AS Appointment_Date_Time
	FROM  	PATIENT P
			INNER JOIN 
			[nhjax-sql2].CDSS.dbo.CDSSPatientFlag F 
			ON P.PatientKey = F.PatientID
			LEFT JOIN 
			BRANCH_OF_SERVICE B	
			ON P.LastBranchofServiceId = B.BranchofServiceId
			LEFT JOIN
			MILITARY_GRADE_RANK G 	
			ON P.MilitaryGradeRankId = G.MilitaryGradeRankId
			LEFT JOIN
			PROVIDER PR
			ON F.EmpanelledTo = PR.ProviderKey
			LEFT JOIN
			GEOGRAPHIC_LOCATION L	
			ON P.StateId = L.GeographicLocationId
			INNER JOIN
			FAMILY_MEMBER_PREFIX FMP
			ON FMP.FamilyMemberPrefixId = P.FamilyMemberPrefixId
	WHERE 	P.PatientKey = @patientID;

