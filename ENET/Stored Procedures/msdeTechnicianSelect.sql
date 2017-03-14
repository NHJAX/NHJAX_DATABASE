CREATE PROCEDURE [dbo].[msdeTechnicianSelect](
	@user 		int = 0,
	@inactive 	bit = 0,
	@debug	bit = 0
)
AS
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT     
	Tech.UserId, 
	RTRIM(Tech.UFName) AS UFName, 
	RTRIM(Tech.ULName) AS ULName, 
	RTRIM(Tech.UMName) AS UMName, 
	Tech.LoginId,
	Tech.Title, 
    Tech.EMailAddress, 
	Tech.AudienceId, 
	Dept.DCBILLET, 
	Tech.Location, 
	Tech.LastFour, 
	Tech.UPhone, 
	Tech.Extension, 
	Tech.UPager, 
	Tech.AltPhone, 
    Tech.Inactive, 
	Tech.Comments, 
	Tech.SecurityLevelId,  
	BASE.BaseCode,
	Tech.Suffix
FROM   BASE 
	INNER JOIN AUDIENCE Aud 
	ON BASE.BaseId = Aud.BaseId 
	RIGHT OUTER JOIN TECHNICIAN Tech 
	ON Aud.AudienceId = Tech.AudienceId
WHERE
	1 = 1 '

IF @inactive = 0
	SELECT @sql = @sql + 'AND Tech.Inactive = 0 '

IF @user > 0
	SELECT @sql = @sql + 'AND Tech.UserId = @user '

SELECT @sql = @sql + 'ORDER BY Tech.ULName, Tech.UFName, Tech.UMName '

IF @debug = 1
	PRINT @sql
	PRINT @user
	PRINT @inactive

SELECT @paramlist = 	'@user int,
			@inactive bit'
			
EXEC sp_executesql	@sql, @paramlist, @user, @inactive
