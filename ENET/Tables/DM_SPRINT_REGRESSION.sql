CREATE TABLE [dbo].[DM_SPRINT_REGRESSION] (
    [SessionKey]           VARCHAR (50)    NULL,
    [SprintCycleId]        BIGINT          NULL,
    [CreatedDate]          DATETIME        CONSTRAINT [DF_DM_SPRINT_REGRESSION_CreatedDate] DEFAULT (getdate()) NULL,
    [EstimatedHours]       DECIMAL (18, 2) NULL,
    [HoursRemaining]       DECIMAL (18, 2) NULL,
    [HoursCompleted]       DECIMAL (18, 2) NULL,
    [ActualHours]          DECIMAL (18, 2) NULL,
    [SprintHoursRemaining] DECIMAL (18, 2) NULL,
    [SprintHoursCompleted] DECIMAL (18, 2) NULL,
    [SprintActualHours]    DECIMAL (18, 2) NULL,
    [EstimatedHoursChange] DECIMAL (18, 2) NULL,
    [CompletedHoursChange] DECIMAL (18, 2) NULL,
    [Gap]                  DECIMAL (18)    NULL,
    [SystemId]             INT             NULL,
    [EndDate]              BIGINT          CONSTRAINT [DF_DM_SPRINT_REGRESSION_EndDate] DEFAULT ((0)) NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_DM_SPRINT_REGRESSION_MultiKey]
    ON [dbo].[DM_SPRINT_REGRESSION]([SessionKey] ASC, [SprintCycleId] ASC, [SystemId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DM_SPRINT_REGRESSION_SessionKey]
    ON [dbo].[DM_SPRINT_REGRESSION]([SessionKey] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DM_SPRINT_REGRESSION_SessionKey_SprintCycleId]
    ON [dbo].[DM_SPRINT_REGRESSION]([SessionKey] ASC, [SprintCycleId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DM_SPRINT_REGRESSION_SprintCycleId]
    ON [dbo].[DM_SPRINT_REGRESSION]([SprintCycleId] ASC);

