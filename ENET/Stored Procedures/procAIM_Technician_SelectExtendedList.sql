create PROCEDURE [dbo].[procAIM_Technician_SelectExtendedList]

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
	AUD.DisplayName,
	AUD.AudiencePhone,
	HEAL.HealthcareStatusShort,
	Tech.Suffix,
	Tech.ComponentId,
	Tech.Supervisor,
	Tech.IsAIMException,
	Tech.DoDEDI
FROM   BASE 
	INNER JOIN AUDIENCE Aud 
	ON BASE.BaseId = Aud.BaseId 
	RIGHT OUTER JOIN TECHNICIAN Tech 
	ON Aud.AudienceId = Tech.AudienceId
	LEFT JOIN HEALTHCARE_STATUS HEAL
	ON HEAL.HealthCareStatusId = TECH.HealthCareStatusId
WHERE Tech.DoDEDI IS NULL








