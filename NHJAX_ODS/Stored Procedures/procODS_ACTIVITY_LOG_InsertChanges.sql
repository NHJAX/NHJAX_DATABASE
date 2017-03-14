create PROCEDURE [dbo].[procODS_ACTIVITY_LOG_InsertChanges]
AS

BEGIN
	DECLARE @command varchar(4000) 
	SELECT @command = 'USE ? INSERT INTO NHJAX_ODS.dbo.ACTIVITY_LOG
	(LogDescription, ErrorNumber)
	SELECT ''?'' + '' '' + [name] + '' '' 
		+ CAST(modify_date AS varchar(50)) + '' '' + type, 
		1000 
	FROM sys.objects 
	WHERE modify_date > DATEADD(HOUR, -30, getdate())' 
	EXEC sp_MSforeachdb @command 
END