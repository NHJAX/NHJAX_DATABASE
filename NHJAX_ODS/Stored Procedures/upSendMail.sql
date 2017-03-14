




CREATE PROCEDURE [dbo].[upSendMail]
(
@Sub varchar(100) = '***FOUO*** SQL Server Error - ODS',
@Msg varchar(4000) = null,
@To varchar(200) = 'kristopher.s.kern.ctr@mail.mil',
@CC varchar(200) = 'kristopher.s.kern.ctr@mail.mil'
)
AS

IF dbo.MailStatus() = 'STOPPED'
BEGIN
	EXEC msdb.dbo.sysmail_start_sp
END

IF @To = 'kristopher.s.kern.ctr@mail.mil'
	BEGIN
		SET @CC = 'kristopher.s.kern.ctr@mail.mil'
	END
ELSE
	BEGIN
		SET @CC = 'kristopher.s.kern.ctr@mail.mil'
	END

EXEC msdb.dbo.sp_send_dbmail @profile_name = 'SQLCLUST',
	@recipients=@To,
	@blind_copy_recipients=@CC,
	@subject=@Sub,
	@body=@Msg

PRINT @To
PRINT @CC
PRINT @Sub
PRINT @Msg

/*

Declare @MailID int
Declare @hr int
Declare @sendto varchar(100)
Declare @sendcc varchar(100)

EXEC @hr = sp_OACreate 'CDONTS.NewMail', @MailID OUT

IF LEN(@From) < 1
	EXEC @hr = sp_OASetProperty @MailID, 'From', 'nhjax.sqlclust@sar.med.navy.mil'
ELSE
	EXEC @hr = sp_OASetProperty @MailID, 'From',@From

EXEC @hr = sp_OASetProperty @MailID, 'Body', @Body

EXEC @hr = sp_OASetProperty @MailID, 'BCC',@BCC

IF LEN(@CC) < 1
	BEGIN
	SELECT @sendcc = BackupEmailAddress FROM EMAIL
	EXEC @hr = sp_OASetProperty @MailID, 'CC', @sendcc
	END
ELSE
	EXEC @hr = sp_OASetProperty @MailID, 'CC', @CC

IF LEN(@Subject) < 1
	EXEC @hr = sp_OASetProperty @MailID, 'Subject', 'SQL Server Error Occurred'
ELSE
	EXEC @hr = sp_OASetProperty @MailID, 'Subject', @Subject

IF LEN(@To) < 1
	BEGIN
	SELECT @sendto = PrimaryEmailAddress FROM EMAIL
	EXEC @hr = sp_OASetProperty @MailID, 'To', @sendto
	END
ELSE
	EXEC @hr = sp_OASetProperty @MailID, 'To', @To

EXEC @hr = sp_OAMethod @MailID, 'Send', NULL
EXEC @hr = sp_OADestroy @MailID
*/



