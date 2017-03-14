
CREATE PROCEDURE [dbo].[upSendMail2005]
@From varchar(100) = '',
@To varchar(200) = '',
@Subject varchar(100) = '***FOUO*** SQL Server Error',
@Body varchar(4000) = null,
@CC varchar(200)  = '',
@BCC varchar(100) = null
AS
Declare @MailID int
Declare @hr int
Declare @sendto varchar(100)
Declare @sendcc varchar(100)

EXEC @hr = sp_OACreate 'CDONTS.NewMail', @MailID OUT

IF DataLength(@From) < 1
	EXEC @hr = sp_OASetProperty @MailID, 'From', 'nhjax.sqlclust@sar.med.navy.mil'
ELSE
	EXEC @hr = sp_OASetProperty @MailID, 'From',@From

EXEC @hr = sp_OASetProperty @MailID, 'Body', @Body

EXEC @hr = sp_OASetProperty @MailID, 'BCC',@BCC

IF DataLength(@CC) < 1
	BEGIN
	SELECT @sendcc = BackupEmailAddress FROM EMAIL
	EXEC @hr = sp_OASetProperty @MailID, 'CC', @sendcc
	END
ELSE
	EXEC @hr = sp_OASetProperty @MailID, 'CC', @CC

IF DataLength(@Subject) < 1
	EXEC @hr = sp_OASetProperty @MailID, 'Subject', '***FOUO*** SQL Server Error Occurred'
ELSE
	EXEC @hr = sp_OASetProperty @MailID, 'Subject', @Subject

IF DataLength(@To) < 1
	BEGIN
	SELECT @sendto = PrimaryEmailAddress FROM EMAIL
	EXEC @hr = sp_OASetProperty @MailID, 'To', @sendto
	END
ELSE
	EXEC @hr = sp_OASetProperty @MailID, 'To', @To

EXEC @hr = sp_OAMethod @MailID, 'Send', NULL
EXEC @hr = sp_OADestroy @MailID


PRINT @From
PRINT DataLength(@From)
PRINT @To
PRINT @sendto
PRINT @CC
PRINT @sendcc
PRINT @Subject
PRINT @Body
