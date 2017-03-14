CREATE TABLE [dbo].[TICKET_ASSIGNMENT] (
    [AssignmentId]   INT             IDENTITY (1, 1) NOT NULL,
    [AssignedTo]     INT             NULL,
    [AssignedBy]     INT             NULL,
    [StatusId]       INT             CONSTRAINT [DF_TICKET_ASSIGNMENT_StatusId] DEFAULT ((2)) NULL,
    [AssignmentDate] DATETIME        CONSTRAINT [DF_TICKET_ASSIGNMENT_AssignmentDate] DEFAULT (getdate()) NULL,
    [ClosedDate]     DATETIME        NULL,
    [ClosedBy]       INT             NULL,
    [TicketId]       INT             NULL,
    [Remarks]        TEXT            NULL,
    [Hours]          DECIMAL (18, 2) CONSTRAINT [DF_TICKET_ASSIGNMENT_Hours] DEFAULT ((0)) NULL,
    [HoursToClose]   INT             CONSTRAINT [DF_TICKET_ASSIGNMENT_HoursToClose2] DEFAULT ((0)) NULL,
    [DaysToClose]    INT             CONSTRAINT [DF_TICKET_ASSIGNMENT_DaysToClose2] DEFAULT ((0)) NULL,
    [TierId]         INT             CONSTRAINT [DF_TICKET_ASSIGNMENT_TierId] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_TICKET_ASSIGNMENT] PRIMARY KEY CLUSTERED ([AssignmentId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_TICKET_ASSIGNMENT_AssignedTo]
    ON [dbo].[TICKET_ASSIGNMENT]([AssignedTo] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TICKET_ASSIGNMENT_TicketId]
    ON [dbo].[TICKET_ASSIGNMENT]([TicketId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TICKET_ASSIGNMENT_StatusId]
    ON [dbo].[TICKET_ASSIGNMENT]([StatusId] ASC);


GO


CREATE TRIGGER [dbo].[trENet_Ticket_Assignment_UpdateClose] ON [dbo].[TICKET_ASSIGNMENT]
FOR INSERT, UPDATE
AS

DECLARE @hr2c int
DECLARE @dy2c int
DECLARE @tkt int
DECLARE @adt datetime
Declare @cdt datetime


--only run this update if closed date added/changed
IF UPDATE(ClosedDate)
	BEGIN
		SELECT @tkt = AssignmentId,
			@adt = AssignmentDate,
			@cdt = ClosedDate
		FROM inserted
		
		--INSERT INTO ACTIVITY_LOG(LogDescription) VALUES(@tkt)
		--INSERT INTO ACTIVITY_LOG(LogDescription) VALUES(@adt)
		--INSERT INTO ACTIVITY_LOG(LogDescription) VALUES(@cdt)
		--INSERT INTO ACTIVITY_LOG(LogDescription) VALUES(datediff(hour,@adt,@cdt)/(3))
		--INSERT INTO ACTIVITY_LOG(LogDescription) VALUES(datediff(day,@adt,@cdt))
		
		UPDATE TICKET_ASSIGNMENT
		SET HoursToClose = datediff(hour,@adt,@cdt)/(3)
		WHERE AssignmentId = @tkt
		
		UPDATE TICKET_ASSIGNMENT
		SET DaysToClose = datediff(day,@adt,@cdt)
		WHERE AssignmentId = @tkt
	END

GO
create TRIGGER [dbo].[ENET_TICKET_BrysonAHLTA]
   ON  [dbo].[TICKET_ASSIGNMENT]
   FOR INSERT
AS 

DECLARE @usr int
DECLARE @tkt varchar(50)
DECLARE @ptyp int
DECLARE @sys int
DECLARE @msg varchar(1500)
DECLARE @sub varchar(100)
DECLARE @To varchar(2000)
DECLARE @CC varchar(200)
DECLARE @mail varchar(101)
--DECLARE @site varchar(100)
--DECLARE @url nvarchar(1000)
--DECLARE @sites varchar(4000)

IF UPDATE(AssignedTo)
	BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;
	SELECT
		@usr = TA.AssignedTo, 
		@tkt = TKT.TicketNumber, 
		@ptyp = TKT.ProblemTypeId,
		@sys = TKT.SystemNameId
	FROM inserted AS TA 
		INNER JOIN TICKET AS TKT 
		ON TA.TicketId = TKT.TicketId 
	
	IF @usr IN(181)
		BEGIN
			IF @ptyp IN (45,57,66,88) OR @sys IN (1,46,120,228,271)
			BEGIN	
				SET @To = 'NHJAXCHCSII@med.navy.mil'
					
				SET @Sub = 'BRYSON TICKET ASSIGNMENT'
				--SET @CC = ''
				SET @cc = 'sean.kern.ctr@med.navy.mil'
				SET @Msg = 'Ticket Number ' + @tkt + ' has been assigned.'

				SET @Msg = @Msg + CHAR(13) + CHAR(13)

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

				----TESTING ONLY - Display Database Info
				--SET @Msg = @Msg + CHAR(13) + CHAR(13)
				--SET @Msg = @Msg + '****OFFICE USE****' + CHAR(13)
				--SET @Msg = @Msg + 'User:' + CHAR(9)
				--SET @Msg = @Msg + CAST(@usr	AS varchar(10))

				EXEC dbo.procENET_SendMail_TechnicianUpdate @sub, @msg, @To, @CC
			END
		END
	END
