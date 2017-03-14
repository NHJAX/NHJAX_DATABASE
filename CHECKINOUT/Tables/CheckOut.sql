CREATE TABLE [dbo].[CheckOut] (
    [CheckOutId]     BIGINT        IDENTITY (1, 1) NOT NULL,
    [UserId]         INT           CONSTRAINT [DF_CheckOut_UserId] DEFAULT ((0)) NOT NULL,
    [dtChkOut]       DATETIME      NOT NULL,
    [txtReturn]      NVARCHAR (50) NULL,
    [txtSurrTele]    NVARCHAR (50) NULL,
    [txtSurrResults] NVARCHAR (50) NULL,
    [StatusId]       INT           NULL,
    [CreatedDate]    DATETIME      CONSTRAINT [DF_CheckOut_CreatedDate_1] DEFAULT (getdate()) NULL,
    [CreatedBy]      INT           CONSTRAINT [DF_CheckOut_CreatedBy_1] DEFAULT ((0)) NULL,
    [ChkId]          INT           NULL,
    [OfficialDate]   DATETIME      NULL,
    [TransferDate]   DATETIME      NULL,
    [RetirementDate] DATETIME      NULL,
    [CheckListId]    INT           CONSTRAINT [DF_CheckOut_CheckListId] DEFAULT ((0)) NULL,
    [HasDMLSS]       BIT           CONSTRAINT [DF_CheckOut_HasDMLSS] DEFAULT ((0)) NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [IX_CHECKOUT_CheckOutId_PrimaryKey]
    ON [dbo].[CheckOut]([CheckOutId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_CHECKOUT_dtChkOut]
    ON [dbo].[CheckOut]([dtChkOut] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_CHECKOUT_UserId]
    ON [dbo].[CheckOut]([UserId] ASC);


GO
CREATE TRIGGER [dbo].[trCIAO_CheckOut_Insert_Tablet] ON [dbo].[CheckOut]
FOR INSERT
AS

DECLARE @tech int
DECLARE @dt datetime
DECLARE @name varchar(150)
DECLARE @net varchar(100)
DECLARE @ser varchar(50)
DECLARE @msg varchar(1500)
DECLARE @sub varchar(100)
DECLARE @To varchar(200)
DECLARE @CC varchar(200)
DECLARE @day varchar(2)
DECLARE @month varchar(2)
DECLARE @year varchar(4)
DECLARE @co varchar(10)

SELECT  @tech = UserId,
		@dt = dtChkOut
FROM inserted

SET @co = CAST(MONTH(@dt) AS varchar(2)) + '/' + CAST(DAY(@dt) AS varchar(2)) + '/' + CAST(YEAR(@dt) AS varchar(4))
	
	DECLARE cur CURSOR FAST_FORWARD FOR
	SELECT 
		TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName, 
		AST.NetworkName, 
		AST.SerialNumber
	FROM  dbo.vwENET_TECHNICIAN AS TECH 
		INNER JOIN dbo.vwENET_ASSET_ASSIGNMENT AS ASG 
		ON TECH.UserId = ASG.AssignedTo 
		INNER JOIN dbo.vwENET_ASSET AS AST 
		ON ASG.AssetId = AST.AssetId
	WHERE (TECH.UserId = @tech) 
		AND (AST.AssetSubtypeId IN (3, 4)) 
		AND (AST.DispositionId IN (0, 1, 14, 15, 19, 20)) 
		AND (ASG.PrimaryUser = 1)

	OPEN cur

	FETCH NEXT FROM cur INTO @name, @net, @ser
	IF(@@FETCH_STATUS = 0)
		BEGIN

			WHILE(@@FETCH_STATUS = 0)
			BEGIN

				--Send Mail 
				SET @To = 'tommy.robinson@med.navy.mil'
				SET @Sub = 'CIAO CHECKOUT ALERT'
				SET @CC = 'sean.kern@med.navy.mil'
				SET @Msg = 'This user has been assigned a portable asset and is scheduled to check out: '

				SET @Msg = @Msg + CHAR(13) + CHAR(13)
				SET @Msg = @Msg + 'USER:'+ CHAR(9) + CHAR(9) + CHAR(9)
				SET @Msg = @Msg + @name

				SET @Msg = @Msg + CHAR(13)
				SET @Msg = @Msg + 'CheckOut Date:'+ CHAR(9) 
				SET @Msg = @Msg + @co

				SET @Msg = @Msg + CHAR(13)
				SET @Msg = @Msg + 'Network Name:'+ CHAR(9) 
				SET @Msg = @Msg + @net

				SET @Msg = @Msg + CHAR(13)
				SET @Msg = @Msg + 'Serial Number:'+ CHAR(9)
				SET @Msg = @Msg + @ser
	
				SET @Msg = @Msg + CHAR(13) + CHAR(13)
				SET @Msg = @Msg + 'Please review this information for accuracy.  '
				SET @Msg = @Msg + 'If you find any errors in this alert, '
				SET @Msg = @Msg + 'please contact MID at 542-7577 '
				SET @Msg = @Msg + 'or put in a Help Desk Ticket at: ' + CHAR(13) + CHAR(13)
				SET @Msg = @Msg + 'https://nhjax-webapps/enet/default.aspx'

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
				SET @Msg = @Msg + 'User:' + CHAR(9)
				SET @Msg = @Msg + CAST(@tech AS varchar(10))

				EXEC ENET.dbo.procENET_SendMail_AssetAlert @sub, @msg, @To, @CC
			
				FETCH NEXT FROM cur INTO @name, @net, @ser
			END
		END
		CLOSE cur
		DEALLOCATE cur
			
