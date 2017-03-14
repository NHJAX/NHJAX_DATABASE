CREATE PROCEDURE [dbo].[procENET_TECHNICIAN_Update]
(
	@usr		int,
	@fname		varchar(50),
	@lname		varchar(50),
	@mname		varchar(50),
	@title		varchar(50),
	@email		varchar(100),
	@aud		bigint,
	@loc		varchar(100),
	@login		varchar(50),
	@ph			varchar(50),
	@ext		varchar(10),
	@pager		varchar(50),
	@uby		int,
	@udate		datetime,
	@inactive	bit = 0,
	@ssn		varchar(11) = '',
	@comm		varchar(5000)='',
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
			AudienceId = @aud,
			Location = @loc,
			LoginId = @login,
			UPhone = @ph,
			Extension = @ext,
			UPager = @pager, 
			Inactive = @inactive, '

IF DataLength(@ssn) > 0
	SELECT @sql = @sql + 'SSN = @ssn, '

IF DataLength(@comm) > 0
	SELECT @sql = @sql + 'Comments = @comm, '
		
IF DataLength(@alt) > 0
	SELECT @sql = @sql + 'AltPhone = @alt, '

SELECT @sql = @sql + 'UpdatedBy = @uby, 
			UpdatedDate = @udate,
			DoDEDI = @dod
			WHERE UserId = @usr '

IF @debug = 1
	PRINT @sql
	PRINT @ssn
	PRINT @comm
	PRINT @alt
	PRINT @usr
	PRINT @dod

SELECT @paramlist = 	'@usr		int,
			@fname		varchar(50),
			@lname		varchar(50),
			@mname		varchar(50),
			@title		varchar(50),
			@email		varchar(100),
			@aud		bigint,
			@loc		varchar(100),
			@login		varchar(50),
			@ph			varchar(50),
			@ext		varchar(10),
			@pager		varchar(50),
			@uby		int,
			@udate		datetime,
			@inactive	bit,
			@ssn		varchar(11),
			@comm		varchar(5000),
			@alt		varchar(50),
			@dod		bigint'

EXEC sp_executesql	@sql, @paramlist, @usr,@fname,@lname,@mname,@title,@email,@aud,@loc,@login,@ph,@ext,
			@pager,@uby,@udate,@inactive,@ssn,@comm,@alt,@dod



