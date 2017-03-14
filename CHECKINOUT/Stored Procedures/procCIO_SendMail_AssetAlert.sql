

CREATE PROCEDURE [dbo].[procCIO_SendMail_AssetAlert]
(
@Sub varchar(100) = '*** FOUO *** CIAO DEACTIVATION ALERT',
@Msg varchar(4000) = null,
@To varchar(200) = 'kristopher.s.kern.ctr@mail.mil',
@CC varchar(200) = '',
@BCC varchar(200) = ''
)
AS

--IF @To = 'sean.kern.ctr@med.navy.mil'
--	BEGIN
--		SET @BCC = 'craig.foreacre@med.navy.mil'
--	END
--ELSE
--	BEGIN
		SET @BCC = @CC
--	END

--IF dbo.MailStatus() = 'STOPPED'
--BEGIN
--	EXEC msdb.dbo.sysmail_start_sp
--END

EXEC msdb.dbo.sp_send_dbmail @profile_name = 'SQLCLUST',
	@recipients=@To,
	@blind_copy_recipients=@BCC,
	@subject=@Sub,
	@body=@Msg

PRINT @To
PRINT @CC
PRINT @Sub
PRINT @Msg


