
create PROCEDURE [dbo].[procODS_MATERNITY_PATIENT_SelectDynamicBulkTEST_20091125]
(
	@srt	varchar(50) = 'PatientName',
	@dir	int = 0,
	@debug bit = 0,
	@mth int = 0,
	@ball bit = 0,
	@fpro int = -1,
	@tm int = -1,
	@stat int = -1
	
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
					FPPRO.ProviderName AS FPProviderName
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

BEGIN
IF @srt = 'PatientName'	
	SELECT @sql = @sql + 'ORDER BY PAT.FullName '
ELSE IF @srt = 'DOB'	
	SELECT @sql = @sql + 'ORDER BY PAT.DOB '
ELSE IF @srt = 'Team'	
	SELECT @sql = @sql + 'ORDER BY TEAM.MaternityTeamDesc, MPAT.EDC '
ELSE IF @srt = 'Status'	
	SELECT @sql = @sql + 'ORDER BY STAT.MaternityStatusDesc '
ELSE IF @srt = 'EDC'	
	SELECT @sql = @sql + 'ORDER BY MPAT.EDC '
ELSE IF @srt = 'FPProvider'	
	SELECT @sql = @sql + 'ORDER BY FPPRO.ProviderName '
ELSE IF @srt = ''
	SELECT @sql = @sql + 'ORDER BY PAT.FullName '
ELSE 
	SELECT @sql = @sql + 'ORDER BY PAT.FullName '
END	

BEGIN	
IF @dir = 0
	SELECT @sql = @sql + 'ASC '
ELSE
	SELECT @sql = @sql + 'DESC '
END

IF @debug = 1
	BEGIN
		PRINT @sql
		PRINT @mth
		PRINT @ball
		PRINT @fpro
		PRINT @tm
		PRINT @stat
		PRINT @srt
		PRINT @dir
	END
	
SELECT @paramlist = '@srt varchar(50),
			@dir int,
			@mth int,
			@ball bit,
			@fpro int,
			@tm int,
			@stat int '

EXEC sp_executesql	@sql, @paramlist, @srt, @dir, @mth, @ball, @fpro, @tm, @stat