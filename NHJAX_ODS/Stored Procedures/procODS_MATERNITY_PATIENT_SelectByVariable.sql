CREATE PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_SelectByVariable]
@mth int = 0, @yr int = 0, @stat int = -1
WITH EXEC AS CALLER
AS
SET NOCOUNT ON;
IF @stat = -3  --GESTATIONAL DFIABETIC PATIENTS
--+ CASE WHEN DATEDIFF(day,getdate(),MPAT.EDC) < 21 THEN '<div title="Patient is in the 21 Day TDap Window" style="color:red;font-size:x-small;">&nbspTDaP?</div>' ELSE '' END 

  BEGIN
		SELECT 
			MPAT.MaternityPatientId, 
			MPAT.PatientId,
			PAT.FullName, 
			FMP.FamilyMemberPrefixCode, 
			PAT.SponsorSSN,
			FMP.FamilyMemberPrefixCode + '/' + RIGHT(PAT.SponsorSSN,4) as MPCSSN, 
			CONVERT(NVARCHAR(10),PAT.DOB,101) as DOB , 
			PAT.StreetAddress1, 
			PAT.StreetAddress2, 
			PAT.StreetAddress3, 
			PAT.City, 
			PAT.ZipCode, 
			LOC.GeographicLocationAbbrev, 
			PAT.Phone, 
			PAT.OfficePhone,
			MPAT.EDC,
			CONVERT(NVARCHAR(10),MPAT.EDC,101) as DISPLAYEDC, 
			DATEPART(month,MPAT.EDC) as DueMonth,
			DATEPART(Year,MPAT.EDC) as DueYear, 
			MPAT.MaternityStatusId,
			STAT.MaternityStatusDesc, 
			MPAT.Notes, 
			PRO.ProviderId,
			PRO.ProviderName, 
			PRO.ProviderCode,
			MPAT.CreatedDate, 
			MPAT.UpdatedDate, 
			MPAT.CreatedBy, 
			MPAT.UpdatedBy,
			PAT.DisplayAge,
			MPAT.MaternityTeamId,
			TEAM.MaternityTeamDesc,
			MPAT.FPProviderId,
			FPPRO.ProviderName,
			FPPRO.ProviderName as FPProviderName,
			ISNULL(TECH.ULName + ', ' + TECH.UFNAME + ' ' + TECH.UMNAME, 'System') AS AlphaName,
			ISNULL(DMIS.FacilityName, 'N/A') as Location,
			dbo.GestationalDiabetesCounseling(MPAT.PatientId, 'COUNSEL') as ENRDMIS,
			dbo.GestationalDiabetesCounseling(MPAT.PatientId, 'NUTRITION') as UICCODE,
      dbo.PatientsGestationalDiabetesResults(MPAT.PatientId) as GXml,
      1 as IsAbnormal
		FROM PROVIDER AS PRO 
			INNER JOIN PRIMARY_CARE_MANAGER AS PCM 
			ON PRO.ProviderId = PCM.ProviderId 
			RIGHT OUTER JOIN MATERNITY_PATIENT AS MPAT 
			INNER JOIN PATIENT AS PAT 
			ON MPAT.PatientId = PAT.PatientId 
			LEFT OUTER JOIN FAMILY_MEMBER_PREFIX AS FMP 
			ON PAT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId 
			LEFT OUTER JOIN GEOGRAPHIC_LOCATION AS LOC 
			ON PAT.StateId = LOC.GeographicLocationId 
			ON PCM.PatientID = PAT.PatientId
			INNER JOIN MATERNITY_STATUS AS STAT
			ON MPAT.MaternityStatusId = STAT.MaternityStatusId
			INNER JOIN MATERNITY_TEAM AS TEAM
			ON MPAT.MaternityTeamId = TEAM.MaternityTeamId
			INNER JOIN PROVIDER AS FPPRO
			ON MPAT.FPProviderId = FPPRO.ProviderId
			INNER JOIN vwENET_TECHNICIAN AS TECH
			ON MPAT.UpdatedBy = TECH.UserId
			LEFT OUTER JOIN DMIS 
			ON PAT.DMISId = DMIS.DMISId
			LEFT OUTER JOIN DMIS AS DMIS_PCM
			ON PCM.DmisId = DMIS_PCM.DMISId
			LEFT OUTER JOIN UIC
			ON PAT.UICId = UIC.UICId
		WHERE MPAT.MaternityPatientId > 0 
		AND ISNULL(MPAT.MaternityStatusId,0) = 0 
		AND (MPAT.EDC > DATEADD(Month,-2,getdate())
		OR  MPAT.EDC < DATEADD(Month,9,getdate()))
    AND dbo.IsGestationalDiabeticAbnormal(MPAT.PatientId) = 1
		ORDER BY DueYear,DueMonth, MPAT.EDC, PAT.FullName
  END
