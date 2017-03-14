CREATE PROCEDURE [dbo].[upDepartmentSelect20080128](
	@inactive	bit = 0,
	@desc		varchar(50) = '',
	@deptid	int = 0,
	@dir		int = 0,
	@debug	bit = 0
)
 AS

DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)

SELECT @sql = 'SELECT 
	D.DepartmentId,
	D.DCBILLET + '' ('' + DIR.ShortName + '') '' AS DepartmentName,
             	D.DepartmentCode,
            	D.Inactive,
            	D.DepartmentHeadId,
	TECH.EMailAddress,
	D.DirectorateId,
	D.DeptPhone,
	D.DeptFax,
	D.DeptPager
	FROM DEPARTMENT D
	LEFT OUTER  JOIN TECHNICIAN TECH
	ON D.DepartmentHeadId = TECH.UserId
	INNER JOIN DIRECTORATE DIR
	ON DIR.DirectorateId = D.DirectorateId
	WHERE 1 = 1 '

IF @inactive = 0
	SELECT @sql = @sql + 'AND D.Inactive = 0 '

IF @deptid > 0
	SELECT @sql = @sql + 'AND D.DepartmentId = @deptid '

IF @dir > 0
	SELECT @sql = @sql + 'AND D.DirectorateId = @dir '

IF LEN(@desc) > 0
	SELECT @sql = @sql + 'AND D.DCBillet = @desc '

SELECT @sql = @sql + 'ORDER BY D.DCBillet,DIR.SortOrder '

IF @debug = 1
	PRINT @sql
	PRINT @inactive

SELECT @paramlist = 	'@inactive bit,
			@desc varchar(50),
			@deptid int,
			@dir int'
			
EXEC sp_executesql	@sql, @paramlist, @inactive, @desc, @deptid, @dir
