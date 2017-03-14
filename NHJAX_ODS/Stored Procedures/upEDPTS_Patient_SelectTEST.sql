

create PROCEDURE [dbo].[upEDPTS_Patient_SelectTEST]
	
AS
BEGIN
	
	SET NOCOUNT ON;

    select p.patientid,
	p.FullName as PatientName, 
	FamilyMemberPrefixCode as FMP, 
	Right(SponsorSSN,4) as SSN, 
	IsNull(p.Phone,'') as HomePhone, 
	IsNull(p.OfficePhone,'') as WorkPhone, 
	DOB, 
	DisplayAge as Age, 
	IsNull(MilitaryGradeRankCode,'') as Rank, 
	LEFT(Sex,1) as Sex
from NHJAX_ODS.dbo.Patient p 
	left outer join NHJAX_ODS.dbo.family_member_prefix f 
	on p.FamilyMemberPrefixId=f.FamilyMemberPrefixId
	left outer join NHJAX_ODS.dbo.military_grade_rank r 
	on p.MilitaryGradeRankId=r.MilitaryGradeRankId
where p.PatientId < 100000
END


