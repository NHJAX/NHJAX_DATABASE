CREATE PROCEDURE [dbo].[upAIM_TechnicianSelect](
	@user		int = 0,
	@login		varchar(50) = '',
	@debug	bit = 0
)
 AS
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)
SELECT @sql = 'SELECT Tech.UserId,
			UPPER(RTRIM(Tech.UFName)) AS UFName,
			UPPER(RTRIM(Tech.ULName)) AS ULName,
			UPPER(RTRIM(Tech.UMName)) AS UMName,
			UPPER(Tech.Title) AS Title,
			Tech.EMailAddress,
			Tech.DepartmentId,
			UPPER(Dept.DCBILLET) AS DCBILLET,
			Tech.Location,
			Tech.UPhone,
			Tech.Extension,
			Tech.UPager,
			Tech.Inactive,
			Tech.LoginId,
			Tech.UpdatedDate,
			Tech.SSN,
			Tech.Suffix,
			Tech.DoDEDI
		FROM TECHNICIAN Tech
			LEFT JOIN DEPARTMENT Dept 
			ON Tech.DepartmentId = Dept.DepartmentId
		WHERE 
			1 = 1 '

IF @user > 0
	SELECT @sql = @sql + 'AND Tech.UserId = @user '

IF DataLength(@login) > 0
	SELECT @sql = @sql + 'AND Tech.LoginId = @login '

SELECT @sql = @sql + 'ORDER BY Tech.SortOrder, Tech.ULName, Tech.UFName, Tech.UMName '

IF @debug = 1
	PRINT @sql
	
SELECT @paramlist = 	'@user int,
			@login varchar(50)'
			
EXEC sp_executesql	@sql, @paramlist, @user, @login
