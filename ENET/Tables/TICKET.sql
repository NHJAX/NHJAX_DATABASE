CREATE TABLE [dbo].[TICKET] (
    [TicketId]        INT             IDENTITY (0, 1) NOT NULL,
    [TicketNumber]    VARCHAR (50)    NOT NULL,
    [ProblemTypeId]   INT             CONSTRAINT [DF_TICKET_ProblemTypeId] DEFAULT ((48)) NOT NULL,
    [SystemNameId]    INT             CONSTRAINT [DF_TICKET_SystemNameId] DEFAULT ((162)) NOT NULL,
    [PatientImpact]   BIT             CONSTRAINT [DF_TICKET_PatientImpact] DEFAULT ((0)) NOT NULL,
    [PlantAccountNum] VARCHAR (50)    NULL,
    [SoftwareId]      INT             CONSTRAINT [DF_TICKET_SoftwareId] DEFAULT ((8)) NOT NULL,
    [DepartmentId]    INT             CONSTRAINT [DF_TICKET_DepartmentId] DEFAULT ((168)) NOT NULL,
    [TicketLocation]  VARCHAR (50)    NULL,
    [Comments]        TEXT            NOT NULL,
    [CreatedFor]      INT             CONSTRAINT [DF_TICKET_CreatedFor] DEFAULT ((0)) NOT NULL,
    [CreatedDate]     DATETIME        CONSTRAINT [DF_TICKET_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [AssignedBy]      INT             CONSTRAINT [DF_TICKET_AssignedBy] DEFAULT ((0)) NOT NULL,
    [AssignedDate]    DATETIME        CONSTRAINT [DF_TICKET_AssignedDate] DEFAULT (getdate()) NOT NULL,
    [StatusId]        INT             CONSTRAINT [DF_TICKET_StatusId] DEFAULT ((1)) NOT NULL,
    [ClosedDate]      DATETIME        NULL,
    [ClosedBy]        INT             NULL,
    [CustomerName]    VARCHAR (50)    NULL,
    [UpdatedDate]     DATETIME        CONSTRAINT [DF_TICKET_UpdatedDate] DEFAULT (getdate()) NULL,
    [UpdatedBy]       INT             NULL,
    [OpenDate]        DATETIME        CONSTRAINT [DF_TICKET_OpenDate] DEFAULT (getdate()) NULL,
    [PriorityId]      INT             CONSTRAINT [DF_TICKET_PriorityId] DEFAULT ((0)) NULL,
    [EstimatedHours]  DECIMAL (18, 2) CONSTRAINT [DF_TICKET_EstimatedHours] DEFAULT ((0)) NULL,
    [AudienceId]      BIGINT          CONSTRAINT [DF_TICKET_AudienceId] DEFAULT ((0)) NULL,
    [CreatedBy]       INT             CONSTRAINT [DF_TICKET_CreatedBy] DEFAULT ((0)) NULL,
    [SwitchId]        INT             CONSTRAINT [DF_TICKET_SwitchId] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_TICKET] PRIMARY KEY CLUSTERED ([TicketId] ASC),
    CONSTRAINT [FK_TICKET_DEPARTMENT] FOREIGN KEY ([DepartmentId]) REFERENCES [dbo].[DEPARTMENT_20080612] ([DepartmentId]),
    CONSTRAINT [FK_TICKET_PRIORITY] FOREIGN KEY ([PriorityId]) REFERENCES [dbo].[PRIORITY] ([PriorityId]),
    CONSTRAINT [FK_TICKET_PROBLEM_TYPE] FOREIGN KEY ([ProblemTypeId]) REFERENCES [dbo].[PROBLEM_TYPE] ([ProblemTypeId]),
    CONSTRAINT [FK_TICKET_SOFTWARE_NAME] FOREIGN KEY ([SoftwareId]) REFERENCES [dbo].[SOFTWARE_NAME] ([SoftwareId]),
    CONSTRAINT [FK_TICKET_SYSTEM_TYPE] FOREIGN KEY ([SystemNameId]) REFERENCES [dbo].[SYSTEM_TYPE] ([SystemId]),
    CONSTRAINT [FK_TICKET_TECHNICIAN] FOREIGN KEY ([CreatedFor]) REFERENCES [dbo].[TECHNICIAN] ([UserId]),
    CONSTRAINT [FK_TICKET_TECHNICIAN1] FOREIGN KEY ([AssignedBy]) REFERENCES [dbo].[TECHNICIAN] ([UserId]),
    CONSTRAINT [FK_TICKET_TECHNICIAN2] FOREIGN KEY ([ClosedBy]) REFERENCES [dbo].[TECHNICIAN] ([UserId]),
    CONSTRAINT [FK_TICKET_TICKET_STATUS] FOREIGN KEY ([StatusId]) REFERENCES [dbo].[TICKET_STATUS] ([StatusId])
);


