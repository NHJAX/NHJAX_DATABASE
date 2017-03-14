CREATE TABLE [dbo].[ACTIVITY_LOG] (
    [LogId]          INT            IDENTITY (1, 1) NOT NULL,
    [LogDescription] VARCHAR (8000) NULL,
    [CreatedDate]    DATETIME       CONSTRAINT [DF_ACTIVITY_LOG_CreatedDate] DEFAULT (getdate()) NULL,
    [Corrected]      INT            CONSTRAINT [DF_ACTIVITY_LOG_Corrected] DEFAULT ((0)) NULL,
    [UpdatedDate]    DATETIME       CONSTRAINT [DF_ACTIVITY_LOG_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]      INT            CONSTRAINT [DF_ACTIVITY_LOG_UpdatedBy] DEFAULT ((0)) NULL,
    [ErrorNumber]    BIGINT         CONSTRAINT [DF_ACTIVITY_LOG_ErrorNumber] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ACTIVITY_LOG] PRIMARY KEY CLUSTERED ([LogId] ASC)
);


GO
CREATE TRIGGER [dbo].[ENET_Activity_Log]
   ON  [dbo].[ACTIVITY_LOG]
   FOR INSERT
AS 
DECLARE @log varchar(5000)
DECLARE @id int
DECLARE @msg varchar(8000)
DECLARE @sub varchar(100)
DECLARE @To varchar(200)
DECLARE @CC varchar(200)

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT @log = LogDescription,
	@id = LogId
FROM inserted


		SET @To = 'kristopher.s.kern.ctr@mail.mil'
		SET @Sub = '*** FOUO ***ENET ACTIVITY LOG'
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

		IF LEN(@msg) > 0
		BEGIN
		EXEC dbo.procENET_SendMail_ActivityLog @sub, @msg, @To
		END

END


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create TRIGGER [dbo].[trgActivityLogInsert]
	ON [dbo].[ACTIVITY_LOG]
	FOR INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	UPDATE ACTIVITY_LOG
	SET Corrected = 1, UpdatedBy = 1
	WHERE (LogDescription LIKE 'Begin ENet XFR%'
	OR LogDescription LIKE 'End ENet XFR%'
	OR LogDescription LIKE 'Begin SUS%'
	OR LogDescription LIKE 'Fetch SUS%'
	OR LogDescription LIKE 'End SUS%'
	OR LogDescription LIKE 'SUS Updated%'
	OR LogDescription LIKE 'SUS Inserted%'
	OR LogDescription LIKE 'SUS Total%'
	OR LogDescription LIKE 'End SUS%')
	AND Corrected = 0

END

