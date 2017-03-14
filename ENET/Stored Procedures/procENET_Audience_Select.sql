CREATE PROCEDURE [dbo].[procENET_Audience_Select](
	@inactive	bit = 0,
	@desc		varchar(50) = '',
	@aud		bigint = 0,
	@dir		bigint = 0,
	@debug		bit = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT
	AUD.AudienceId, 
	AUD.AudienceDesc, 
	AUD.DisplayName, 
	AUD.OrgChartCode, 
	AUD.ReportsUnder, 
	AUD.IsSubGroup, 
	AUD.CreatedDate, 
	AUD.UpdatedDate, 
	AUD.CreatedBy, 
	AUD.UpdatedBy, 
	AUD.AudienceCategoryId, 
	AUD.AudiencePhone, 
	AUD.AudienceFax, 
	AUD.AudiencePager, 
	AUD.Inactive, 
	AUD.OldDepartmentId, 
	AUD.SecurityGroupId, 
	AUD.BaseId, 
	ISNULL(TECH.UserId, 0) AS HeadId, 
	ISNULL(TECH.EMailAddress, '') AS HeadEMail
FROM
	TECHNICIAN AS TECH 
	INNER JOIN vwAudienceMemberDepartmentHeads AS AH 
	ON TECH.UserId = AH.TechnicianId 
	RIGHT OUTER JOIN AUDIENCE AS AUD 
	ON AH.AudienceId = AUD.ReportsUnder
WHERE  (AUD.AudienceCategoryId IN (1,2,3,7)) 
	AND DataLength(AUD.DisplayName) > 0'

IF @inactive = 0
	SELECT @sql = @sql + 'AND AUD.Inactive = 0 '

IF @aud > 0
	SELECT @sql = @sql + 'AND AUD.AudienceId = @aud '

IF @dir > 0
	SELECT @sql = @sql + 'AND AUD.ReportsUnder = @dir '

IF DataLength(@desc) > 0
	SELECT @sql = @sql + 'AND AUD.AudienceDesc = @desc '

SELECT @sql = @sql + 'ORDER BY AUD.SortOrder, AUD.DisplayName '

IF @debug = 1
	PRINT @sql
	PRINT @inactive

SELECT @paramlist = 	
			'@inactive bit,
			@desc varchar(50),
			@aud bigint,
			@dir bigint,'
			
EXEC sp_executesql	@sql, @paramlist, @inactive, @desc, @aud, @dir