GO
CREATE NONCLUSTERED INDEX [IX_TICET_CreatedDate]
    ON [dbo].[TICKET]([CreatedDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TICKET_CreatedDate_StatusId]
    ON [dbo].[TICKET]([CreatedDate] ASC, [StatusId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TICKET_CreatedFor_CreatedDate]
    ON [dbo].[TICKET]([CreatedFor] ASC, [CreatedDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TICKET_MultiKey]
    ON [dbo].[TICKET]([CreatedFor] ASC, [CreatedDate] ASC, [StatusId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TICKET_StatusId]
    ON [dbo].[TICKET]([StatusId] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TICKET_TICKETNUMBER]
    ON [dbo].[TICKET]([TicketNumber] ASC);


GO


create TRIGGER [dbo].[trENet_Ticket_InsertAudienceId] ON [dbo].[TICKET]
FOR INSERT
AS

DECLARE @dept int
DECLARE @deptnew int
DECLARE @tkt int
DECLARE @aud bigint
Declare @exists int
DECLARE @flag bit 

--only run this update if it is department that is updated
IF NOT UPDATE(DepartmentId)
	BEGIN
		--INSERT INTO ACTIVITY_LOG(LogDescription) VALUES('not updated')
		SET @flag = 1
	END
ELSE
	BEGIN
		SET @flag = 0
	END

--INSERT INTO ACTIVITY_LOG(LogDescription) VALUES('inserted running' + CAST(@flag as varchar(10)))

IF @flag = 0 
BEGIN
	SELECT @dept = TKT.DepartmentId, @tkt = TKT.TicketId,
	@deptnew = ISNULL(TKT.AudienceId,0)
	FROM inserted AS TKT
	
	IF @deptnew = 0
		BEGIN
			SELECT	TOP 1 @aud = AudienceId
			FROM	AUDIENCE
			WHERE	(OldDepartmentId = @dept)
			AND AudienceCategoryId = 3
			SET @exists = @@RowCount


			If @exists = 0 
				BEGIN
					UPDATE TICKET
					SET AudienceId = 0
					WHERE TicketId = @tkt
				END
			ELSE
				BEGIN
					UPDATE TICKET
					SET AudienceId = @aud
					WHERE TicketId = @tkt
				END
		END
END







GO
DISABLE TRIGGER [dbo].[trENet_Ticket_InsertAudienceId]
    ON [dbo].[TICKET];


GO
CREATE TRIGGER [dbo].[trENet_TICKET_Update] ON [dbo].[TICKET]
FOR INSERT,UPDATE
AS


DECLARE		@tkt int 
DECLARE		@num varchar(50) 
DECLARE		@prob int
DECLARE		@sys int
DECLARE		@pi bit 
DECLARE		@pa varchar(50)
DECLARE		@sft int
DECLARE		@loc varchar(50)
DECLARE		@com varchar(8000)
DECLARE		@c4 int
DECLARE		@cdate datetime
DECLARE		@aby int 
DECLARE		@adate datetime
DECLARE		@stat int 
DECLARE		@cldate datetime
DECLARE		@clby int 
DECLARE		@cust varchar(50) 
DECLARE		@udate datetime
DECLARE		@uby int
DECLARE		@odate datetime
DECLARE		@pri int
DECLARE		@est decimal(18,2)
DECLARE		@aud bigint
DECLARE		@cby int
DECLARE		@hby int


BEGIN

	SELECT     
		@tkt = TicketId, 
		@num = TicketNumber, 
		@prob = ProblemTypeId, 
		@sys = SystemNameId, 
		@pi = PatientImpact, 
		@pa = PlantAccountNum, 
		@sft = SoftwareId, 
		@loc = TicketLocation, 
		@c4 = CreatedFor, 
		@cdate = CreatedDate, 
		@aby = AssignedBy, 
		@adate = AssignedDate, 
		@stat = StatusId, 
		@cldate = ClosedDate, 
		@clby = ClosedBy, 
		@cust = CustomerName, 
		@udate = UpdatedDate, 
		@uby = UpdatedBy, 
		@odate = OpenDate, 
		@pri = PriorityId,
		@est = EstimatedHours, 
		@aud = AudienceId, 
		@cby = CreatedBy,
		@hby = UpdatedBy
	FROM inserted 


		INSERT INTO TICKET_HISTORY
		(
			TicketId, 
			TicketNumber, 
			ProblemTypeId, 
			SystemNameId, 
			PatientImpact, 
			PlantAccountNum, 
			SoftwareId, 
			TicketLocation, 
			CreatedFor, 
			CreatedDate, 
			AssignedBy, 
			AssignedDate, 
			StatusId, 
			ClosedDate, 
			ClosedBy, 
			CustomerName, 
			UpdatedDate, 
			UpdatedBy, 
			OpenDate, 
			PriorityId,
			EstimatedHours, 
			AudienceId, 
			CreatedBy,
			HistoryBy
		)
		VALUES     
		(
			@tkt,
			@num, 
			@prob, 
			@sys, 
			@pi, 
			@pa, 
			@sft, 
			@loc, 
			@c4, 
			@cdate, 
			@aby, 
			@adate, 
			@stat, 
			@cdate, 
			@cby, 
			@cust, 
			@udate, 
			@uby, 
			@odate, 
			@pri,
			@est, 
			@aud, 
			@cby,
			@hby
		)
	

SELECT @com = CAST(Comments AS varchar(8000))
FROM TICKET
WHERE TicketId = @tkt

UPDATE TICKET_HISTORY
SET Comments = @com
WHERE TicketId = @tkt

END


GO


CREATE TRIGGER [dbo].[trENet_Ticket_UpdateAudienceId] ON [dbo].[TICKET]
FOR UPDATE
AS

DECLARE @dept int
DECLARE @deptnew int
DECLARE @tkt int
DECLARE @aud bigint
Declare @exists int
DECLARE @flag bit 

--If it is not the departmentid changing, then only update if
--audienceid is not set

IF NOT UPDATE(DepartmentId)
	BEGIN
		--INSERT INTO ACTIVITY_LOG(LogDescription) VALUES('not updated')
		SET @flag = 1
	END
ELSE
	BEGIN
		SET @flag = 0
	END

SELECT @dept = TKT.DepartmentId, @tkt = TKT.TicketId,
@deptnew = TICKET.AudienceId
FROM inserted AS TKT
INNER JOIN TICKET 
ON TKT.TicketId = TICKET.TicketId

If @deptnew IS NULL OR @deptnew = 0 OR @flag = 0
	BEGIN
		SELECT	TOP 1 @aud = AudienceId
		FROM	AUDIENCE
		WHERE	(OldDepartmentId = @dept)
		AND AudienceCategoryId = 3
		SET @exists = @@RowCount


		If @exists = 0 
			BEGIN
				UPDATE TICKET
				SET AudienceId = 0
				WHERE TicketId = @tkt
			END
		ELSE
			BEGIN
				UPDATE TICKET
				SET AudienceId = @aud
				WHERE TicketId = @tkt
			END
	END






GO
DISABLE TRIGGER [dbo].[trENet_Ticket_UpdateAudienceId]
    ON [dbo].[TICKET];

