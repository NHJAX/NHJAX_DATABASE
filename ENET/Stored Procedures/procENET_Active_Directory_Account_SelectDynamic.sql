CREATE PROCEDURE [dbo].[procENET_Active_Directory_Account_SelectDynamic]
(
	@ball bit,
	@bsvc bit,
	@bcomp bit,
	@bsig bit,
	@bsup bit,
	@blb bit,
	@bpsq bit,
	@lname varchar(50) = '',
	@bmis bit,
	@bhid bit,
	@bexp bit = 0,
	@debug	bit = 0
)
 AS
--****
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT DISTINCT 
	ADA.ActiveDirectoryAccountId, 
	ADA.DisplayName, 
	ADA.LastName, 
	ADA.FirstName, 
	ADA.MiddleName, 
	ADA.Description, 
	ISNULL(ISNULL(DIR.DisplayName, ADA.DirectorateDesc), N''Unknown'') AS DirectorateDesc, 
	ADA.LoginID, 
	ISNULL(ISNULL(AUD.DisplayName, ADA.AudienceDesc), N''Unknown'') AS AudienceDesc, 
	ADA.ADExpiresDate, 
	ADA.ADLoginDate, 
	ADA.Inactive, 
	ADA.ADCreatedDate, 
	CAST(ADA.Remarks AS varchar(4000)) AS Expr1, 
	ADA.SignedDate, 
	ADA.SupervisorSignedDate, 
	ADA.LBDate, 
	ADA.PSQDate, 
	ADA.CompletedDate, 
	ADA.ServiceAccount, 
	TECH.UserId, 
	ADA.SSN, 
	ADA.ENetStatus, 
	ADA.LastReportedDate, 
	ADA.IsHidden, 
	ISNULL(TECH.DesignationId, 0) AS Expr2, 
	ADA.SecurityStatusId,
	ADA.Title,
	ADA.DoDEDI,
	ADA.distinguishedName
FROM AUDIENCE AS AUD 
	INNER JOIN TECHNICIAN AS TECH 
	ON AUD.AudienceId = TECH.AudienceId 
	INNER JOIN vwENET_Audience_Directorate AS AUDDIR 
	ON AUD.AudienceId = AUDDIR.AudienceId 
	INNER JOIN AUDIENCE AS DIR 
	ON AUDDIR.DirectorateId = DIR.AudienceId 
	RIGHT OUTER JOIN ACTIVE_DIRECTORY_ACCOUNT AS ADA 
	ON TECH.LoginId = ADA.LoginID
WHERE     (1 = 1) '

IF @lname <> ''
BEGIN
SELECT @sql = @sql + 'AND ADA.LastName LIKE ''' + @lname + '%'' '
END

IF @ball = 0
	SELECT @sql = @sql + 'AND ADA.Inactive = 0 '

IF @bsvc = 0
	SELECT @sql = @sql + 'AND ADA.ServiceAccount = 0 '

IF @bhid = 0
	SELECT @sql = @sql + 'AND ADA.IsHidden = 0 '

IF @bcomp = 0
	BEGIN
		SELECT @sql = @sql + 'AND ADA.CompletedDate < ''7/4/1776'' '
	END

IF @bsig = 0
	BEGIN
		SELECT @sql = @sql + 'AND ADA.SignedDate < ''7/4/1776'' '
	END

IF @bsup = 0
	BEGIN
		SELECT @sql = @sql + 'AND ADA.SupervisorSignedDate < ''7/4/1776'' '
	END

IF @blb = 0
	BEGIN
		SELECT @sql = @sql + 'AND ADA.LBDate < ''7/4/1776'' '
	END

IF @bpsq = 0
	BEGIN
		SELECT @sql = @sql + 'AND ADA.PSQDate < ''7/4/1776'' '
	END

IF @bmis = 0
	BEGIN
	SELECT @sql = @sql + 'AND datediff(day,ada.lastreporteddate,(SELECT TOP 1 LastReportedDate FROM dbo.vwENET_ACTIVE_DIRECTORY_ACCOUNT_LastReportedDate)) < 3 '
	END

IF @bexp = 0
	BEGIN
	SELECT @sql = @sql + 'AND datediff(day,ada.ADExpiresdate,getdate()) < 3 '
	END

IF @bcomp = 1 
	BEGIN
		IF @lname = ''
		BEGIN
			SELECT @sql = @sql + 'OR ADA.CompletedDate > ''1/1/1776'' '
		END
		ELSE
		BEGIN
			SELECT @sql = @sql + 'OR (ADA.CompletedDate > ''1/1/1776'' '
			SELECT @sql = @sql + 'AND ADA.LastName LIKE ''' + @lname + '%'') '
		END
	END

IF @bsig = 1 
	BEGIN
		IF @lname = ''
		BEGIN
			SELECT @sql = @sql + 'OR ADA.SignedDate > ''1/1/1776'' '
		END
		ELSE
		BEGIN
			SELECT @sql = @sql + 'OR (ADA.SignedDate > ''1/1/1776'' '
			SELECT @sql = @sql + 'AND ADA.LastName LIKE ''' + @lname + '%'') '
		END
	END

IF @bsup = 1 
	BEGIN
		IF @lname = ''
		BEGIN
			SELECT @sql = @sql + 'OR ADA.SupervisorSignedDate > ''1/1/1776'' '
		END
		ELSE
		BEGIN
			SELECT @sql = @sql + 'OR (ADA.SupervisorSignedDate > ''1/1/1776'' '
			SELECT @sql = @sql + 'AND ADA.LastName LIKE ''' + @lname + '%'') '
		END
	END

IF @blb = 1 
	BEGIN
		IF @lname = ''
		BEGIN
			SELECT @sql = @sql + 'OR ADA.LBDate > ''1/1/1776'' '
		END
		ELSE
		BEGIN
			SELECT @sql = @sql + 'OR (ADA.LBDate > ''1/1/1776'' '
			SELECT @sql = @sql + 'AND ADA.LastName LIKE ''' + @lname + '%'') '
		END
	END

IF @bpsq = 1 
	BEGIN
		IF @lname = ''
		BEGIN
			SELECT @sql = @sql + 'OR ADA.PSQDate > ''1/1/1776'' '
		END
		ELSE
		BEGIN
			SELECT @sql = @sql + 'OR (ADA.PSQDate > ''1/1/1776'' '
			SELECT @sql = @sql + 'AND ADA.LastName LIKE ''' + @lname + '%'') '
		END
	END

IF @debug = 1
	PRINT @sql
	PRINT @ball
	PRINT @bsvc
	PRINT @bcomp
	PRINT @bsig
	PRINT @bsup
	PRINT @blb
	PRINT @bpsq
	PRINT @lname
	PRINT @bmis
	PRINT @bhid
	PRINT @bexp


SELECT @paramlist = 	'@ball bit,
						@bsvc bit,
						@bcomp bit,
						@bsig bit,
						@bsup bit,
						@blb bit,
						@bpsq bit,
						@lname varchar(50),
						@bmis bit,
						@bhid bit,
						@bexp bit'
			
EXEC sp_executesql	@sql, @paramlist, @ball, @bsvc, @bcomp, @bsig, 
			@bsup, @blb, @bpsq, @lname, @bmis, @bhid, @bexp



