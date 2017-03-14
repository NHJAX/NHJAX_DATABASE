-- =============================================
-- Author:		Robert Evans
-- Create date: 25 Aug 2011
-- Description:	The Clinical Portal Maternity Page Print Button Report
-- =============================================
CREATE PROCEDURE [dbo].[procCP_RPT_MATERNITY_LISTING]
@iMonth int = 0, @iYear int = 0, @iStatus int = 0, @sSearchString nvarchar(50) = null
WITH EXEC AS CALLER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @TotalRows int

IF @sSearchString = '' SET @sSearchString = NULL

DECLARE @HoldTable as TABLE (RowId int Identity(1,1),
	MaternityPatientId bigint not null, 
	PatientId bigint null,
	FullName varchar(32) null,
	FamilyMemberPrefixCode varchar(30) null,
	SponsorSSN varchar(15) null,
	MPCSSN varchar(45) null,
	DOB nvarchar(10) null,
	Phone varchar(25) null,
	OfficePhone varchar(19) null,
	EDC date null,
	DISPLAYEDC nvarchar(10) null,
	DueMonth int null,
	DueYear int null,
	MaternityStatusDesc varchar(50) null,
	Notes varchar(8000) null,
	ProviderName varchar(30) null,
	DisplayAge varchar(15) null,
	MaternityTeamDesc varchar(50) null,
	FPProviderName varchar(30) null,
	AlphaName varchar(150) null,
	Location varchar(50) null,
	ENRDMIS varchar(50) null,
	UICCode varchar(30) null,
  GDxml nvarchar(MAX) null,
  Abnormal bit null
	)	
