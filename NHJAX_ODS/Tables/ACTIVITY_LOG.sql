CREATE TABLE [dbo].[ACTIVITY_LOG] (
    [LogId]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [LogDescription] VARCHAR (MAX) NULL,
    [CreatedDate]    DATETIME      CONSTRAINT [DF_ACTIVITY_LOG_CreatedDate] DEFAULT (getdate()) NULL,
    [DayofWeek]      INT           CONSTRAINT [DF_ACTIVITY_LOG_DayofWeek] DEFAULT (datepart(weekday,getdate())) NULL,
    [ErrorNumber]    INT           NULL,
    CONSTRAINT [PK_ACTIVITY_LOG] PRIMARY KEY NONCLUSTERED ([LogId] ASC)
);


GO
CREATE CLUSTERED INDEX [IX_ACTIVITY_LOG_CreatedDate]
    ON [dbo].[ACTIVITY_LOG]([CreatedDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ACTIVITY_LOG_DayofWeek]
    ON [dbo].[ACTIVITY_LOG]([DayofWeek] ASC);


GO
CREATE TRIGGER [dbo].[ODS_Activity_Log]
   ON  [dbo].[ACTIVITY_LOG]
   FOR INSERT
AS 
DECLARE @log varchar(5000)
DECLARE @id int
DECLARE @err int
DECLARE @msg varchar(8000)
DECLARE @sub varchar(100)
DECLARE @To varchar(200)
DECLARE @CC varchar(200)

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT @log = LogDescription,
	@id = LogId,
	@err = ErrorNumber
FROM inserted

IF @err = 1000
BEGIN

		SET @To = 'kristopher.s.kern.ctr@mail.mil'
		SET @Sub = '***FOUO*** ODS ACTIVITY LOG'
		SET @Msg = @log
		
		SET @Msg = @Msg + CHAR(13) + CHAR(13)
		SET @Msg = @Msg + 'Please review this information for accuracy.  '
		SET @Msg = @Msg + 'If you find any errors in this alert, '
		SET @Msg = @Msg + 'please contact MID at 542-7577 '
		SET @Msg = @Msg + 'or put in a Help Desk Ticket at: ' + CHAR(13) + CHAR(13)
		SET @Msg = @Msg + 'https://nhjax-webapps-01/enet/default.aspx'

		SET @Msg = @Msg + CHAR(13) + CHAR(13)
		SET @Msg = @Msg + 'This electronic mail and any attachments may '
		SET @Msg = @Msg + 'contain information that is subject to the '
		SET @Msg = @Msg + 'Privacy Act of 1974 and the Health Insurance '
		SET @Msg = @Msg + 'Portability and Accountability Act (HIPAA) of 1996. '
		SET @Msg = @Msg + 'Use and disclosure of protected health '
		SET @Msg = @Msg + 'information is for OFFICIAL USE ONLY, '
		SET @Msg = @Msg + 'and must be in compliance with these statutes. '
		SET @Msg = @Msg + 'If you have inadvertently received this e-mail, '
		SET @Msg = @Msg + 'please notify the sender and delete the data '
		SET @Msg = @Msg + 'without forwarding it or making any copies.'

		--TESTING ONLY - Display Database Info
		SET @Msg = @Msg + CHAR(13) + CHAR(13)
		SET @Msg = @Msg + '****OFFICE USE****' + CHAR(13)
		SET @Msg = @Msg + 'LogId:' + CHAR(9)
		SET @Msg = @Msg + CAST(@id	AS varchar(10))

		EXEC dbo.upSendMail @sub, @msg, @To
END

END

