CREATE TABLE [dbo].[CHECK_OUT] (
    [CheckOutId]           INT            IDENTITY (1, 1) NOT NULL,
    [UserId]               INT            NULL,
    [CheckOutDate]         DATETIME       NULL,
    [TerminalLeaveEnds]    DATETIME       NULL,
    [IsCredentialed]       BIT            CONSTRAINT [DF_CHECK_OUT_IsCredentialed] DEFAULT ((0)) NULL,
    [ImmediateCheckOut]    BIT            CONSTRAINT [DF_CHECK_OUT_ImmediateCheckOut] DEFAULT ((0)) NULL,
    [TransferringLocation] VARCHAR (50)   NULL,
    [CheckOutReasonId]     INT            CONSTRAINT [DF_CHECK_OUT_CheckOutReasonId] DEFAULT ((0)) NULL,
    [Surrogate]            VARCHAR (150)  NULL,
    [CheckOutStatusId]     INT            CONSTRAINT [DF_CHECK_OUT_CheckOutStatusId] DEFAULT ((0)) NULL,
    [CreatedDate]          DATETIME       CONSTRAINT [DF_CHECK_OUT_CreatedDate] DEFAULT (getdate()) NULL,
    [CreatedBy]            INT            CONSTRAINT [DF_CHECK_OUT_CreatedBy] DEFAULT ((0)) NULL,
    [UpdatedDate]          DATETIME       CONSTRAINT [DF_CHECK_OUT_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]            INT            CONSTRAINT [DF_CHECK_OUT_UpdatedBy] DEFAULT ((0)) NULL,
    [Notes]                VARCHAR (4000) NULL,
    CONSTRAINT [PK_CHECK_OUT] PRIMARY KEY CLUSTERED ([CheckOutId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CHECK_OUT_Unique]
    ON [dbo].[CHECK_OUT]([UserId] ASC, [CheckOutDate] ASC, [CheckOutStatusId] ASC);


GO
CREATE TRIGGER [dbo].[trCIAO_CHECK_OUT_UpdateInactive_Tablet] ON [dbo].[CHECK_OUT]
FOR INSERT
AS

DECLARE @tech int
DECLARE @dt datetime
DECLARE @name varchar(150)
DECLARE @net varchar(100)
DECLARE @ser varchar(50)
DECLARE @cby int
DECLARE @msg varchar(1500)
DECLARE @sub varchar(100)
DECLARE @To varchar(200)
DECLARE @CC varchar(200)

		
--INSERT INTO ACTIVITY_LOG(LogDescription) VALUES('updated running' + CAST(@flag as varchar(10)))

SELECT  @tech = UserId,
	@dt = CheckOutDate,
	@cby = CreatedBy
FROM inserted
		
		DECLARE cur CURSOR FAST_FORWARD FOR
		SELECT 
			TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName, 
			AST.NetworkName, 
			AST.SerialNumber
		FROM  ENET.dbo.TECHNICIAN AS TECH 
			INNER JOIN ENET.dbo.ASSET_ASSIGNMENT AS ASG 
			ON TECH.UserId = ASG.AssignedTo 
			INNER JOIN ENET.dbo.ASSET AS AST 
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
					SET @To = 'anthony.d.wells14.ctr@mail.mil;usn.jacksonville.navhospjaxfl.list.mid-tablet-issue@mail.mil'
					SET @Sub = '*** FOUO ***ENET DEACTIVATION ALERT'
					SET @CC = 'kristopher.s.kern.ctr@mail.mil'
					SET @Msg = 'This user has been assigned a portable asset and has been scheduled to check out: '

					SET @Msg = @Msg + CHAR(13) + CHAR(13)
					SET @Msg = @Msg + 'USER:'+ CHAR(9) + CHAR(9) + CHAR(9)
					SET @Msg = @Msg + @name

					SET @Msg = @Msg + CHAR(13) + CHAR(13)
					SET @Msg = @Msg + 'Check Out Date:'+ CHAR(9) + CHAR(9) + CHAR(9)
					SET @Msg = @Msg + @name

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
					SET @Msg = @Msg + 'User:' + CHAR(9)
					SET @Msg = @Msg + CAST(@tech AS varchar(10))

					SET @Msg = @Msg + CHAR(13) + CHAR(13)
					SET @Msg = @Msg + 'Created By:' + CHAR(9)
					SET @Msg = @Msg + CAST(@cby AS varchar(10))

					EXEC dbo.procCIO_SendMail_AssetAlert @sub, @msg, @To, @CC
						
					FETCH NEXT FROM cur INTO @name, @net, @ser
				END
			END
			CLOSE cur
			DEALLOCATE cur


GO
CREATE TRIGGER [dbo].[trCIAO_CHECK_OUT_Insert_ALT] ON [dbo].[CHECK_OUT]
FOR INSERT
AS

DECLARE @tech int
DECLARE @alt varchar(25)
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
		@dt = CheckOutDate
FROM inserted

SET @co = CAST(MONTH(@dt) AS varchar(2)) + '/' + CAST(DAY(@dt) AS varchar(2)) + '/' + CAST(YEAR(@dt) AS varchar(4))
	
	DECLARE cur CURSOR FAST_FORWARD FOR
	SELECT 
		TECH.ULName + ', ' + TECH.UFName + ' ' + TECH.UMName, 
		EXT.AltId
	FROM  dbo.vwENET_TECHNICIAN AS TECH 
		LEFT JOIN dbo.vwENET_TECHNICIAN_EXTENDED AS EXT
		ON TECH.UserId = EXT.UserId
	WHERE (TECH.UserId = @tech) 
		AND (EXT.HasAlt = 1)

	OPEN cur

	FETCH NEXT FROM cur INTO @name, @alt
	IF(@@FETCH_STATUS = 0)
		BEGIN

			WHILE(@@FETCH_STATUS = 0)
			BEGIN

				--Send Mail 
				SET @To = 'usn.jacksonville.navhospjaxfl.list.information-assurance-team@mail.mil'
				SET @Sub = 'FOUO: CIAO CHECKOUT ALERT - ALT CAC'
				SET @CC = 'kristopher.s.kern.ctr@mail.mil'
				SET @Msg = 'This user has been assigned an ALT CAC and is scheduled to check out: '

				SET @Msg = @Msg + CHAR(13) + CHAR(13)
				SET @Msg = @Msg + 'USER:'+ CHAR(9) + CHAR(9) + CHAR(9)
				SET @Msg = @Msg + @name

				SET @Msg = @Msg + CHAR(13)
				SET @Msg = @Msg + 'Last Day:'+ CHAR(9) 
				SET @Msg = @Msg + @co

				SET @Msg = @Msg + CHAR(13)
				SET @Msg = @Msg + 'Alt Id:'+ CHAR(9) 
				SET @Msg = @Msg + @alt
	
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
				SET @Msg = @Msg + 'User:' + CHAR(9)
				SET @Msg = @Msg + CAST(@tech AS varchar(10))

				EXEC ENET.dbo.procENET_SendMail_AssetAlert @sub, @msg, @To, @CC
			
				FETCH NEXT FROM cur INTO @name, @alt
			END
		END
		CLOSE cur
		DEALLOCATE cur
			

GO
CREATE TRIGGER [dbo].[trCIAO_CHECK_OUT_Insert_Tablet] ON [dbo].[CHECK_OUT]
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
		@dt = CheckOutDate
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
				SET @To = 'anthony.d.wells14.ctr@mail.mil;usn.jacksonville.navhospjaxfl.list.mid-tablet-issue@mail.mil'
				SET @Sub = 'CIAO CHECKOUT ALERT'
				SET @CC = 'kristopher.s.kern.ctr@mail.mil'
				SET @Msg = 'This user has been assigned a portable asset and is scheduled to check out: '

				SET @Msg = @Msg + CHAR(13) + CHAR(13)
				SET @Msg = @Msg + 'USER:'+ CHAR(9) + CHAR(9) + CHAR(9)
				SET @Msg = @Msg + @name

				SET @Msg = @Msg + CHAR(13)
				SET @Msg = @Msg + 'Last Day:'+ CHAR(9) 
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
				SET @Msg = @Msg + 'User:' + CHAR(9)
				SET @Msg = @Msg + CAST(@tech AS varchar(10))

				EXEC ENET.dbo.procENET_SendMail_AssetAlert @sub, @msg, @To, @CC
			
				FETCH NEXT FROM cur INTO @name, @net, @ser
			END
		END
		CLOSE cur
		DEALLOCATE cur
			