ELSE
  BEGIN
    IF @stat = -2  -- ALL ACTIVE
    	BEGIN
    		SELECT 
    			MPAT.MaternityPatientId, 
    			MPAT.PatientId,
    			PAT.FullName, 
    			FMP.FamilyMemberPrefixCode, 
    			PAT.SponsorSSN,
    			FMP.FamilyMemberPrefixCode + '/' + RIGHT(PAT.SponsorSSN,4) as MPCSSN, 
    			CONVERT(NVARCHAR(10),PAT.DOB,101) as DOB , 
    			PAT.StreetAddress1, 
    			PAT.StreetAddress2, 
    			PAT.StreetAddress3, 
    			PAT.City, 
    			PAT.ZipCode, 
    			LOC.GeographicLocationAbbrev, 
    			PAT.Phone, 
    			PAT.OfficePhone,
    			MPAT.EDC,
    			CONVERT(NVARCHAR(10),MPAT.EDC,101) as DISPLAYEDC, 
    			DATEPART(month,MPAT.EDC) as DueMonth,
    			DATEPART(Year,MPAT.EDC) as DueYear, 
    			MPAT.MaternityStatusId,
    			STAT.MaternityStatusDesc, 
    			MPAT.Notes, 
    			PRO.ProviderId,
    			PRO.ProviderName, 
    			PRO.ProviderCode,
    			MPAT.CreatedDate, 
    			MPAT.UpdatedDate, 
    			MPAT.CreatedBy, 
    			MPAT.UpdatedBy,
    			PAT.DisplayAge,
    			MPAT.MaternityTeamId,
    			TEAM.MaternityTeamDesc,
    			MPAT.FPProviderId,
    			FPPRO.ProviderName,
    			FPPRO.ProviderName as FPProviderName,
    			ISNULL(TECH.ULName + ', ' + TECH.UFNAME + ' ' + TECH.UMNAME, 'System') AS AlphaName,
    			ISNULL(DMIS.FacilityName, 'N/A') as Location,
    			CONVERT(NVARCHAR(8),ISNULL(DMIS_PCM.FacilityName, 'N/A')) as ENRDMIS,
    			UIC.UICCode,
          dbo.PatientsGestationalDiabetesResults(MPAT.PatientId) as GXml,
          dbo.IsGestationalDiabeticAbnormal(MPAT.PatientId) as IsAbnormal
    		FROM PROVIDER AS PRO 
    			INNER JOIN PRIMARY_CARE_MANAGER AS PCM 
    			ON PRO.ProviderId = PCM.ProviderId 
    			RIGHT OUTER JOIN MATERNITY_PATIENT AS MPAT 
    			INNER JOIN PATIENT AS PAT 
    			ON MPAT.PatientId = PAT.PatientId 
    			LEFT OUTER JOIN FAMILY_MEMBER_PREFIX AS FMP 
    			ON PAT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId 
    			LEFT OUTER JOIN GEOGRAPHIC_LOCATION AS LOC 
    			ON PAT.StateId = LOC.GeographicLocationId 
    			ON PCM.PatientID = PAT.PatientId
    			INNER JOIN MATERNITY_STATUS AS STAT
    			ON MPAT.MaternityStatusId = STAT.MaternityStatusId
    			INNER JOIN MATERNITY_TEAM AS TEAM
    			ON MPAT.MaternityTeamId = TEAM.MaternityTeamId
    			INNER JOIN PROVIDER AS FPPRO
    			ON MPAT.FPProviderId = FPPRO.ProviderId
    			INNER JOIN vwENET_TECHNICIAN AS TECH
    			ON MPAT.UpdatedBy = TECH.UserId
    			LEFT OUTER JOIN DMIS 
    			ON PAT.DMISId = DMIS.DMISId
    			LEFT OUTER JOIN DMIS AS DMIS_PCM
    			ON PCM.DmisId = DMIS_PCM.DMISId
    			LEFT OUTER JOIN UIC
    			ON PAT.UICId = UIC.UICId
    		WHERE MPAT.MaternityPatientId > 0 
    		AND ISNULL(MPAT.MaternityStatusId,0) = 0 
    		AND (MPAT.EDC > DATEADD(Month,-2,getdate())
    		OR  MPAT.EDC < DATEADD(Month,9,getdate()))
    		ORDER BY DueYear,DueMonth, MPAT.EDC, PAT.FullName
    	END
    ELSE
    	BEGIN
        -- Shows all or active by month and year
    		SELECT 
    			MPAT.MaternityPatientId, 
    			MPAT.PatientId,
    			PAT.FullName, 
    			FMP.FamilyMemberPrefixCode, 
    			PAT.SponsorSSN,
    			FMP.FamilyMemberPrefixCode + '/' + RIGHT(PAT.SponsorSSN,4) as MPCSSN, 
    			CONVERT(NVARCHAR(10),PAT.DOB,101) as DOB , 
    			PAT.StreetAddress1, 
    			PAT.StreetAddress2, 
    			PAT.StreetAddress3, 
    			PAT.City, 
    			PAT.ZipCode, 
    			LOC.GeographicLocationAbbrev, 
    			PAT.Phone, 
    			PAT.OfficePhone,
    			MPAT.EDC,
    			CONVERT(NVARCHAR(10),MPAT.EDC,101) as DISPLAYEDC, 
    			DATEPART(month,MPAT.EDC) as DueMonth,
    			DATEPART(Year,MPAT.EDC) as DueYear, 
    			MPAT.MaternityStatusId,
    			STAT.MaternityStatusDesc, 
    			MPAT.Notes, 
    			PRO.ProviderId,
    			PRO.ProviderName, 
    			PRO.ProviderCode,
    			MPAT.CreatedDate, 
    			MPAT.UpdatedDate, 
    			MPAT.CreatedBy, 
    			MPAT.UpdatedBy,
    			PAT.DisplayAge,
    			MPAT.MaternityTeamId,
    			TEAM.MaternityTeamDesc,
    			MPAT.FPProviderId,
    			FPPRO.ProviderName,
    			FPPRO.ProviderName as FPProviderName,
    			ISNULL(TECH.ULName + ', ' + TECH.UFNAME + ' ' + TECH.UMNAME, 'System') AS AlphaName,
    			ISNULL(DMIS.FacilityName, 'N/A') as Location,
    			CONVERT(NVARCHAR(8),ISNULL(DMIS_PCM.FacilityName, 'N/A')) as ENRDMIS,
    			UIC.UICCode,
          dbo.PatientsGestationalDiabetesResults(MPAT.PatientId) as GXml,
          dbo.IsGestationalDiabeticAbnormal(MPAT.PatientId) as IsAbnormal
    		FROM PROVIDER AS PRO 
    			INNER JOIN PRIMARY_CARE_MANAGER AS PCM 
    			ON PRO.ProviderId = PCM.ProviderId 
    			RIGHT OUTER JOIN MATERNITY_PATIENT AS MPAT 
    			INNER JOIN PATIENT AS PAT 
    			ON MPAT.PatientId = PAT.PatientId 
    			LEFT OUTER JOIN FAMILY_MEMBER_PREFIX AS FMP 
    			ON PAT.FamilyMemberPrefixId = FMP.FamilyMemberPrefixId 
    			LEFT OUTER JOIN GEOGRAPHIC_LOCATION AS LOC 
    			ON PAT.StateId = LOC.GeographicLocationId 
    			ON PCM.PatientID = PAT.PatientId
    			INNER JOIN MATERNITY_STATUS AS STAT
    			ON MPAT.MaternityStatusId = STAT.MaternityStatusId
    			INNER JOIN MATERNITY_TEAM AS TEAM
    			ON MPAT.MaternityTeamId = TEAM.MaternityTeamId
    			INNER JOIN PROVIDER AS FPPRO
    			ON MPAT.FPProviderId = FPPRO.ProviderId
    			INNER JOIN vwENET_TECHNICIAN AS TECH
    			ON MPAT.UpdatedBy = TECH.UserId
    			LEFT OUTER JOIN DMIS 
    			ON PAT.DMISId = DMIS.DMISId
    			LEFT OUTER JOIN DMIS AS DMIS_PCM
    			ON PCM.DmisId = DMIS_PCM.DMISId
    			LEFT OUTER JOIN UIC
    			ON PAT.UICId = UIC.UICId
    		WHERE MPAT.MaternityPatientId > 0 
    		AND ISNULL(DATEPART(Month,MPAT.EDC),0) = CASE WHEN @mth = 0 THEN ISNULL(DATEPART(Month,MPAT.EDC),0) ELSE @mth END
    		AND ISNULL(DATEPART(Year,MPAT.EDC),0) = CASE WHEN @yr = 0 THEN ISNULL(DATEPART(Year,MPAT.EDC),0) ELSE @yr END
    		AND ISNULL(MPAT.MaternityStatusId,0) = CASE WHEN @stat > 0 THEN ISNULL(MPAT.MaternityStatusId,0) ELSE 0 END
    		ORDER BY DueYear,DueMonth, MPAT.EDC, PAT.FullName
    	END
  END