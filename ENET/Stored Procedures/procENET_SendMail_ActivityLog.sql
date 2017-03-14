




CREATE PROCEDURE [dbo].[procENET_SendMail_ActivityLog]
(
@Sub varchar(100) = '*** FOUO *** ENET ACTIVITY LOG',
@Msg varchar(4000) = null,
@To varchar(200) = 'kristopher.s.kern.ctr@mail.mil',
@CC varchar(200) = ''
)
AS

/*IF @To = 'sean.kern.ctr@med.navy.mil'
	BEGIN
		SET @CC = 'craig.foreacre@med.navy.mil'
	END
ELSE
	BEGIN
		SET @CC = 'sean.kern.ctr@med.navy.mil'
	END
*/

--IF dbo.MailStatus() = 'STOPPED'
--BEGIN
--	EXEC msdb.dbo.sysmail_start_sp
--END

EXEC msdb.dbo.sp_send_dbmail @profile_name = 'SQLCLUST',
	@recipients=@To,
	@blind_copy_recipients=@CC,
	@subject=@Sub,
	@body=@Msg

PRINT @To
PRINT @CC
PRINT @Sub
PRINT @Msg


