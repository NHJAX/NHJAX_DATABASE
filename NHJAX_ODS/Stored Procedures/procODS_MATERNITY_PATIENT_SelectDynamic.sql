
CREATE PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_SelectDynamic]
(
	@debug bit = 0,
	@mth int = 0,
	@ball bit = 0,
	@fpro int = -1,
	@tm int = -1,
	@stat int = -1,
	@spat varchar(32) = '',
	@fmp varchar(30) = '',
	@enr varchar(50) = ''
)
AS
SET NOCOUNT ON;

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)
	
SELECT @sql = 'SELECT     
					MPAT.MaternityPatientId, 
					MPAT.PatientId,
					PAT.FullName, 
					FMP.FamilyMemberPrefixCode, 
					PAT.SponsorSSN, 
					PAT.DOB, 
					PAT.StreetAddress1, 
					PAT.StreetAddress2, 
					PAT.StreetAddress3, 
					PAT.City, 
					PAT.ZipCode, 
					LOC.GeographicLocationAbbrev, 
					PAT.Phone, 
					PAT.OfficePhone,
					MPAT.EDC, 
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
					ISNULL(TECH.ULName + '', '' + TECH.UFNAME + '' '' + TECH.UMNAME, ''System'') AS AlphaName,
					ISNULL(DMIS.FacilityName, ''N/A''),
					ISNULL(DMIS_PCM.FacilityName, ''N/A''),
					UIC.UICCode
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
				WHERE MPAT.MaternityPatientId > 0 '

IF @ball = 0
BEGIN
	SELECT @sql = @sql + 'AND (MPAT.MaternityStatusId IN (0)) '
END

IF @mth > 0
BEGIN		
	IF @mth = 13
	BEGIN
	SELECT @sql = @sql + 'AND MPAT.EDC NOT BETWEEN 
					dbo.FirstDayofMonth(DATEADD(MONTH,-2,GETDATE())) 
					AND dbo.LastDayofMonth(DATEADD(MONTH,9,GETDATE())) '
	END
	ELSE
	BEGIN
	--Month Range
	SELECT @sql = @sql + 'AND MPAT.EDC BETWEEN 
					dbo.FirstDayofMonth(DATEADD(MONTH,@mth -3,GETDATE())) 
					AND dbo.LastDayofMonth(DATEADD(MONTH,@mth -3,GETDATE())) '
	END
END

IF @fpro > -1
BEGIN
	SELECT @sql = @sql + 'AND MPAT.FPProviderId = @fpro '
END

IF @tm > -1
BEGIN
	SELECT @sql = @sql + 'AND MPAT.MaternityTeamId = @tm '
END

IF @stat > -1
BEGIN
	SELECT @sql = @sql + 'AND MPAT.MaternityStatusId = @stat '
END

IF @spat <> ''
BEGIN
	SELECT @sql = @sql + 'AND PAT.FullName LIKE ''' + @spat + '%'' '
END

IF @fmp <> ''
BEGIN
	SELECT @sql = @sql + 'AND FMP.FamilyMemberPrefixCode = ''' + @fmp + ''' '
END

IF @enr <> ''
BEGIN
	SELECT @sql = @sql + 'AND DMIS_PCM.FacilityName = ''' + @enr + ''' '
END

		
SELECT @sql = @sql + 'ORDER BY PAT.FullName '

IF @debug = 1
	BEGIN
		PRINT @sql
		PRINT @mth
		PRINT @ball
		PRINT @fpro
		PRINT @tm
		PRINT @stat
		PRINT @spat
		PRINT @fmp
		PRINT @enr
	END
	
SELECT @paramlist = '@mth int,
			@ball bit,
			@fpro int,
			@tm int,
			@stat int,
			@spat varchar(32),
			@fmp varchar(30),
			@enr varchar(50)'

EXEC sp_executesql	@sql, @paramlist, @mth, @ball, @fpro, @tm, 
			@stat, @spat, @fmp,@enr