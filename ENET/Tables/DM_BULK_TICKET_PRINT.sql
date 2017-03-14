CREATE TABLE [dbo].[DM_BULK_TICKET_PRINT] (
    [SessionKey]         VARCHAR (50)  NULL,
    [TicketNumber]       VARCHAR (50)  NULL,
    [TicketId]           INT           NULL,
    [TicketLocation]     VARCHAR (50)  NULL,
    [SystemDesc]         VARCHAR (50)  NULL,
    [ProblemTypeDesc]    VARCHAR (50)  NULL,
    [PatientImpact]      VARCHAR (3)   NULL,
    [UserAlpha]          VARCHAR (150) NULL,
    [CreatedDate]        DATETIME      NULL,
    [AudienceDesc]       VARCHAR (50)  NULL,
    [OrgChartCode]       VARCHAR (20)  NULL,
    [UserPhone]          VARCHAR (50)  NULL,
    [UserExtension]      VARCHAR (50)  NULL,
    [AsgPhone]           VARCHAR (50)  NULL,
    [AsgExtension]       VARCHAR (50)  NULL,
    [ClsPhone]           VARCHAR (50)  NULL,
    [ClsExtension]       VARCHAR (50)  NULL,
    [PlantAccountNumber] VARCHAR (50)  NULL,
    [AssignedTo]         INT           NULL,
    [UserTitle]          VARCHAR (50)  NULL,
    [UserEMail]          VARCHAR (100) NULL,
    [UserAudienceDesc]   VARCHAR (50)  NULL,
    [UserOrgChartCode]   VARCHAR (20)  NULL,
    [UserLocation]       VARCHAR (100) NULL,
    [CreatedFor]         INT           NULL,
    [AsgClosedDate]      DATETIME      NULL,
    [AssignedDate]       DATETIME      NULL,
    [Comments]           TEXT          NULL,
    [AsgAlpha]           VARCHAR (150) NULL,
    [AsgEMail]           VARCHAR (100) NULL,
    [ClsAlpha]           VARCHAR (150) NULL,
    [ClsEMail]           VARCHAR (100) NULL,
    [DMCreatedDate]      DATETIME      CONSTRAINT [DF_DM_BULK_TICKET_PRINT_DMCreatedDate] DEFAULT (getdate()) NULL,
    [StatusId]           INT           NULL,
    [Remarks]            TEXT          NULL,
    [OpenDate]           DATETIME      NULL,
    [DisplayName]        VARCHAR (50)  NULL,
    [UserDisplayName]    VARCHAR (50)  NULL,
    [PriorityId]         INT           NULL,
    [SoftwareDesc]       VARCHAR (50)  NULL
);


GO
CREATE CLUSTERED INDEX [IX_DM_BULK_TICKET_PRINT_SessionKey]
    ON [dbo].[DM_BULK_TICKET_PRINT]([SessionKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DM_BULK_TICKET_PRINT_OpenDate]
    ON [dbo].[DM_BULK_TICKET_PRINT]([OpenDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DM_BULK_TICKET_PRINT_ProblemTypeDesc]
    ON [dbo].[DM_BULK_TICKET_PRINT]([ProblemTypeDesc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DM_BULK_TICKET_PRINT_SystemDesc]
    ON [dbo].[DM_BULK_TICKET_PRINT]([SystemDesc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DM_BULK_TICKET_PRINT_TicketNumber]
    ON [dbo].[DM_BULK_TICKET_PRINT]([TicketNumber] ASC);

