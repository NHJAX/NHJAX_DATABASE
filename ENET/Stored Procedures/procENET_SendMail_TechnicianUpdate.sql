




CREATE PROCEDURE [dbo].[procENET_SendMail_TechnicianUpdate]
(
@Sub varchar(100) = '*** FOUO *** ENET PERSONNEL UPDATE',
@Msg varchar(4000) = null,
@To varchar(2000) = 'kristopher.s.kern.ctr@mail.mil',
@CC varchar(200) = '',
@BCC varchar(200) = ''
)
AS

IF @To = 'kristopher.s.kern.ctr@mail.mil'
	BEGIN
		SET @BCC = 'kristopher.s.kern.ctr@mail.mil'
	END
ELSE
	BEGIN
		SET @BCC = 'kristopher.s.kern.ctr@mail.mil'
	END
	
--IF dbo.MailStatus() = 'STOPPED'
--BEGIN
--	EXEC msdb.dbo.sysmail_start_sp
--END
/********************************************************
*June 24 2014, changed @profile_name = 'SQLCLUST2'
*              to read @profile_name = 'SQLCLUST'
*********************************************************/
EXEC msdb.dbo.sp_send_dbmail @profile_name = 'SQLCLUST',
	@recipients=@To,
	@copy_recipients=@CC,
	@blind_copy_recipients=@BCC,
	@subject=@Sub,
	@body=@Msg

PRINT @To
PRINT @CC
PRINT @Sub
PRINT @Msg