IF @iStatus = -3
  BEGIN
    		INSERT INTO @HoldTable (MaternityPatientId,PatientId,FullName,
    			FamilyMemberPrefixCode,SponsorSSN,MPCSSN,DOB,Phone,
    			OfficePhone,EDC,DISPLAYEDC,DueMonth,DueYear,
    			MaternityStatusDesc,Notes,ProviderName,DisplayAge,
    			MaternityTeamDesc,FPProviderName,AlphaName,Location,
    			ENRDMIS,UICCode,GDxml,Abnormal)	
    		SELECT 
    			MPAT.MaternityPatientId, 
    			MPAT.PatientId,
    			PAT.FullName, 
    			FMP.FamilyMemberPrefixCode, 
    			PAT.SponsorSSN,
    			FMP.FamilyMemberPrefixCode + '/' + RIGHT(PAT.SponsorSSN,4) as MPCSSN, 
    			CONVERT(NVARCHAR(10),PAT.DOB,101) as DOB , 
    			PAT.Phone, 
    			PAT.OfficePhone,
    			MPAT.EDC,
    			CONVERT(NVARCHAR(10),MPAT.EDC,101) as DISPLAYEDC , 
    			DATEPART(month,MPAT.EDC) as DueMonth,
    			DATEPART(Year,MPAT.EDC) as DueYear, 
    			STAT.MaternityStatusDesc, 
    			MPAT.Notes, 
    			PRO.ProviderName, 
    			PAT.DisplayAge,
    			TEAM.MaternityTeamDesc,
    			FPPRO.ProviderName as FPProviderName,
    			ISNULL(TECH.ULName + ', ' + TECH.UFNAME + ' ' + TECH.UMNAME, 'System') AS AlphaName,
    			ISNULL(DMIS.FacilityName, 'N/A') as Location,
    			dbo.GestationalDiabetesCounseling(MPAT.PatientId, 'COUNSEL') as ENRDMIS,
		    	dbo.GestationalDiabetesCounseling(MPAT.PatientId, 'NUTRITION') as UICCODE,
          dbo.PatientsGestationalDiabetesResultsStr(MPAT.PatientId) as GXml,
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
			ON MPAT.FPProviderId = FPPRO.ENetId
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
    IF @iStatus = -2
    	BEGIN
    		INSERT INTO @HoldTable (MaternityPatientId,PatientId,FullName,
    			FamilyMemberPrefixCode,SponsorSSN,MPCSSN,DOB,Phone,
    			OfficePhone,EDC,DISPLAYEDC,DueMonth,DueYear,
    			MaternityStatusDesc,Notes,ProviderName,DisplayAge,
    			MaternityTeamDesc,FPProviderName,AlphaName,Location,
    			ENRDMIS,UICCode,GDxml,Abnormal)	
    		SELECT 
    			MPAT.MaternityPatientId, 
    			MPAT.PatientId,
    			PAT.FullName, 
    			FMP.FamilyMemberPrefixCode, 
    			PAT.SponsorSSN,
    			FMP.FamilyMemberPrefixCode + '/' + RIGHT(PAT.SponsorSSN,4) as MPCSSN, 
    			CONVERT(NVARCHAR(10),PAT.DOB,101) as DOB , 
    			PAT.Phone, 
    			PAT.OfficePhone,
    			MPAT.EDC,
    			CONVERT(NVARCHAR(10),MPAT.EDC,101) as DISPLAYEDC , 
    			DATEPART(month,MPAT.EDC) as DueMonth,
    			DATEPART(Year,MPAT.EDC) as DueYear, 
    			STAT.MaternityStatusDesc, 
    			MPAT.Notes, 
    			PRO.ProviderName, 
    			PAT.DisplayAge,
    			TEAM.MaternityTeamDesc,
    			FPPRO.ProviderName as FPProviderName,
    			ISNULL(TECH.ULName + ', ' + TECH.UFNAME + ' ' + TECH.UMNAME, 'System') AS AlphaName,
    			ISNULL(DMIS.FacilityName, 'N/A') as Location,
    			ISNULL(DMIS_PCM.FacilityName, 'N/A') as ENRDMIS,
    			UIC.UICCode as UICCODE,
          dbo.PatientsGestationalDiabetesResultsStr(MPAT.PatientId) as GXml,
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
    			ON MPAT.FPProviderId = FPPRO.ENetId
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
    		AND (MPAT.EDC < DATEADD(Month,-2,getdate())
    		OR  MPAT.EDC > DATEADD(Month,9,getdate()))
    		ORDER BY DueYear,DueMonth, PAT.FullName

    		SET @TotalRows = @@ROWCOUNT
    	END
    ELSE
    	BEGIN				
    		INSERT INTO @HoldTable (MaternityPatientId,PatientId,FullName,
    			FamilyMemberPrefixCode,SponsorSSN,MPCSSN,DOB,Phone,
    			OfficePhone,EDC,DISPLAYEDC,DueMonth,DueYear,
    			MaternityStatusDesc,Notes,ProviderName,DisplayAge,
    			MaternityTeamDesc,FPProviderName,AlphaName,Location,
    			ENRDMIS,UICCode,GDxml,Abnormal)	
    		SELECT 
    			MPAT.MaternityPatientId, 
    			MPAT.PatientId,
    			PAT.FullName, 
    			FMP.FamilyMemberPrefixCode, 
    			PAT.SponsorSSN,
    			FMP.FamilyMemberPrefixCode + '/' + RIGHT(PAT.SponsorSSN,4) as MPCSSN, 
    			CONVERT(NVARCHAR(10),PAT.DOB,101) as DOB , 
    			PAT.Phone, 
    			PAT.OfficePhone,
    			MPAT.EDC,
    			CONVERT(NVARCHAR(10),MPAT.EDC,101) as DISPLAYEDC , 
    			DATEPART(month,MPAT.EDC) as DueMonth,
    			DATEPART(Year,MPAT.EDC) as DueYear, 
    			STAT.MaternityStatusDesc, 
    			MPAT.Notes, 
    			PRO.ProviderName, 
    			PAT.DisplayAge,
    			TEAM.MaternityTeamDesc,
    			FPPRO.ProviderName as FPProviderName,
    			ISNULL(TECH.ULName + ', ' + TECH.UFNAME + ' ' + TECH.UMNAME, 'System') AS AlphaName,
    			ISNULL(DMIS.FacilityName, 'N/A') as Location,
    			ISNULL(DMIS_PCM.FacilityName, 'N/A') as ENRDMIS,
    			UIC.UICCode as UICCODE,
          dbo.PatientsGestationalDiabetesResultsStr(MPAT.PatientId) as GXml,
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
    		AND ISNULL(DATEPART(Month,MPAT.EDC),0) = CASE WHEN @iMonth = 0 THEN ISNULL(DATEPART(Month,MPAT.EDC),0) ELSE @iMonth END
    		AND ISNULL(DATEPART(Year,MPAT.EDC),0) = CASE WHEN @iYear = 0 THEN ISNULL(DATEPART(Year,MPAT.EDC),0) ELSE @iYear END
    		AND ISNULL(MPAT.MaternityStatusId,0) = CASE WHEN @iStatus > 0 THEN ISNULL(MPAT.MaternityStatusId,0) ELSE 0 END
    		ORDER BY DueYear,DueMonth, PAT.FullName

    		SET @TotalRows = @@ROWCOUNT
    	END		
  END
IF @sSearchString IS NOT NULL
	BEGIN
		SELECT * FROM @HoldTable WHERE UPPER(FullName) LIKE '%' + UPPER(@sSearchString) + '%'
	END
ELSE
	BEGIN
		SELECT * FROM @HoldTable
	END
END