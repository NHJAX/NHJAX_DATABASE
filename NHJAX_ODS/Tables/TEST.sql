CREATE TABLE [dbo].[TEST] (
    [TestId]      BIGINT       IDENTITY (1, 1) NOT NULL,
    [TestDesc]    VARCHAR (50) NULL,
    [CreatedDate] DATETIME     CONSTRAINT [DF_TEST_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_TEST] PRIMARY KEY CLUSTERED ([TestId] ASC)
);


GO



CREATE TRIGGER [dbo].[EDPTS_Patient_TEST_TESTNotification]
   ON  [dbo].[TEST]
   FOR INSERT,UPDATE
AS 
DECLARE @id bigint
DECLARE @desc varchar(50)
DECLARE @dt datetime
DECLARE @msg varchar(1500)
DECLARE @sub varchar(150)
DECLARE @pcmMail varchar(100)


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT @id = TestId, 
		@desc = TestDesc, 
		@dt = CreatedDate 
	FROM inserted

	--SET @loc = 174
	--SET @pe = 2702356


--Send Mail if ER visit from CHCS/EDPTS
--If @loc = 174 AND (@src < 7 OR @src IS NULL OR @src=9)
	BEGIN
	
		--Gather Data about ER Visit
		

		--Set default for pcmMail
		SET @sub = 'TEST'
		SET @pcmMail = ''
		If @pcmMail = ''
			BEGIN
				SET @pcmMail = 'henry.highfill.ctr@med.navy.mil'
			END
		
		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + CAST(@id AS varchar(100))
		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + CAST(@desc AS varchar(100))
		SET @Msg = @Msg + CHAR(13)
		SET @Msg = @Msg + CAST(@dt AS varchar(100))
		
		--PRINT @flag

		
			BEGIN
				EXEC dbo.upActivityLog 'Send Mail',5
				EXEC dbo.upSendMail @sub, @msg, @pcmMail
			END
	END
END









GO
DISABLE TRIGGER [dbo].[EDPTS_Patient_TEST_TESTNotification]
    ON [dbo].[TEST];

