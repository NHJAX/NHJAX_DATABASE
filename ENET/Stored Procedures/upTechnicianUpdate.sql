CREATE PROCEDURE [dbo].[upTechnicianUpdate]
(
	@user		int,
	@fname	varchar(50),
	@lname		varchar(50),
	@mname	varchar(50),
	@title		varchar(50),
	@email		varchar(250),
	@dept		int,
	@location	varchar(100),
	@login		varchar(50),
	@phone	varchar(50),
	@extension	varchar(10),
	@pager		varchar(50),
	@updatedby	int,
	@updateddate	datetime,
	@inactive	bit = 0,
	@ssn		varchar(11) = '',
	@comments	varchar(8000)='',
	@seclvl		int = 0,
	@alt		varchar(50)='',
	@debug	bit = 0,
	@dod		nvarchar(10) = ''
)
 AS
DECLARE	
	@sql		nvarchar(4000),
	@paramlist	nvarchar(4000)
SELECT @sql = 'UPDATE TECHNICIAN SET
			UFName = @fname,
			ULName = @lname,
			UMName = @mname, 
               		Title = @title, 
                		EMailAddress = @email, 
			DepartmentId = @dept,
			Location = @location,
			LoginId = @login,
			UPhone = @phone,
			Extension = @extension,
			UPager = @pager, 
			Inactive = @inactive, '

IF DataLength(@ssn) > 0
	SELECT @sql = @sql + 'SSN = @ssn, '

IF DataLength(@comments) > 0
	SELECT @sql = @sql + 'Comments = @comments, '
		
IF @seclvl > 0
	SELECT @sql = @sql + 'SecurityLevelId = @seclvl, '

IF DataLength(@alt) > 0
	SELECT @sql = @sql + 'AltPhone = @alt, '

SELECT @sql = @sql + 'UpdatedBy = @updatedby, 
			UpdatedDate = @updateddate,
			DoDEDI = @dod
			WHERE UserId = @user '

IF @debug = 1
	PRINT @sql
	PRINT @ssn
	PRINT @comments
	PRINT @seclvl
	PRINT @alt
	PRINT @user

SELECT @paramlist = 	'@user		int,
			@fname	varchar(50),
			@lname		varchar(50),
			@mname	varchar(50),
			@title		varchar(50),
			@email		varchar(250),
			@dept		int,
			@location	varchar(100),
			@login		varchar(50),
			@phone	varchar(50),
			@extension	varchar(10),
			@pager		varchar(50),
			@updatedby	int,
			@updateddate	datetime,
			@inactive	bit,
			@ssn		varchar(11),
			@comments	varchar(8000),
			@seclvl		int = 0,
			@alt		varchar(50),
			@dod		bigint = 0'

EXEC sp_executesql	@sql, @paramlist, @user,@fname,@lname,@mname,@title,@email,@dept,@location,@login,@phone,@extension,
			@pager,@updatedby,@updateddate,@inactive,@ssn,@comments,@seclvl,@alt,@dod
