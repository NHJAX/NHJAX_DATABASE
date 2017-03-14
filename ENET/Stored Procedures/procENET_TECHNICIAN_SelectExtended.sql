CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_SelectExtended]
(
	@usr int
)
AS

SELECT     
	Tech.UserId, 
	RTRIM(Tech.ULName) AS ULName, 
	RTRIM(Tech.UFName) AS UFName, 
	RTRIM(Tech.UMName) AS UMName, 
	Tech.Title, 
    Tech.EMailAddress, 
	Tech.AudienceId, 
	Aud.AudienceDesc, 
	Tech.Location, 
	Tech.UPhone, 
	Tech.Extension, 
	Tech.UPager, 
	Tech.AltPhone, 
    Tech.Inactive, 
	Tech.Comments, 
	Tech.LoginId, 
	BASE.BaseCode,
	TECH.SSN,
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
	Tech.State,
	Tech.Zip,
	Tech.DesignationId,
	Tech.PreviousDutyStation,
	Tech.ExpectedEndDate,
	AUD.BaseId,
	Tech.ContractorCompany,
	Tech.ContractNumber,
	Tech.HealthCareStatusId,
	Tech.NetworkAccess,
	Tech.OutlookExchange,
	Tech.EthnicityId,
	Tech.DisplayName,
	Tech.CheckInDate,
	Tech.CreatedDate,
	Tech.CreatedBy,
	Tech.UpdatedDate,
	Tech.UpdatedBy,
	Tech.BilletId,
	Tech.distinguishedName,
	Tech.AutoUpdatedDate,
	Tech.ServiceAccount,
	Tech.SourceSystemId,
	BASE.ADCompany,
	BASE.ADAddress1,
	BASE.ADAddress2,
	BASE.ADCity,
	BASE.ADState,
	BASE.ADZip,
	AUD.DisplayName,
	AUD.AudiencePhone,
	HEAL.HealthcareStatusShort,
	Tech.Suffix,
	Tech.ComponentId,
	RANK.RankAbbrev,
	IsNull(EXT.ProviderId,0) As ProviderId,
	IsNull(EXT.IsException,0) As IsException,
	Tech.LB,
	Tech.LBBy,
	Tech.LBDate,
	Tech.PSQ,
	Tech.PSQBy,
	Tech.PSQDate,
	Tech.Supervisor,
	EXT.Deployed,
	EXT.DeployDate,
	EXT.ReturnDate,
	EXT.HasAlt,
	EXT.AltId,
	Tech.EducationLevelId,
	Tech.Prefix,
	EXT.AvailableForDisaster,
	EXT.HasServerAccess,
	EXT.ExcludeTrainingDept,
	EXT.TeamId,
	EXT.TimekeeperTypeId,
	EXT.HasDriversLicense,
	Tech.DoDEDI,
	EXT.AltIssueDate,
	EXT.IsSupervisor,
	EXT.IsORM,
	Tech.EffectiveDate,
	EXT.IsSupplyPO,
	ISNULL(DIR.DisplayName, AUD.DisplayName),
	ISNULL(DIR.DirectorName, AUD.DisplayName),
	COMP.ComponentDesc,
	TECH.EmployeeNumber,
	EXT.NPIKey
FROM   BASE 
	INNER JOIN AUDIENCE Aud 
	ON BASE.BaseId = Aud.BaseId 
	RIGHT OUTER JOIN TECHNICIAN AS TECH 
	ON Aud.AudienceId = Tech.AudienceId
	LEFT JOIN HEALTHCARE_STATUS AS HEAL
	ON HEAL.HealthCareStatusId = TECH.HealthCareStatusId
	LEFT JOIN RANK
	ON Tech.RankId = RANK.RankId
	LEFT JOIN TECHNICIAN_EXTENDED AS EXT
	ON Tech.UserId = EXT.UserId
	LEFT JOIN vwENET_AUDIENCE_DIRECTORATE AS ADIR
	ON ADIR.AudienceId = TECH.AudienceId
	LEFT JOIN AUDIENCE AS DIR
	ON DIR.AudienceId = ADIR.DirectorateId
	INNER JOIN COMPONENT AS COMP
	ON TECH.ComponentId = COMP.ComponentId
WHERE Tech.UserId = @usr








