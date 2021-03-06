﻿CREATE PROCEDURE [dbo].[procCIO_Personnel_SelectbyDoDEDI]
(
	@dod nvarchar(10)
)
AS

SELECT TOP 1 
	Tech.UserId, 
	RTRIM(Tech.LastName) AS LastName, 
	RTRIM(Tech.FirstName) AS FirstName, 
	RTRIM(Tech.MiddleName) AS MiddleName, 
	Tech.Title, 
	Tech.EMailAddress, 
	Tech.AudienceId, 
	Tech.Location, 
	Tech.UPhone, 
	Tech.Extension, 
	Tech.UPager, 
	Tech.AltPhone, 
	Tech.Comments, 
	Tech.LoginId, 
	Tech.SSN, 
	Tech.DOB, 
	Tech.RankId, 
	Tech.Rate, 
	Tech.MedStuYr, 
	Tech.OtherStu, 
	Tech.EAOS_PRD, 
	Tech.Sex, 
	Tech.CitizenshipId, 
	Tech.NMCIEMail, 
	Tech.Address1, 
	Tech.Address2, 
	Tech.City, 
	Tech.[State], 
	Tech.Zip, 
	Tech.DesignationId, 
	Tech.PreviousDutyStation, 
	Tech.ExpectedEndDate, 
	Aud.BaseId,
	Tech.PersonnelId,
	Tech.ContractorCompany,
	Tech.ContractNumber,
	Tech.HealthcareStatusId,
	Tech.NetworkAccess,
	Tech.OutlookExchange,
	Tech.EthnicityId,
	Tech.AccessCode,
	Tech.VerifyCode,
	Tech.AHLTA,
	Tech.DisplayName,
	BASE.ADCompany,
	BASE.ADAddress1,
	BASE.ADCity,
	BASE.ADState,
	BASE.ADZip,
	AUD.DisplayName,
	AUD.AudiencePhone,
	RNK.RankAbbrev,
	Tech.CheckInDate,
	HEAL.HealthcareStatusShort,
	Tech.Suffix,
	Tech.ComponentId,
	tech.LB,
	tech.LBBy,
	tech.LBDate,
	tech.PSQ,
	tech.PSQBy,
	tech.PSQDate,
	Tech.Supervisor,
	Tech.EducationLevelId,
	Tech.DoDEDI,
	Tech.EffectiveDate,
	Tech.EmployeeNumber,
	Tech.NPIKey,
	ISNULL(DIR.DisplayName, 'N/A') AS Directorate
FROM	vwENET_AUDIENCE AS Aud 
	RIGHT OUTER JOIN PERSONNEL AS Tech 
	ON Aud.AudienceId = Tech.AudienceId
	INNER JOIN vwENET_BASE AS BASE
	ON BASE.BaseId = AUD.BaseId
	INNER JOIN vwENET_RANK AS RNK
	ON RNK.RankId = Tech.RankId
	INNER JOIN vwENET_HEALTHCARE_STATUS AS HEAL
	ON HEAL.HealthcareStatusId = TECH.HealthcareStatusId
	LEFT JOIN ENET.dbo.vwENET_AUDIENCE_DIRECTORATE AS ADIR
	ON Tech.AudienceId = ADIR.AudienceId
	LEFT JOIN vwENET_AUDIENCE AS DIR
	ON ADIR.DirectorateId = DIR.AudienceId
WHERE	(Tech.DoDEDI = @dod) 
	AND (Tech.DoDEDI > 0) 
	AND (Tech.DoDEDI IS NOT NULL)
ORDER BY Tech.UpdatedDate DESC







